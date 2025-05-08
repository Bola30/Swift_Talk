import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth;
  bool _obscurePassword = true;

  LoginCubit(this._auth) : super(LoginInitial());

  // Login Method
  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for this email. Please check your email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address format is invalid.';
          break;
        default:
          errorMessage = 'An error occurred: ${e.message ?? 'Unknown error'}';
      }
      emit(LoginFailure(errorMessage));
    } catch (e) {
      emit(LoginFailure('An unexpected error occurred: $e'));
    }
  }

  // Toggle Obscure Password
  void toggleObscurePassword() {
    _obscurePassword = !_obscurePassword;
    emit(LoginObscurePasswordToggled(_obscurePassword));
  }
}