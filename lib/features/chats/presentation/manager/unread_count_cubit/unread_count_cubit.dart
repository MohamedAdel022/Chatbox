import 'dart:async';
import 'package:chat/features/chats/domain/repositories/chat_repository.dart';
import 'package:chat/features/chats/presentation/manager/unread_count_cubit/unread_count_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnreadCountCubit extends Cubit<UnreadCountState> {
  final ChatRepository _chatRepository;
  final FirebaseAuth _firebaseAuth;
  // To track active subscriptions for each chat
  final Map<String, StreamSubscription<int>> _subscriptions = {};
  // To store the unread count for each chat
  final Map<String, int> _counts = {};

  // ValueNotifier to track the currently selected chat ID
  final ValueNotifier<String?> currentChatId = ValueNotifier<String?>(null);

  UnreadCountCubit({
    required ChatRepository chatRepository,
    required FirebaseAuth firebaseAuth,
  })  : _chatRepository = chatRepository,
        _firebaseAuth = firebaseAuth,
        super(const UnreadCountInitial()) {
    // Listen for changes to currentChatId
    currentChatId.addListener(_onCurrentChatChanged);
  }

  // Start tracking a specific chat ID
  void trackChat(String chatId) {
    if (_subscriptions.containsKey(chatId)) {
      // Already tracking this chat
      return;
    }

    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return;

    // Set initial count to 0 and emit immediately to avoid UI waiting
    _counts[chatId] = 0;
    _emitUpdatedState();

    // Start a new subscription for this chat
    _subscriptions[chatId] = _chatRepository
        .unreadMessagesCountStream(chatId, currentUser.uid)
        .listen(
      (unreadCount) {
        _counts[chatId] = unreadCount;
        _emitUpdatedState();
      },
      onError: (error) {
        debugPrint('Error tracking unread count for $chatId: $error');
      },
    );
  }

  // Stop tracking a specific chat
  void stopTrackingChat(String chatId) {
    _subscriptions[chatId]?.cancel();
    _subscriptions.remove(chatId);
    _counts.remove(chatId);
  }

  // Set the currently selected chat (for UI to know which count to show)
  void setCurrentChat(String chatId) {
    currentChatId.value = chatId;
    trackChat(chatId); // Ensure we're tracking this chat
  }

  // Get count for a specific chat
  int getUnreadCountFor(String chatId) {
    return _counts[chatId] ?? 0;
  }

  // Private method to emit state updates
  void _emitUpdatedState() {
    // Create a copy of the current counts map
    emit(UnreadCountLoaded(Map<String, int>.from(_counts)));
  }

  // Refresh tracking for all chats
  void refresh() {
    final currentChats = {..._subscriptions.keys};

    // Stop all existing subscriptions
    for (final chatId in currentChats) {
      stopTrackingChat(chatId);
      trackChat(chatId);
    }
  }

  // Add a new method to track multiple chats at once for efficiency
  void trackMultipleChats(List<String> chatIds) {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return;

    // Track all new chats at once
    bool didAddNewChat = false;
    for (final chatId in chatIds) {
      if (!_subscriptions.containsKey(chatId)) {
        _counts[chatId] = 0; // Initialize with 0
        didAddNewChat = true;

        // Create subscription
        _subscriptions[chatId] = _chatRepository
            .unreadMessagesCountStream(chatId, currentUser.uid)
            .listen(
          (unreadCount) {
            _counts[chatId] = unreadCount;
            _emitUpdatedState();
          },
          onError: (error) {
            debugPrint('Error tracking unread count for $chatId: $error');
          },
        );
      }
    }

    // Only emit once for all the chats we just tracked
    if (didAddNewChat) {
      _emitUpdatedState();
    }
  }

  // Callback when currentChatId changes
  void _onCurrentChatChanged() {
    final chatId = currentChatId.value;

    // If we're leaving a chat (chatId becomes null), refresh all tracked chats
    if (chatId == null && _subscriptions.isNotEmpty) {
      refresh();
    }
  }

  @override
  Future<void> close() {
    // Remove the listener to avoid memory leaks
    currentChatId.removeListener(_onCurrentChatChanged);

    // Cancel all subscriptions
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
    _subscriptions.clear();
    _counts.clear();
    return super.close();
  }
}
