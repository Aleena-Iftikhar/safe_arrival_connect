import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              TextField(
                controller: otpController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter OTP",
                ),
              ),
              SizedBox(height: 20),

              // ✅ Verify Button
              ElevatedButton(
                onPressed: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId, // ← widget. se access
                    smsCode: otpController.text,
                  );
                  try {
                    await FirebaseAuth.instance.signInWithCredential(credential);
                    print("Login Successful!");
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Wrong OTP!"))
                    );
                  }
                },
                child: Text("Verify OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}