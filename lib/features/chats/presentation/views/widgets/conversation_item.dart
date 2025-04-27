import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:chat/features/chats/domain/entities/chat_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConversationItem extends StatelessWidget {
  final ChatEntity chat;

  const ConversationItem({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    // Get the other participant's name directly from the otherUserInfo field
    final displayName =
        chat.otherUserInfo?.name ?? "Chat ${chat.id.substring(0, 4)}";

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 28.r,
        backgroundImage: AssetImage(Assets.imagesTest),
      ),
      title: Text(
        displayName,
        style: const TextStyle(
          color: Color(0xFF000D07),
          fontSize: 20,
          fontFamily: 'Caros',
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      ),
      subtitle: Text(
        chat.lastMessage,
        style: const TextStyle(
          color: Color(0xFF797C7A),
          fontSize: 12,
          fontFamily: 'Circular Std',
          fontWeight: FontWeight.w400,
          height: 1,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTimeString(chat.lastMessageTime),
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF797C7B),
              fontSize: 12,
              fontFamily: 'Circular Std',
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
          verticalSpace(5),
          if (chat.unreadCount > 0)
            Container(
              width: 22.w,
              height: 22.h,
              decoration: const BoxDecoration(
                color: Color(0xFFF04A4C),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  chat.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Circular Std',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatTimeString(String timeString) {
    // Simple formatting for the time string
    // In a real app, you might want to parse this and format it as needed
    if (timeString.isEmpty) return '';

    // If the time string is a timestamp, you could parse it like this:
    // final timestamp = DateTime.fromMillisecondsSinceEpoch(int.parse(timeString));
    // Then format as needed

    return timeString.length > 10 ? timeString.substring(0, 10) : timeString;
  }
}
