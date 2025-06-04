import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/core/widgets/loading_indicator.dart';
import 'package:chat/features/chats/presentation/views/widgets/custom_image_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    required this.image,
    required this.radius,
  });

  final String image;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        width: radius * 2.r,
        height: radius * 2.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) {
        return ImageSkeletonLoader(radius: radius);
      }, 
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
