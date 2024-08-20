import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_test/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

  Future<Object?> getUserData(String col, String key) async {
    User? user = await _auth.getCurrUser();
    if (user != null) {
      DocumentSnapshot t_data = await _db.collection(col).doc(user.uid).get();
      return t_data.get(key);
    }
    throw Exception("User not found");
  }

  Future<void> setUserData(String col, String key, var value) async {
    User? user = await _auth.getCurrUser();
    if (user != null) {
      await _db.collection(col).doc(user.uid).set({
        key: value
      });
    }
  }
}