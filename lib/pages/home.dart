import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_test/services/auth.dart';
import 'package:firebase_flutter_test/services/dialog.dart';
import 'package:firebase_flutter_test/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  final DBService _db = DBService();
  final DialogHandler _dh = DialogHandler();

  User? user;
  Object? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    user = await _auth.getCurrUser();
    name = await _db.getUserData("userdata", "name");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "App",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome ${name}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Signed in as ${user?.email}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20,),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Sign up new user
                  await _auth.signOut();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: const Text(
                  "Sign out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
