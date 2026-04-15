import 'package:countryside/views/homeScreen.dart';
import 'package:countryside/views/mail_signup_view.dart';
import 'package:get/get.dart';
List<GetPage> routes=[
  GetPage(name:Homescreen.routeName,page:()=>const Homescreen()),
  GetPage(name: MailSignup.routeName,page:()=>const MailSignup()),
];