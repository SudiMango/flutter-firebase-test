import 'package:firebase_flutter_test/services/auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isObscure = true;

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  final _auth = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
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
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Sign up",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Lets get you started.",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 50,),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name",
                hintText: "Enter your name",
              ),
              controller: _name,
            ),

            const SizedBox(height: 20,),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
                hintText: "Enter your email",
              ),
              controller: _email,
            ),

            const SizedBox(height: 20,),

            TextFormField(
              obscureText: _isObscure,
              controller: _password,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                hintText: "Enter your password",
                suffixIcon: IconButton(
                  icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: (){
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              ),
            ),

            const SizedBox(height: 20,),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Sign up new user
                  await _auth.signUpWithEmailAndPassword(_name.text, _email.text, _password.text);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 50,)),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text("Or", style: TextStyle(fontSize: 15, color: Colors.grey),),),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 50,)),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
