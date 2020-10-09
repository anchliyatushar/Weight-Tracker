part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginProcessing extends LoginState {
  const LoginProcessing();
}

class LoginCompleted extends LoginState {
  const LoginCompleted();
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
}

class LoginSignOut extends LoginState {
  const LoginSignOut();
}

class LoginSignProcessing extends LoginState {
  const LoginSignProcessing();
}
