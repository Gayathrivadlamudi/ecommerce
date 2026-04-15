
import 'package:countryside/utils/Validator.dart';
import 'package:countryside/utils/auth_signin.dart' hide AuthSignIn;
import 'package:countryside/views/homeScreen.dart';
import 'package:countryside/views/mail_signup_view.dart';
import 'package:countryside/widgets/LinkText.dart';
import 'package:countryside/widgets/Seprator_dash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:countryside/utils/Validator.dart';
import 'package:countryside/widgets/LinkText.dart';
import 'package:countryside/widgets/Seprator_dash.dart';
import '../utils/auth_signin.dart';
import '../utils/constants.dart';

class MailSignin extends StatefulWidget {
  static const String routeName = "/MailSignin";
  const MailSignin({super.key});
  @override
  State<MailSignin> createState() => _MailSigninState();
}

class _MailSigninState extends State<MailSignin> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passctrl = TextEditingController();
  bool passwordVisible = true;
  AuthSignIn auth = AuthSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(23),
            bottomRight: Radius.circular(23),
          ),
        ),
        toolbarHeight: Get.height / 3.2,
        backgroundColor: Color(0XFF0f5e8a),
        flexibleSpace: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.only(right: 23.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(18, 6, 18, 6),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.offAllNamed(Homescreen.routeName);
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 19),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "${Constants.ImagePath}logo.png",
                  width: 50,
                  height: 50,
                ),
              ),
              SizedBox(height: 19),
              Text(
                "Smart Cart AI",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 27,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "Get Your Items at Lowest Price",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                  fontFamily: "GothamRounded",
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(19, 23, 19, 14),
          child: Container(
            margin: EdgeInsets.only(top: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Sign in to continue",
                    style: TextStyle(
                      color: Color(0XFF0f5e8a),
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                    ),
                  ),
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 28),
                      TextFormField(
                        showCursor: true,
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        validator: (val) => Validator.emailValidate(val!),
                        controller: emailctrl,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black38,
                            size: 16,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: const TextStyle(color: Colors.black87),
                          errorStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),
                      TextFormField(
                        validator: (val) =>
                            Validator.passwordValidator(val!, 1, 6),
                        controller: passctrl,
                        showCursor: true,
                        obscureText: passwordVisible,
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black38,
                            size: 16,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: passwordVisible
                                ? Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.black38,
                              size: 18,
                            )
                                : Icon(
                              Icons.remove_red_eye,
                              color: Colors.black38,
                              size: 18,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: const TextStyle(color: Colors.black87),
                          errorStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black54),
                          ),
                        ),
                      ),
                      SizedBox(height: 19),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "Forget password?",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ),
                      ),
                      SizedBox(height: 7),
                      InkWell(
                        onTap: () {
                          auth.onSignIn(emailctrl.text, passctrl.text, context);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(18, 12, 12, 12),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: LinearGradient(
                              colors: [Color(0XFF0f5e8a), Color(0XFF1a7fb5)],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Verify yourself",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "GothamRounded",
                                ),
                              ),
                              Icon(Icons.arrow_forward, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Linktext(
                          text: "By continuing, you agree to our ",
                          linkText: "Terms and Condition & Privacy Policy",
                          url:
                          "https://www.google.com/?zx=1770896380596&no_sw_cr=1",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(child: MySperator(color: Colors.black54)),
                    Text(
                      "  Or sign in With  ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(child: MySperator(color: Colors.black54)),
                  ],
                ),
                SizedBox(height: 21),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(Constants.ImagePath + 'google.png'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            Constants.ImagePath + 'microsoft.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Get.offAllNamed(MailSignup.routeName);
                    },
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
