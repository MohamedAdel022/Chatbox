import 'package:chat/core/widgets/svg_path_widget.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: SvgPathWidget(assetPath: "assets/images/back_arrow.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
  }
}
