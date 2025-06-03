import 'dart:developer';

import 'package:chat/core/errors/failures.dart';
import 'package:chat/core/service/time_service.dart';
import 'package:chat/core/utils/endpoints.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:chat/features/chats/data/models/chat_model.dart';
import 'package:chat/features/chats/domain/entities/chat_entity.dart';
import 'package:chat/features/chats/domain/repositories/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore firestore;
  final TimeService timeService;
  final FirebaseAuth firebaseAuth;

  ChatRepositoryImpl({
    required this.firestore,
    required this.timeService,
    required this.firebaseAuth,
  });

  @override
  Future<Either<Failure, List<ChatEntity>>> getChats(String userId) async {
    try {
      final chatsRef = firestore.collection(Endpoints.chats);
      final query = chatsRef.where('participants', arrayContains: userId);

      final snapshot = await query.get();
      final chats = <ChatEntity>[];

      for (var doc in snapshot.docs) {
        final chatData = {...doc.data(), 'id': doc.id};
        final otherUserId =
            _getOtherParticipantId(chatData['participants'], userId);
        final otherUser = await _fetchUserInfo(otherUserId);

        chats.add(ChatModel.fromJson(chatData, otherUser: otherUser));
      }

      return Right(chats);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  String _getOtherParticipantId(
      List<dynamic> participants, String currentUserId) {
    return participants.firstWhere(
      (id) => id != currentUserId,
      orElse: () => participants.isNotEmpty ? participants.first : '',
    );
  }

  Future<UserEntity?> _fetchUserInfo(String userId) async {
    try {
      final userDoc =
          await firestore.collection(Endpoints.users).doc(userId).get();
      if (userDoc.exists) {
        final userData = {...userDoc.data()!};
        return UserModel.fromJson(userData);
      }
      return null;
    } catch (e) {
      log('Error fetching user info: $e');
      return null;
    }
  }

  @override
  Future<Either<Failure, String>> createChat(String email) async {
    final query =
        firestore.collection(Endpoints.users).where('email', isEqualTo: email);
    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return Left(ServerFailure('User not found'));
    }
    final userId = snapshot.docs.first.id;
    final myId = await getCurrentUserId();
    List<String> participants = [userId, myId]..sort();
    final chatRef = firestore.collection(Endpoints.chats);
    final chatDoc = await chatRef.doc(participants.join('_')).get();
    if (chatDoc.exists) {
      return Left(ServerFailure('Chat already exists'));
    }
    final chatData = ChatModel(
      id: participants.join('_'),
      participants: participants,
      lastMessage: '',
      lastMessageTime: timeService.getNowTimestamp(),
      lastSenderId: '',
      createdAt: timeService.getNowTimestamp(),
    );
    await chatRef.doc(chatData.id).set(chatData.toJson());
    return Right(chatData.id);
  }

  @override
  Stream<List<ChatEntity>> chatsStream(String userId) {
    return firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final chats = <ChatEntity>[];

      for (var doc in snapshot.docs) {
        final chatData = {...doc.data(), 'id': doc.id};
        final otherUserId =
            _getOtherParticipantId(chatData['participants'], userId);
        final otherUser = await _fetchUserInfo(otherUserId);

        chats.add(ChatModel.fromJson(chatData, otherUser: otherUser));
      }

      return chats;
    });
  }

  @override
  Stream<int> unreadMessagesCountStream(String chatId, String currentUserId) {
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .snapshots()
        .map((snapshot) {
      // Filter out messages that are unread and not from the current user
      final unreadMessages = snapshot.docs
          .map((doc) => doc.data())
          .where((data) => data['isRead'] == false)
          .where((data) => data['fromId'] != currentUserId)
          .toList();

      return unreadMessages.length;
    });
  }

  @override
  Future<String> getCurrentUserId() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not found');
    }
    return user.uid;
  }
}
