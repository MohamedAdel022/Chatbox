import 'package:chat/core/widgets/loading_indicator.dart';
import 'package:chat/features/chats/presentation/views/widgets/circle_image.dart';
import 'package:chat/features/chats/presentation/views/widgets/default_user_image.dart';
import 'package:flutter/material.dart';

// import 'custom_image_placeholder.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.radius,
    required this.isLoading,
    required this.imageUrl,
  });

  final double radius;
  final bool isLoading;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // return ImageSkeletonLoader(radius: radius);
      return LoadingIndicator();
    } else if (imageUrl.isNotEmpty) {
      return CircleImage(image: imageUrl, radius: radius);
    } else {
      return DefaultUserImage(radius: radius);
    }
  }
}
