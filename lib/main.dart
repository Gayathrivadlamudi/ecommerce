import 'package:countryside/utils/constants.dart';
import 'package:countryside/utils/init_routes.dart';
import 'package:countryside/views/mail_signup_view.dart';
import 'package:countryside/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart CartAI',
      initialRoute: '/',
      getPages: routes,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) async{
      final session =await Supabase.instance.client.auth.currentSession;
        if(session!=null){
            Get.offAllNamed(Homescreen.routeName);
        }
        else{
            Get.offAllNamed(MailSignup.routeName);
        }
      });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey),
      child: SafeArea(
        child: Container(
          color: Colors.white,
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    Constants.ImagePath + 'logo.png',
                    width: Get.width / 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
