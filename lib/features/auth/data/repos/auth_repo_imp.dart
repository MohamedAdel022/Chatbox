import 'dart:convert';

import 'package:chat/constants.dart';
import 'package:chat/core/errors/exceptions.dart';
import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/service/firebase_auth_service.dart';
import 'package:chat/core/service/firestore_service.dart';
import 'package:chat/core/service/secure_storage_service.dart';
import 'package:chat/core/service/time_service.dart';
import 'package:chat/core/utils/endpoints.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:chat/features/auth/domin/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthRepoImp implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final FirestoreService firestoreService;
  final TimeService timeService;
  final FirebaseMessaging firebaseMessaging;
  AuthRepoImp(
      {required this.firebaseAuthService,
      required this.firestoreService,
      required this.timeService,
      required this.firebaseMessaging});
  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      var user = await firebaseAuthService.createUserWithEmailAndPassword(
          email: email, password: password);
      var userEntity = UserEntity(
          id: user.uid,
          name: name,
          email: email,
          imageUrl: '',
          bio: 'Hello, I am using CircleChat',
          createdAt: timeService.getNowTimestamp(),
          lastActive: timeService.getNowTimestamp(),
          isOnline: true,
          pushToken: '');
      await addUserToFirestore(userEntity);
      user.updateDisplayName(name);
      user.reload();
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure('An unknown error occurred.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);
      //get user from firestore
      var userFromFirestore = await getUserFromFirestore(user.uid);

      if (userFromFirestore == null) {
        return left(
            ServerFailure('Failed to retrieve user data. Please try again.'));
      }

      await saveUserData(user: userFromFirestore);

      // Update FCM token in Firestore after successful sign-in
      await saveFcmToken(userId: user.uid);

      return right(userFromFirestore);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future addUserToFirestore(UserEntity user) async {
    await firestoreService.addData(
        Endpoints.users, UserModel.fromEntity(user).toMap(), user.id);
  }

  @override
  Future<UserEntity?> getUserFromFirestore(String docId) async {
    try {
      final userFromFirestore =
          await firestoreService.getData(Endpoints.users, docId);
      if (userFromFirestore.isEmpty) {
        return null;
      }
      return UserModel.fromJson(userFromFirestore);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserData({required UserEntity user}) async {
    try {
      // Get the singleton instance of SecureStorageService
      final secureStorage = SecureStorageService();

      // Convert UserEntity to UserModel and then to JSON
      final userModel = UserModel.fromEntity(user);
      final userJson = json.encode(userModel.toMap());

      // Store user data in secure storage
      await secureStorage.write(key: kUserData, value: userJson);

      // Store user ID separately for quick access
      await secureStorage.write(key: kUserId, value: user.id);

      // Store user email separately for login convenience
      await secureStorage.write(key: kUserEmail, value: user.email);

      return right(true);
    } catch (e) {
      return left(StorageFailure('Failed to save user data: ${e.toString()}'));
    }
  }

  @override
  Future<void> saveFcmToken({required String userId}) async {
    final token = await firebaseMessaging.getToken();
    if (token == null) {
      return;
    }

    // Update the pushToken field in the user document
    await firestoreService.updateData(
        Endpoints.users, {'pushToken': token}, userId);

    // Also update in secure storage for local reference
    final secureStorage = SecureStorageService();
    await secureStorage.write(key: 'fcm_token', value: token);
  }
}
