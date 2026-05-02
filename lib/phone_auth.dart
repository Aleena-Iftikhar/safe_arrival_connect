import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'otpscreen.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  String verificationId = '';
  bool codeSent = false;
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authentication"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)
                  )
              ),
            ),
        ),
        SizedBox(height: 20),

          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(

                  // Phone number
                  phoneNumber: '+92${phoneController.text}',

                  // ✅ SMS received
                  codeSent: (String verificationId, int? resendToken) {
                    setState(() {
                      verificationId = verificationId;
                      codeSent = true;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpScreen(
                          verificationId: verificationId, // ← yeh pass karo
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("OTP sent!"))
                    );
                  },

                  // ✅ Auto verify
                  verificationCompleted: (PhoneAuthCredential credential) async {
                    await FirebaseAuth.instance.signInWithCredential(credential);
                    print("LogIn successful!");
                  },

                  // if error
                  verificationFailed: (FirebaseAuthException ex) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${ex.message}"))
                    );
                  },

                  // ⏱ Timeout
                  timeout: Duration(seconds: 60),
                  codeAutoRetrievalTimeout: (String verId) {
                    verificationId = verId;
                  },
                );
              },
              child: Text("Verify Number")
          ),
          

      ],),
    );
  }
}
