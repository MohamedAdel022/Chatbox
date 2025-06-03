import 'package:chat/core/service/fcm_service.dart';
import 'package:chat/core/service/firebase_auth_service.dart';
import 'package:chat/core/service/firestore_service.dart';
import 'package:chat/core/service/time_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/features/auth/data/repos/auth_repo_imp.dart';
import 'package:chat/features/auth/domin/repos/auth_repo.dart';
import 'package:chat/features/chats/data/repositories/chat_repository_impl.dart';
import 'package:chat/features/chats/domain/repositories/chat_repository.dart';
import 'package:chat/features/messages/data/repos/message_repo_imp.dart';
import 'package:chat/features/messages/domin/repos/message_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGitIt() {
  // Register core Firebase instances
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);
  getIt.registerSingleton<FcmService>(FcmService());
  // Register service classes
  getIt.registerSingleton<FirebaseAuthService>(
      FirebaseAuthService(auth: getIt<FirebaseAuth>()));
  getIt.registerSingleton<FirestoreService>(
      FirestoreService(firestore: getIt<FirebaseFirestore>()));
  getIt.registerSingleton<TimeService>(TimeService());

  // Register repositories
  getIt.registerSingleton<AuthRepo>(AuthRepoImp(
    firebaseAuthService: getIt<FirebaseAuthService>(),
    firestoreService: getIt<FirestoreService>(),
    timeService: getIt<TimeService>(),
    firebaseMessaging: getIt<FirebaseMessaging>(),
  ));

  getIt.registerSingleton<ChatRepository>(ChatRepositoryImpl(
    firestore: getIt<FirebaseFirestore>(),
    timeService: getIt<TimeService>(),
    firebaseAuth: getIt<FirebaseAuth>(),
  ));

  getIt.registerSingleton<MessageRepo>(MessageRepoImp(
    firestore: getIt<FirebaseFirestore>(), fcmService: getIt<FcmService>(),
  ));
}
