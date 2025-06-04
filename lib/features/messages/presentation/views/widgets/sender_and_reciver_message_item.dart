import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SenderMessageItem extends StatelessWidget {
  final String message;
  final String time;
  final bool showReadMark;
  final bool showUnreadMark;
  final bool isSending;

  const SenderMessageItem({
    super.key,
    required this.message,
    required this.time,
    this.showReadMark = false,
    this.showUnreadMark = false,
    this.isSending = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: AppTextStyle.regularGray10,
                ),
                horizontalSpace(4),
                // Show a loading indicator if message is sending, otherwise show read status
                isSending 
                  ? SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.secondaryColor),
                      ),
                    )
                  : Icon(
                      showReadMark
                          ? Iconsax.tick_circle
                          : Iconsax.tick_circle5,
                      color: showReadMark
                          ? AppTheme.secondaryColor
                          : (showUnreadMark ? Colors.grey : Colors.transparent),
                      size: 14,
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
  final String message;
  final String time;

  const ReceiverMessageItem({
    super.key,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
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
      ),
    );
  }
}
