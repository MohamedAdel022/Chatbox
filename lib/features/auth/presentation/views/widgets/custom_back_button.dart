import 'package:chat/core/widgets/svg_path_widget.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: SvgPathWidget(assetPath: "assets/images/back_arrow.svg"),
    );
  }
}
