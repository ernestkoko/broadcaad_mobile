import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim().toLowerCase(), password: password.trim());
  }

  Future signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(), password: password.trim());
  }
}
