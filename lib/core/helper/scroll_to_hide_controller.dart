import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideController {
  final ScrollController controller = ScrollController();
  final ValueNotifier<bool> isVisible = ValueNotifier<bool>(true);
  final double hideThreshold;

  ScrollToHideController({this.hideThreshold = 100});

  void init() {
    controller.addListener(listener);
  }

  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
  }

  void listener() {
    final scrollDirection = controller.position.userScrollDirection;
    if (scrollDirection == ScrollDirection.forward) {
      show();
    } else if (scrollDirection == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible.value) {
      isVisible.value = true;
    }
  }

  void hide() {
    if (isVisible.value) {
      isVisible.value = false;
    }
  }
}
