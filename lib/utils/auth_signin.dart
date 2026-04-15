import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../views/homeScreen.dart';

class AuthSignIn extends GetxController {
  final supabase = Supabase.instance.client;
  var loading = false.obs;
  Future<void> onSignIn(
      String email,
      String password,
      BuildContext context,
      ) async {
    try {
      loading.value = true;
      final AuthResponse authResponse = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = authResponse.user;
      if (user == null) {
        Get.snackbar("Error", "Login failed");
        return;
      }
      final existingUser = await supabase
          .from('registered_customers')
          .select('email')
          .eq('email', email)
          .maybeSingle();
      if(existingUser==null){
        final response=await supabase.from('registered_customers').insert({
          'id':user?.id,
          'email':email,
          'created_at':DateTime.now().toIso8601String(),
        });
      }
      Get.offAllNamed(Homescreen.routeName);
    } on AuthException catch (e) {
      Get.snackbar("Login Failed", e.message);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      loading.value = false;
    }
  }
}
