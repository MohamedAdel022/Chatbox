import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:chat/core/widgets/custom_buble_icon_button.dart';
import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomBubleIconButton(
          onPressed: () {
            // Handle Facebook login
          },
          icon: Assets.imagesFacebook,
          pading: 3,
        ),
        CustomBubleIconButton(
          onPressed: () {
            // Handle Google login
          },
          icon: Assets.imagesGoogle,
          pading: 3,
        ),
        CustomBubleIconButton(
          onPressed: () {
            // Handle Twitter login
          },
          icon: Assets.imagesApple,
          pading: 3,
        ),
      ],
    );
  }
}
