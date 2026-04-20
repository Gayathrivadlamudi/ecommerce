import 'package:countryside/views/homeScreen.dart';
import 'package:countryside/views/mail_signup_view.dart';
import 'package:get/get.dart';

import '../views/mail_signin.dart';
List<GetPage> routes=[
  GetPage(name:Homescreen.routeName,page:()=>const Homescreen()),
  GetPage(name: MailSignup.routeName,page:()=>const MailSignup()),
  GetPage(name: MailSignin.routeName,page:()=>const MailSignin()),
];