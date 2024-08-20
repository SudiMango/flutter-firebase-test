import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_test/pages/home.dart';
import 'package:firebase_flutter_test/pages/sign_up.dart';
import 'dart:developer' as dev;

import 'package:firebase_flutter_test/services/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final DialogHandler _dialog = DialogHandler();

  // Sign in anonymously

  // Sign up with email and password
  Future<void> signUpWithEmailAndPassword(BuildContext context, String name, String email, String password) async {
    if (name.length > 0 && email.length > 0 && password.length > 6){
      try{
        final credentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await _db.collection("userdata").doc(credentials.user?.uid).set({
          "name": name
        });
        dev.log("New user created successfully.");
        await loginWithEmailAndPassword(context, name, email, password);
      }catch(e){
        dev.log("An error occured while trying to register new user: ${e}");
      }
    } else{
      _dialog.showOkDialog(context, "Error", "Please ensure that all fields are filled properly.", (){Navigator.of(context).pop();});
    }
  }

  // Log in with email and password
  Future<void> loginWithEmailAndPassword(BuildContext context, String name, String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      dev.log("User logged in successfully.");
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    }catch(e){
      dev.log("An error occured while trying to log in user: ${e}");
    }
  }

  // Sign in with google

  // Register with email and password

  // Sign out
  Future<void> signOut() async {
    try{
      User? _user = await getCurrUser();
      dev.log(_user!.uid);

      _auth.signOut();
    } catch(e) {
      dev.log("An error occured while trying to sign out user: ${e}");
    }
  }

  Future<User?> getCurrUser() async {
    return await _auth.currentUser;
  }

  Widget authCheck() {
    return StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("Waiting for auth data...");
            return SignUp();
          } else if (snapshot.hasData) {
            print("Auth data found!");
            return HomePage();
          } else {
            print("No auth data found!");
            return SignUp();
          }
        }
    );
  }

}