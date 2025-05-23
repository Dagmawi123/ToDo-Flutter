class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});
}

class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthRegisterEvent(
      {required this.name, required this.email, required this.password});
}
class AuthResetPasswordEvent extends AuthEvent {
  final String email;
  AuthResetPasswordEvent({required this.email});
}
