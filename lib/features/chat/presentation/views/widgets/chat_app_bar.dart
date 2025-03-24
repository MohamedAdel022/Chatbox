import 'package:chat/core/helper/spacing.dart';
import 'package:chat/core/theme/app_text_style.dart';
import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:chat/features/auth/presentation/views/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: CustomBackButton(),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(Assets.imagesTest),
          ),
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mohamed Adel',
                style: AppTextStyle.mediumBlack16,
              ),
              Text(
                'Active 2m ago',
                style: AppTextStyle.regularGrey12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
