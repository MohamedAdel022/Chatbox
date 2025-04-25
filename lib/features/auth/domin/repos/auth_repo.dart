import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure,UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure,UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future addUserToFirestore(UserEntity user);

  Future<UserEntity> getUserFromFirestore(String docId);

}