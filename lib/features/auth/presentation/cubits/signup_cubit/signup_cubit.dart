import 'package:bloc/bloc.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:chat/features/auth/domin/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());
  final AuthRepo authRepo;
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignupLoading());
    final result = await authRepo.signUpWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) => emit(SignupFailure(failure.message)),
      (userEntity) => emit(SignupSuccess(userEntity)),
    );
  }
}
