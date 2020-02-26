import 'package:drivecoach/User/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentiable{

  Future<FirebaseUser> register(String email, String passWord){}

   Future<AuthResult> login(String email, String passWord){}

  Future<bool> resetPassword(String email){}

  Future<UserModel> updateProfile(UserModel userModel){}
}