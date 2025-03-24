import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final String message;
  final bool isSender;
  final String time;

  const MessageItem({
    super.key,
    this.message = 'Hello, this is a message',
    this.isSender = false,
    this.time = '12:30 PM',
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSender ? AppTheme.secondaryColor : Color(0xffF2F7FB),
                borderRadius: BorderRadius.only(
                  topLeft: isSender ? Radius.circular(12) : Radius.circular(0),
                  topRight: isSender ? Radius.circular(0) : Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black,
                  fontSize: 12,
                  fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              time,
              style: AppTextStyle.regularGray10,
            ),
          ],
        ),
      ),
    );
  }
}
