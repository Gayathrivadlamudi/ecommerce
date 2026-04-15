import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget{
  static const String routeName='/home';
  const Homescreen({super.key});
  @override
  State<Homescreen> createState() => _HomescreenState();
}
class _HomescreenState extends State<Homescreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Home Screen"),),
    );
  }
}