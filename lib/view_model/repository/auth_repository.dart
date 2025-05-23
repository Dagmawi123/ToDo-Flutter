import 'package:todo_app/data/auth_remote.dart';
import 'package:todo_app/model/user.dart';

class AuthRepository {
  final AuthRemote _authRemote;

  AuthRepository({required AuthRemote authRemote}) : _authRemote = authRemote;
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      var userCred = await _authRemote.login(email: email, password: password);
      UserModel user = UserModel.fromFirebaseUser(userCred.user!);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> createUserWithEmail(
      String email, String password, String name) async {
    try {
      var userFB = await _authRemote.register(
          email: email, password: password, name: name);
      UserModel user = UserModel.fromFirebaseUser(userFB);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetWithEmail(String email) async {
    try {
      await _authRemote.sendResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyPin(String email, String otp) async {
    try {
      await _authRemote.verifyPin(email: email,pin:int.parse(otp));
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> signOut() async {
  //   try {
  //     await _firebaseAuth.signOut();
  //   } catch (e) {
  //     throw Exception('Failed to sign out: $e');
  //   }
  // }
}
