import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:chat/core/widgets/custom_buble_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsHeader extends StatelessWidget {
  const ContactsHeader({super.key});
  final String title = "Contacts";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBubleIconButton(
            onPressed: () {},
            icon: Assets.imagesSearch,
            pading: 11,
          ),
          Text(
            title,
            style: AppTextStyle.mediumWhite20,
          ),
          CustomBubleIconButton(
              onPressed: () {}, icon: Assets.imagesAddUser, pading: 11)
        ],
      ),
    );
  }
}
