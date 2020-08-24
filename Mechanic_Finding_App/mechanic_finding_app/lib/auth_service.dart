import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return currentUser.user.email;
  }

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    final currentUser = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return currentUser.user.email;
  }

  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<User> removeUser() async {
    User user = _firebaseAuth.currentUser;
    user.delete();
    return null;
  }

  signOut(){
    return _firebaseAuth.signOut();
  }
}
