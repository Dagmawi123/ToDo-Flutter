import 'package:firebase_auth/firebase_auth.dart';

class AuthRemote {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<UserCredential> login(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signOut();
      UserCredential userCred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      ;
      return userCred;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<User> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _firebaseAuth.signOut();
      UserCredential userCred = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCred.user?.updateProfile(displayName: name);
      await userCred.user?.reload();
      return _firebaseAuth.currentUser!;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
