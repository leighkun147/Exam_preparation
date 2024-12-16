import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. Sign In with Email and Password
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  // 2. Create User with Email and Password
  Future<User?> createUserWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error creating user: $e');
      return null;
    }
  }

  // 3. Sign Out Feature
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Optional: Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Optional: Check if a user is signed in
  bool isUserSignedIn() {
    return _auth.currentUser != null;
  }
}
