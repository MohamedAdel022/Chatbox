import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:flutter/material.dart';

class GroupMessagesItem extends StatelessWidget {
  const GroupMessagesItem({
    super.key,
    required this.message,
    required this.isSender,
    required this.time,
  });
  final String message;
  final bool isSender;
  final String time;

  @override
  Widget build(BuildContext context) {
    return isSender
        ? SenderMessageItem(message: message, time: time)
        : ReceiverMessageItem(
            message: message, time: time, senderName: 'Mohamed Adel');
  }
}

class SenderMessageItem extends StatelessWidget {
  const SenderMessageItem({
    super.key,
    required this.message,
    required this.time,
  });

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    message,
                    style: AppTextStyle.regularGrey12.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                verticalSpace(4),
                Text(
                  time,
                  style: AppTextStyle.regularGray10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReceiverMessageItem extends StatelessWidget {
  const ReceiverMessageItem({
    super.key,
    required this.message,
    required this.time,
    required this.senderName,
  });

  final String message;
  final String time;
  final String senderName;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage(Assets.imagesTest),
            ),
            horizontalSpace(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  senderName,
                  style: AppTextStyle.mediumBlack14,
                  textAlign: TextAlign.left,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffF2F7FB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    message,
                    style: AppTextStyle.regularGrey12.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                verticalSpace(4),
                Text(
                  time,
                  style: AppTextStyle.regularGray10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
