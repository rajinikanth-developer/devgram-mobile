part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class LoadingState extends AuthState {
  const LoadingState();
}

class LoginSuccessState extends AuthState {
  final UserEntity user;

  const LoginSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class SuccessState extends AuthState {
  final String message;

  const SuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class FailureState extends AuthState {
  final String error;

  const FailureState({required this.error});

  @override
  List<Object> get props => [error];
}
