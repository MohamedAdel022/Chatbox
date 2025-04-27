import 'dart:async';
import 'package:chat/features/chats/domain/entities/chat_entity.dart';
import 'package:chat/features/chats/domain/repositories/chat_repository.dart';
import 'package:chat/features/chats/presentation/manager/chat_cubit/chat_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _messageRepository;
  StreamSubscription<List<ChatEntity>>? _chatSubscription;
  bool _initialized = false;

  ChatCubit({required ChatRepository messageRepository})
      : _messageRepository = messageRepository,
        super(const ChatInitialState()) {
    // Start listening to the chat stream as soon as the cubit is created
    _startChatStream();
  }

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
    
    // After creating a new chat, refresh the chat list
    _startChatStream();
  }

  void _startChatStream() {
    // If we already have an active subscription, don't create a new one
    if (_chatSubscription != null && _initialized) {
      return;
    }
    
    // Cancel any existing subscription to avoid memory leaks
    _chatSubscription?.cancel();
    _chatSubscription = null;
    
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      emit(const ChatErrorState('User not authenticated'));
      return;
    }

    // Subscribe to the chat stream and emit states based on the stream events
    _chatSubscription = _messageRepository.chatsStream(currentUser.uid).listen(
      (chats) {
        emit(ChatsLoadedState(chats));
        _initialized = true;
      },
      onError: (error) {
        emit(ChatErrorState(error.toString()));
        _initialized = false;
      },
    );
  }
  
  void refreshChats() {
    // Force a refresh by resetting the initialization flag
    _initialized = false;
    // Restart the stream to refresh chats
    _startChatStream();
  }

  @override
  Future<void> close() {
    // Clean up subscription when cubit is closed
    _chatSubscription?.cancel();
    _initialized = false;
    return super.close();
  }
}
