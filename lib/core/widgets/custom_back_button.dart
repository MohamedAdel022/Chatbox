import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:chat/core/widgets/svg_path_widget.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Center(child: SvgPathWidget(assetPath: Assets.imagesBackArrow)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
