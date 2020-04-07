import 'package:drivecoach/User/user_model.dart';
import 'package:drivecoach/authentication/authentiable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthenticationController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String type;

  final CollectionReference collectionRefrence =
      Firestore.instance.collection('users');

  final CollectionReference collectionRuleRefrence =
  Firestore.instance.collection('rules');

  final CollectionReference collectionTrainingRefrence =
  Firestore.instance.collection('training');


  final CollectionReference collectionTrainingPayRefrence =
  Firestore.instance.collection('payment');

  Future<String> getCurrentUser() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<String> getUserType(String userId) async {
    return type;
  }

  Future<void> deleteUser(String userId) async {
    Future<DocumentSnapshot> user =
        collectionRefrence.document(userId).delete();
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
  Future<void> logout() async {
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
