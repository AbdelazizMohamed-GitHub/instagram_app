import 'package:bloc/bloc.dart';
import 'package:instagram_app/features/auth/domain/repo/auth_repo.dart';
import 'package:instagram_app/features/auth/presention/cubits/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit({required this.authRepo}) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    var result = await authRepo.login(
      email: email,
      password: password,
    );
    result.fold((error) {
      emit(LoginError(error.message));
    }, (user) {
      emit(LoginSuccess(user));
    });
  }
}
