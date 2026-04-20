import 'package:countryside/views/homeScreen.dart';
import 'package:countryside/views/mail_signin.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class AuthSignUp {
final supabase=Supabase.instance.client;
Future<void> onSignUp(String email,String password)async{
  try{
    final userAlredyExists=await supabase.from('registered_customers').select('email').eq('email',email).maybeSingle();
     if(userAlredyExists!=null){
      Get.snackbar("Error", "Email already exists. Please login.");
      return;
     }
     final AuthResponse authResponse=await supabase.auth.signUp(email: email, password: password);
      final user=authResponse.user;
      print("User is $user");
     if (user != null && user.emailConfirmedAt == null) {
       Get.snackbar(
         "Verify Email",
         "Check your email and login after verification",
       );
       Get.offAllNamed(MailSignin.routeName);
     } else if (user != null && user.emailConfirmedAt != null) {
       Get.offAllNamed(Homescreen.routeName);
     } else {
       Get.snackbar("Error", "Signup failed");
     }
  }
  on AuthException catch(e){
    if(e.message.contains("User already registered")){
      Get.snackbar("Error", "Email already registered. Please login.");
      return;
    }
    else{
      Get.snackbar("Auth Error", e.message);
      return;
    }
  }
  catch(e){
    print(e);
    Get.snackbar("Error", "Something went wrong");
    return;
  }
}
}