import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
class Linktext extends StatelessWidget{
    final String text;
    final String linkText;
    final String url;
    const Linktext({required this.text,required this.linkText,required this.url});
    @override
  Widget build(BuildContext context){
      final Uri uri=Uri.parse(url);
      return RichText(text: TextSpan(
       style: TextStyle(color:Colors.black87,fontSize: 12),
        children: [
          TextSpan(text: text),
          TextSpan(text: linkText,
          style: TextStyle(  color: Colors.blue,fontSize: 12,
            // decoration: TextDecoration.underline,
          ),
            recognizer: TapGestureRecognizer()
              ..onTap=()=>launchUrl(uri),
          )
        ]

      ));
    }


}