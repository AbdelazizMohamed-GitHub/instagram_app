import 'package:bloc/bloc.dart';

import 'package:instagram_app/features/auth/domain/repo/auth_repo.dart';
import 'package:instagram_app/features/auth/presention/cubits/register_cubit.dart/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit({required this.authRepo}) : super(RegisterInitial());

  Future<void> register(
      {required String email,
      required String password,
      required String name}) async {
    emit(RegisterLoading());
    var result =
        await authRepo.registerWithEmailAndPassword(email: email, password: password, name: name);
    result.fold((error ) {
      emit(RegisterError(error.message));
    }, (user) {
      emit(RegisterSuccess(user));
    });
  }
}
