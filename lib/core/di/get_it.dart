 
 import 'package:chat/core/service/firebase_auth_service.dart';
import 'package:chat/features/auth/data/repos/auth_repo_imp.dart';
import 'package:chat/features/auth/domin/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
 
void setupGitIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<AuthRepo>(AuthRepoImp(
    firebaseAuthService: getIt<FirebaseAuthService>(),
  ));

}