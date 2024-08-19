import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as dev;

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Sign in anonymously

  // Sign up with email and password
  Future<void> signUpWithEmailAndPassword(String name, String email, String password) async {
    if (name.length > 0 && email.length > 0 && password.length > 6){
      try{
        final credentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await _db.collection("usernames").doc(credentials.user?.uid).set({
          "name": name
        });
        dev.log("New user created successfully.");
      }catch(e){
        dev.log("An error occured while trying to register new user: ${e}");
      }
    } else{

    }
  }

  // Log in with email and password
  Future<void> loginWithEmailAndPassword(String name, String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      dev.log("User logged in successfully.");
    }catch(e){
      dev.log("An error occured while trying to log in user: ${e}");
    }
  }

  // Sign in with google

  // Register with email and password

  // Sign out
  Future<void> signOut() async {
    try{
      _auth.signOut();
    } catch(e) {
      dev.log("An error occured while trying to sign out user: ${e}");
    }
  }

}