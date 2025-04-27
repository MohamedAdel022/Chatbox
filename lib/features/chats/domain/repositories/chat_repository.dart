import 'package:dartz/dartz.dart';
import 'package:chat/core/errors/failures.dart';
import 'package:chat/features/chats/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  // Chat methods
  Future<Either<Failure, List<ChatEntity>>> getChats(String userId);
  Future<Either<Failure, String>> createChat(String email);

  // Stream methods
  Stream<List<ChatEntity>> chatsStream(String userId);
  Future<String> getCurrentUserId();
  

}

