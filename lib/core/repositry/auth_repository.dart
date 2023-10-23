import 'package:assesmant_task/core/model/user_model.dart';
import 'package:assesmant_task/core/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future login({required UserModel user}) async {
    await _auth.signInWithEmailAndPassword(
        email: user.email!, password: user.password!);
  }

  Future register({required UserModel user}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((value) => saveUserdata(user));
    } catch (e) {
      errorSnackBar(e.toString());
    }
  }

  Future logout() async {
    await _auth.signOut();
  }

  Future saveUserdata(UserModel user) async {
    await firestore.collection('Users').doc().set({
      'Name': user.name,
      'Email': user.email,
    });
  }
}
