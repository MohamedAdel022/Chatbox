import 'package:firebase_auth/firebase_auth.dart';
import '../routes.dart';
import 'route_guard.dart';

class AuthGuard extends RouteGuard {
  AuthGuard({required FirebaseAuth firebaseAuth})
      : super(
          guardCheck: (context, arguments) {
            // Check if user is authenticated
            return firebaseAuth.currentUser != null;
          },
          redirectTo: Routes.loginScreen,
        );
}
