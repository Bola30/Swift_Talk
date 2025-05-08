import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseAuth _auth;

  SignUpCubit(this._auth) : super(SignUpInitial());

  // Sign Up Method
  Future<void> signUp({
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(SignUpLoading());
    try {
      // تسجيل المستخدم باستخدام Firebase Authentication
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // بعد التسجيل، يمكنك إضافة الهاتف أو أي بيانات إضافية إلى Firestore أو قاعدة أخرى
      // مثال: await FirebaseFirestore.instance.collection('users').doc(user.uid).set({...})

      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'The email is already in use. Please try another email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address format is invalid.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak. Please choose a stronger password.';
          break;
        default:
          errorMessage = 'An error occurred: ${e.message ?? 'Unknown error'}';
      }
      emit(SignUpFailure(errorMessage));
    } catch (e) {
      emit(SignUpFailure('An unexpected error occurred: $e'));
    }
  }
}