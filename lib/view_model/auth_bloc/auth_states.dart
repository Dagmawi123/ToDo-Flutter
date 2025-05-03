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
class AuthSuccess extends AuthState { 
  final UserModel? user;
  AuthSuccess({required this.user});
}
class AuthFailure extends AuthState { 
  final String error;
  AuthFailure({required this.error});
}
