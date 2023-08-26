import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaomimusicapp/HomeScreen.dart';

class OtpLogin extends StatefulWidget {
  const OtpLogin({super.key});

  @override
  State<OtpLogin> createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  TextEditingController _mobileNumber = TextEditingController();
  TextEditingController _otp = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  void _sendOtp() async {
    String phoneNumber = "+${_mobileNumber.text}";

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto verification if the device is able to receive the SMS
        await _auth.signInWithCredential(credential);
        print("Auto verification completed.");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store verification ID and resend token for future use
        // You can use them in the _verifyOtp method
        setState(() {
          _verificationId = verificationId;
        });
        print("Code sent to $phoneNumber");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Auto retrieval timeout for $phoneNumber");
      },
    );
  }

  void _verifyOtp() async {
    String smsCode = _otp.text;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );

    try {
      await _auth.signInWithCredential(credential);
      print("OTP verification successful.");
      Get.to(() => HomeScreen());
    } catch (e) {
      print("OTP verification failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Enter Mobile Number"),
            Center(
              child: TextFormField(
                controller: _mobileNumber,
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: _sendOtp,
              child: Text("Send OTP"),
            ),
            if (_verificationId != null)
              Column(
                children: [
                  Text("Enter OTP"),
                  Center(
                    child: TextFormField(
                      controller: _otp,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _verifyOtp,
                    child: Text("Verify OTP"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
