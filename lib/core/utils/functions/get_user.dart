import 'dart:convert';

import 'package:chat/constants.dart';
import 'package:chat/core/service/secure_storage_service.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';

Future<UserEntity> getUser() async {
  final secureStorageService = SecureStorageService();
  var jsonString = await secureStorageService.read(key: kUserData);

  final Map<String, dynamic> userMap = json.decode(jsonString!);
  return UserModel.fromJson(userMap);
}
