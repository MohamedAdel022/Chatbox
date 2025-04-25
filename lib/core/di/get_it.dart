import 'package:chat/core/service/firebase_auth_service.dart';
import 'package:chat/core/service/firestore_service.dart';
import 'package:chat/features/auth/data/repos/auth_repo_imp.dart';
import 'package:chat/features/auth/domin/repos/auth_repo.dart';
import 'package:chat/features/messages/data/repositories/message_repository_impl.dart';
import 'package:chat/features/messages/domain/repositories/message_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGitIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<FirestoreService>(FirestoreService());
  getIt.registerSingleton<AuthRepo>(AuthRepoImp(
    firebaseAuthService: getIt<FirebaseAuthService>(),
    firestoreService: getIt<FirestoreService>(),
  ));

  getIt.registerSingleton<ChatRepository>(ChatRepositoryImpl(
    FirebaseFirestore.instance,
  ));
}
