import 'package:countryside/utils/signUpAuth.dart';
import 'package:countryside/widgets/Seprator_dash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:countryside/utils/Validator.dart';
import 'package:countryside/widgets/LinkText.dart';
import '../utils/constants.dart';
import 'mail_signin.dart';
import 'package:countryside/views/homeScreen.dart';
class MailSignup extends StatefulWidget{
  static const String routeName="/MailSignup";
  const MailSignup({super.key});
  @override
  State<MailSignup> createState()=>_MailSignupState();
}
class _MailSignupState extends State<MailSignup>{
  //for supabase signup first we need to check weather the user is there in table or not
  //if there then show already have an account please sign in
  //if not then we insert the details in the table

  final _formkey=GlobalKey<FormState>();
 AuthSignUp auth=AuthSignUp();
  TextEditingController emailctrl=TextEditingController();
  TextEditingController passctrl=TextEditingController();
  bool  passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(23),bottomRight: Radius.circular(23)),
          ),
          toolbarHeight: Get.height/3.2,
          backgroundColor:  Color(0XFF0f5e8a),
          flexibleSpace: Container(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 68,),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset("${Constants.ImagePath}logo.png",width: 50,height: 50,)),
                SizedBox(height: 19,),
                Text("Smart Cart AI",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 27)),
                SizedBox(height: 2,),
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
        body:
        SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(19,23,19,14),
            child: Container(
              margin: EdgeInsets.only(top: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text( "Sign up to continue",style: TextStyle(color: Color(0XFF0f5e8a),fontWeight: FontWeight.w500,fontSize: 19))),
                  Form(
                    key: _formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 28),
                        TextFormField(
                          showCursor:true,
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          validator:(val)=>Validator.emailValidate(val!),
                          controller: emailctrl,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.black,fontSize: 14),
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email,color: Colors.black38,size: 16,),
                            floatingLabelBehavior:FloatingLabelBehavior.always,
                            labelStyle: const TextStyle(color: Colors.black87),
                            errorStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color:  Colors.black54),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Colors.black54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Colors.black54),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black54),
                            ),
                          ),
                        ),
                        SizedBox(height:23,),
                        TextFormField(
                          validator:(val)=>Validator.passwordValidator(val!,1,6,),
                          controller: passctrl,
                          showCursor:true,
                          obscureText: passwordVisible,
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.black,fontSize: 14),
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock,color: Colors.black38,size: 16,),
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              icon:  passwordVisible? Icon(Icons.remove_red_eye_outlined,color: Colors.black38,size: 18,):Icon(Icons.remove_red_eye,color: Colors.black38,size: 18,),),
                            floatingLabelBehavior:FloatingLabelBehavior.always,
                            labelStyle: const TextStyle(color: Colors.black87),
                            errorStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Colors.black54),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Colors.black54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Colors.black54),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black54),
                            ),
                          ),
                        ),
                        SizedBox(height: 19,),

                        InkWell(
                          onTap: (){
                            if (_formkey.currentState!.validate()) {
                              // Perform sign-up logic here
                              // For example, you can call your authentication method
                               // auth.onSignUp(emailctrl.text,  passctrl.text, context);
                              auth.onSignUp(emailctrl.text,  passctrl.text);

                            }

                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(18,12,12,12),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: LinearGradient(colors:[
                                  Color(0XFF0f5e8a),
                                  Color(0XFF1a7fb5)
                                ] )
                            ),
                            child:  Row(
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
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12,),
                        Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Linktext(text: "By continuing, you agree to our ", linkText: "Terms and Condition & Privacy Policy", url: "https://www.google.com/?zx=1770896380596&no_sw_cr=1")),
                      ],
                    ),
                  ),
                  SizedBox(height: 32,),
                  Row(
                    children: [
                      Expanded(child: MySperator(color: Colors.black54)),
                      Text("  Or sign Up With  ",style: TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w500),),
                      Expanded(child: MySperator(color: Colors.black54)),

                    ],
                  ),
                  SizedBox(height: 21,),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {

                              },
                              icon: Image.asset(
                                  '${Constants.ImagePath}google.png'),
                            ),
                          )),
                      Expanded(
                          child:Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                              },
                              icon: Image.asset(
                                  '${Constants.ImagePath}microsoft.png'),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 12,),
                  Align(
                    alignment: Alignment.center,
                    child:InkWell(
                      onTap: (){
                        Get.offAllNamed(MailSignin.routeName);
                      },
                      child: Text( "Have an account? Sign In", style: TextStyle(  color: Colors.blue,fontSize: 12,),),
                    ),
                  ),
                ],
              ),
            )
            ,),
        )
    );
  }
}

