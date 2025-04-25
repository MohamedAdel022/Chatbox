import 'package:chat/core/errors/failures.dart';
import 'package:chat/features/messages/data/models/chat_model.dart';
import 'package:chat/features/messages/domain/entities/chat_entity.dart';
import 'package:chat/features/messages/domain/repositories/message_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore firestore;

  ChatRepositoryImpl(this.firestore);

  @override
  Future<Either<Failure, List<ChatEntity>>> getChats(String userId) async {
    try {
      final chatsRef = firestore.collection('chats');
      final query = chatsRef.where('participants', arrayContains: userId);

      final snapshot = await query.get();
      final chats = snapshot.docs
          .map((doc) => ChatModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();

      return Right(chats);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createChat(String email) async {
    final query = firestore.collection('users').where('email', isEqualTo: email);
    final snapshot = await query.get();
    
    if (snapshot.docs.isEmpty) {
      return Left(ServerFailure('User not found'));
    }
    final userId = snapshot.docs.first.id;
    final myId = await getCurrentUserId();
    List<String> participants = [userId, myId]..sort();
    final chatRef = firestore.collection('chats');
    final chatDoc = await chatRef.doc(participants.join('_')).get();
    if (chatDoc.exists) {
      return Left(ServerFailure('Chat already exists'));
    }
    final chatData = ChatModel(
      id: participants.join('_'),
      participants: participants,
      lastMessage: '',
      lastMessageTime: DateTime.now().toIso8601String(),
      lastSenderId: '',
      unreadCount: 0,
      createdAt: DateTime.now().toIso8601String(),
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
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }
  
  @override
  Future<String> getCurrentUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not found');
    }
    return user.uid;
  }

  
}
