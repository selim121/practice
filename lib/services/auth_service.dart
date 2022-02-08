import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Future<User?> get0rCreateUser() async {
    if (currentUser == null) {
      await _firebaseAuth.signInAnonymously();
    }
    return currentUser;
  }
}
