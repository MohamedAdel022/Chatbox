import 'package:chat/core/errors/exceptions.dart';
import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/service/firebase_auth_service.dart';
import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:chat/features/auth/domin/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImp implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  AuthRepoImp({required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
      {required String email, required String password,required String name}) async {
    try {
  var user = await firebaseAuthService.createUserWithEmailAndPassword(
      email: email, password: password);
  return right(UserModel.fromFirebaseUser(user));
} on CustomException catch (e) {
  return left(ServerFailure( e.message));
} catch (e) {
  return left(ServerFailure( 'An unknown error occurred.'));
}
  }
}
