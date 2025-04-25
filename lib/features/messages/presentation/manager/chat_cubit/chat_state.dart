import 'package:chat/features/messages/domain/entities/chat_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitialState extends ChatState {
  const ChatInitialState();
}

class ChatLoadingState extends ChatState {
  const ChatLoadingState();
}

class ChatErrorState extends ChatState {
  final String message;

  const ChatErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatsLoadedState extends ChatState {
  final List<ChatEntity> chats;

  const ChatsLoadedState(this.chats);

  @override
  List<Object?> get props => [chats];
}

class ChatCreatedState extends ChatState {
  final String chatId;

  const ChatCreatedState(this.chatId);

  @override
  List<Object?> get props => [chatId];
}
