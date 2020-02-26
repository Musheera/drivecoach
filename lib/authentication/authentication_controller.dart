import 'package:drivecoach/User/user_model.dart';
import 'package:drivecoach/authentication/authentiable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    print(currentUser);
    return currentUser;
  }

  @override
  Future<FirebaseUser> login(String email, String passWord) async {
    AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: passWord);
    return user.user;
  }

  @override
  Future<FirebaseUser> register(String email, String passWord) async {
    // TODO: implement register
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: passWord);
    authResult.user;
  }

  @override
   Future<void> logout() async{
    return _firebaseAuth.signOut();
  }

  @override
  Future<bool> resetPassword(String email) {
    // TODO: implement resetPassword
    return null;
  }

  @override
  Future<UserModel> updateProfile(UserModel userModel) {
    // TODO: implement updateProfile
    return null;
  }
}
