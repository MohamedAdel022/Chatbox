// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class ImageSkeletonLoader extends StatelessWidget {
//   final double radius;
//   final bool enabled;

//   const ImageSkeletonLoader({
//     super.key,
//     required this.radius,
//     this.enabled = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Skeletonizer(
//       enabled: enabled,
//       effect: ShimmerEffect(
//         baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
//         highlightColor: Theme.of(context).colorScheme.surface,
//       ),
//       child: Container(
//         width: radius * 2.r,
//         height: radius * 2.r,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }
// }