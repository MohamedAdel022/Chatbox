import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.controller,
    required this.onSend,
  });
  
  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: 20.h, left: 20.w, right: 20.w, top: 10.h),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF3F6F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller,
                minLines: 1, // Start with 1 line
                maxLines: 3, // Allow up to 3 lines for longer text
                textAlignVertical:
                    TextAlignVertical.center, // Center text vertically
                decoration: InputDecoration(
                  hintText: 'Write your message',
                  hintStyle: AppTextStyle.regularGrey14,
                  isDense: true, // Makes the input field more compact
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                ),
                // Allow sending on Enter key press (desktop/web support)
                onSubmitted: (_) => onSend(),
              ),
            ),
          ),
          horizontalSpace(10),
          IconButton.filled(
            icon: Center(
                child: Icon(
              Iconsax.send_1,
              color: Colors.white,
            )),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
