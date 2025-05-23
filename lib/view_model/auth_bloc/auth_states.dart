import 'package:flutter/widgets.dart';
import 'package:todo_app/model/user.dart';

@immutable
sealed class AuthState {  
}
class AuthInitial extends AuthState { 
} 
class AuthSignInLoading extends AuthState { 
}
class AuthSignUpLoading extends AuthState { 
}
class AuthRegisterSuccess extends AuthState { 
  final UserModel? user;
  AuthRegisterSuccess({required this.user});
}
class AuthLoginSuccess extends AuthState { 
  final UserModel? user;
  AuthLoginSuccess({required this.user});
}
class AuthLoginFailure extends AuthState { 
  final String error;
  AuthLoginFailure({required this.error});
}
class AuthRegisterFailure extends AuthState { 
  final String error;
  AuthRegisterFailure({required this.error});
}
class AuthResetLoading extends AuthState { 
}
class AuthResetFailure extends AuthState { 
  final String error;
  AuthResetFailure({required this.error});
}
class AuthResetEmailSent extends AuthState { 
}
class AuthResetEmailVerified extends AuthState { 
}
class AuthResetEmailUnverified extends AuthState { 
  final String error;
  AuthResetEmailUnverified({required this.error});
}