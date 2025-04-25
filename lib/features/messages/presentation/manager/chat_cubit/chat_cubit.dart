import 'package:chat/features/messages/domain/entities/chat_entity.dart';
import 'package:chat/features/messages/domain/repositories/message_repository.dart';
import 'package:chat/features/messages/presentation/manager/chat_cubit/chat_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _messageRepository;

  ChatCubit({required ChatRepository messageRepository})
      : _messageRepository = messageRepository,
        super(const ChatInitialState());

  Future<void> getChats() async {
    emit(const ChatLoadingState());

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      emit(const ChatErrorState('User not authenticated'));
      return;
    }

    final result = await _messageRepository.getChats(currentUser.uid);

    result.fold(
      (failure) => emit(ChatErrorState(failure.message)),
      (chats) => emit(ChatsLoadedState(chats)),
    );
  }

  Future<void> createChat(String email) async {
    emit(const ChatLoadingState());

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      emit(const ChatErrorState('User not authenticated'));
      return;
    }

    final result = await _messageRepository.createChat(email);

    result.fold(
      (failure) => emit(ChatErrorState(failure.message)),
      (chatId) => emit(ChatCreatedState(chatId)),
    );
  }

  Stream<List<ChatEntity>> chatStream() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      emit(const ChatErrorState('User not authenticated'));
      return Stream.value([]);
    }

    return _messageRepository.chatsStream(currentUser.uid);
  }
}
