import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      rethrow; // Handle errors in the calling method
    }
  }
  // Create user with email and password
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Update user profile with additional information
  Future<void> updateUserProfile({
    required String uid,
    required String phone,
    required String email,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'phone': phone,
        'created_at': FieldValue.serverTimestamp(),
        'last_updated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  // Handle authentication errors
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      default:
        return 'An error occurred: ${e.message}';
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

Future<void> signUpWithEmailAndPassword({
  required String email,
  required String password,
  required String phone,
}) async {
  try {
    UserCredential userCredential = await createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await updateUserProfile(
      uid: userCredential.user!.uid,
      email: email,
      phone: phone,
    );
  } catch (e) {
    throw Exception('Failed to sign up: $e');
  }
}}