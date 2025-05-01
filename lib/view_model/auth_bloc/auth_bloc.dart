import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/view_model/auth_bloc/auth_event.dart';
import 'package:todo_app/view_model/auth_bloc/auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final AuthRepository authRepository;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _firebaseAuth.signOut();
        var userCred = await _firebaseAuth.signInWithEmailAndPassword(
            email:event.email, password: event.password);
        print("User ID is :${userCred.user!.uid}"); 
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });

    // on<AuthLogoutEvent>((event, emit) async {
    //   emit(AuthLoading());
    //   try {
    //     await authRepository.logout();
    //     emit(AuthLoggedOut());
    //   } catch (e) {
    //     emit(AuthFailure(error: e.toString()));
    //   }
    // });
  }
}
