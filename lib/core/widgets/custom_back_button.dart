import 'package:chat/core/utils/assets.dart/assets.dart';
import 'package:chat/core/widgets/svg_path_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        padding: EdgeInsets.all(8.w),
        icon: SvgPathWidget(assetPath: Assets.imagesBackArrow),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
