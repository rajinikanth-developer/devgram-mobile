import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/strings/validation_messages.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUsecase logoutUsecase;
  UserModel? user;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUsecase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      final user = await loginUseCase(event.email, event.password);
      emit(LoginSuccessState(user: user));
    } catch (e) {
      emit(FailureState(error: e.toString()));
    }
  }

  Future<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      await registerUseCase(event.user);
      emit(SuccessState(message: AppValidationMessages.regSuccess));
    } catch (e) {
      emit(FailureState(error: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await logoutUsecase();
      user = null;
    } catch (e) {
      throw Exception('${AppValidationMessages.logoutFailed}: ${e.toString()}');
    }
  }
}
