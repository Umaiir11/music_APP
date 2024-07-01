import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasecud/app/mvvm/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseAuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signUpWithEmailAndPassword(UserModel userModel) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: userModel.email ?? "N/A",
        password: userModel.password ?? "N/A",
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {

        print('The email address is already in use.');
      }
      throw Exception('Failed to sign up with email and password. Error: $e');
    }
  }




  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  User? getCurrentUser() {
    final User? user = _auth.currentUser;
    return user;
  }
}
