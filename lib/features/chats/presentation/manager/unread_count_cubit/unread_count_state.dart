import 'package:equatable/equatable.dart';

abstract class UnreadCountState extends Equatable {
  const UnreadCountState();

  @override
  List<Object?> get props => [];
}

class UnreadCountInitial extends UnreadCountState {
  const UnreadCountInitial();
}

class UnreadCountLoaded extends UnreadCountState {
  final Map<String, int> chatCounts;
  
  // Total count across all chats
  int get totalCount => chatCounts.values.fold<int>(0, (sum, count) => sum + count);
  
  // Get count for a specific chat
  int getCountFor(String chatId) => chatCounts[chatId] ?? 0;

  const UnreadCountLoaded(this.chatCounts);

  @override
  List<Object?> get props => [chatCounts];
}
