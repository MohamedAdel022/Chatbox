import 'dart:developer';

import 'package:chat/core/errors/exceptions.dart';
import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/service/firebase_auth_service.dart';
import 'package:chat/core/service/firestore_service.dart';
import 'package:chat/core/utils/endpoints.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:chat/features/auth/domin/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImp implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final FirestoreService firestoreService;
  AuthRepoImp(
      {required this.firebaseAuthService, required this.firestoreService});
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
          createdAt: DateTime.now(),
          lastActive: DateTime.now(),
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
      log('getUserFromFirestore success');
      log('User ID: ${userFromFirestore.id}');
      log('Name: ${userFromFirestore.name}');
      log('Email: ${userFromFirestore.email}');
      log('Image URL: ${userFromFirestore.imageUrl}');
      log('Bio: ${userFromFirestore.bio}');
      log('Created At: ${userFromFirestore.createdAt}');
      log('Last Active: ${userFromFirestore.lastActive}');
      log('Is Online: ${userFromFirestore.isOnline}');
      log('Push Token: ${userFromFirestore.pushToken}');
      //print(userFromFirestore);
      return right(userFromFirestore);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure('An unknown error occurred.'));
    }
  }

  @override
  Future addUserToFirestore(UserEntity user) async {
  await  firestoreService.addData(Endpoints.users, user.toMap(), user.id);
  }
  
  @override
  Future<UserEntity> getUserFromFirestore(String docId) async {
    var userFromFirestore = await firestoreService.getData(Endpoints.users, docId);
    return UserModel.fromJson(userFromFirestore);
  }
}
