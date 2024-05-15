import 'dart:async';

import 'package:firebase_app_web/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class Phone_auth_Page extends StatefulWidget {
  const Phone_auth_Page({super.key});

  @override
  State<Phone_auth_Page> createState() => _Phone_auth_PageState();
}

class _Phone_auth_PageState extends State<Phone_auth_Page> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black87,
        title: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              textField(),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    Text(
                      "Enter 6 digit OTP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              otpField(),
              SizedBox(
                height: 40,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Send OTP again in  ",
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: "00:$start ",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: "sec",
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              InkWell(
                onTap: () {
                  authClass.signInWithPhoneNumber(
                      verificationIdFinal, smsCode, context);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                    color: Color(0xffff9601),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Let's Go",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        cursorColor: Colors.white,
        controller: phoneController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: 'Enter your phone number',
          hintStyle: TextStyle(
            color: Colors.white54,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 0),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              "(+237)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
                    startTimer();
                    setState(
                      () {
                        start = 30;
                        wait = true;
                        buttonName = "Resend";
                      },
                    );
                    await authClass.verifyPhoneNumber(
                        "+237$phoneController.text", context, setData);
                  },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                  color: wait ? Colors.grey : Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
        length: 6,
        width: MediaQuery.of(context).size.width - 34,
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldWidth: 50,
        otpFieldStyle: OtpFieldStyle(
          backgroundColor: Color(0xff1d1d1d),
          borderColor: Colors.white,
        ),
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        fieldStyle: FieldStyle.underline,
        onChanged: (pin) {
          print("Changed: " + pin);
        },
        onCompleted: (pin) {
          print("Completed: " + pin);
          setState(() {
            smsCode = pin;
          });
        });
  }
}
