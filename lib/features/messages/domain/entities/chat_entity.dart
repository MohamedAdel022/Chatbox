class ChatEntity {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final String lastMessageTime;
  final String lastSenderId;
  final int unreadCount;
  final String createdAt;

  ChatEntity({required this.createdAt, 
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastSenderId,
    required this.unreadCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastSenderId': lastSenderId,
      'unreadCount': unreadCount,
    };
  }
}
