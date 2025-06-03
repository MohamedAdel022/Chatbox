import 'package:chat/core/utils/functions/get_user.dart';
import 'package:chat/features/chats/presentation/views/widgets/profile_image.dart';
import 'package:flutter/material.dart';

class HeaderImage extends StatefulWidget {
  const HeaderImage({super.key});

  @override
  State<HeaderImage> createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  String? _imageUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserImage();
  }

  Future<void> _loadUserImage() async {
    if (!mounted) return;

    try {
      // Using the getUser utility function that returns Future<UserEntity?>
      final userData = await getUser();
      if (mounted) {
        setState(() {
          _imageUrl = userData.imageUrl;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      debugPrint('Error loading user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileImage(
      radius: 20, 
      isLoading: _isLoading, 
      imageUrl: _imageUrl ?? ""
    );
  }
}