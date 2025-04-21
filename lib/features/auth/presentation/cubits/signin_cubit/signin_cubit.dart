import 'package:bloc/bloc.dart';
import 'package:chat/features/auth/domin/entities/user_entity.dart';
import 'package:chat/features/auth/domin/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());
final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SigninLoading());
    final result = await authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(SigninFailure(failure.message)),
      (userEntity) => emit(SigninSuccess(userEntity)),
    );
  }
  
}
