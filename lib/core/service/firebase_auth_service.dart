import 'package:chat/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;
      
  /// Returns the current authenticated user or null if not authenticated
  User? get currentUser => _auth.currentUser;
  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Send email verification
      await credential.user?.sendEmailVerification();

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException('The account already exists for that email.');
      } else {
        throw CustomException('An unknown error occurred.');
      }
    } catch (e) {
      throw CustomException('An unknown error occurred.');
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw CustomException('Wrong password provided for that user.');
      } else {
        throw CustomException('An unknown error occurred.');
      }
    } catch (e) {
      throw CustomException('An unknown error occurred.');
    }
  }
}
