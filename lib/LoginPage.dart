import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:xiaomimusicapp/OtpLogin.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (error) {
      print(error);
    }
  }

  TextEditingController _emailId = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(_emailId);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: [
            Center(
              child: Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "Email",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _emailId,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black.withOpacity(0.5),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              "Password",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _password,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black.withOpacity(0.5),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: _handleSignIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.assignment_ind_rounded),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Login Using Google"),
                    )
                  ],
                )),
            ElevatedButton(
                onPressed: () => Get.to(OtpLogin()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Login Using Phone Number"),
                    )
                  ],
                )),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.5)),
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )
          ],
        ),
      )),
    );
  }
}
