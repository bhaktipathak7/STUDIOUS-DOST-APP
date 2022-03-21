import 'package:firebase_auth/firebase_auth.dart';

class AuthMethord {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signUpUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
   Future signOut() async {
    
    try {
      return await _firebaseAuth.signOut();
    // ignore: empty_catches
    } catch (e) {}
  }
}
