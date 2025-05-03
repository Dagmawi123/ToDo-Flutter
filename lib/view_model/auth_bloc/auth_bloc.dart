import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/view_model/auth_bloc/auth_event.dart';
import 'package:todo_app/view_model/auth_bloc/auth_states.dart';
import 'package:todo_app/view_model/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthSignInLoading());
      try {
        final user = await _authRepository.signInWithEmail(
            event.email, event.password);
        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
    on<AuthRegisterEvent>((event, emit) async {
      emit(AuthSignUpLoading());
      try {
        final user = await _authRepository.createUserWithEmail(
            event.email, event.password,event.name);
            //check the effect of this thing on both pages 
        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
  }
}
