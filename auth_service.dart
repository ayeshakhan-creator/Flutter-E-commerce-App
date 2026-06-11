import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ================= SIGN UP =================
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Send verification email
        await user.sendEmailVerification();
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print("Signup Error: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      print("Signup Error: $e");
      return null;
    }
  }

  // ================= SIGN IN =================
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      print("Login Error: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  // ================= EMAIL VERIFIED CHECK =================
  Future<bool> isEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  // ================= RESEND EMAIL =================
  Future<void> resendVerificationEmail() async {
    User? user = _auth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // ================= CURRENT USER =================
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // ================= LOGOUT =================
  Future<void> signOut() async {
    await _auth.signOut();
  }
}