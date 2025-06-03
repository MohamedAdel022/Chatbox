import 'package:flutter/material.dart';

/// A widget that keeps its state when it's not visible in PageView
class NavPageBuilder extends StatefulWidget {
  final WidgetBuilder builder;

  const NavPageBuilder({
    super.key,
    required this.builder,
  });

  @override
  State<NavPageBuilder> createState() => _NavPageBuilderState();
}

class _NavPageBuilderState extends State<NavPageBuilder>
    with AutomaticKeepAliveClientMixin {
  // Create a cache for the built widget
  late Widget _child;
  bool _isBuilt = false;

  @override
  Widget build(BuildContext context) {
    // Must call super.build for AutomaticKeepAliveClientMixin to work
    super.build(context);

    // Only build the widget once and cache it
    if (!_isBuilt) {
      _child = widget.builder(context);
      _isBuilt = true;
    }

    return _child;
  }

  @override
  bool get wantKeepAlive => true;
}