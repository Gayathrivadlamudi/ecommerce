import 'dart:convert';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:countryside/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
class Homescreen extends StatefulWidget{
  static const String routeName='/home';
  const Homescreen({super.key});
  @override
  State<Homescreen> createState() => _HomescreenState();
}
class _HomescreenState extends State<Homescreen>{
  final supabase=Supabase.instance.client;
  TextEditingController searchController=TextEditingController();
  List<CategoriesModel>categories=[];
  bool speechEnabled = false;
  String lastWords = '';
  SpeechToText speechToText = SpeechToText();
  @override
  void initState(){
    super.initState();
    initSpeech();
    getData();
  }
    Future<void>getData()async{
      final response=await http.get(
        Uri.parse('https://ngwtmexeiqpzpdqwrcly.supabase.co/functions/v1/smart-task'),
        headers: {
          "Content-Type":"application/json",
        }
      );
      if(response.body.isNotEmpty){
        final data=jsonDecode(response.body);
        categories.addAll(data.map<CategoriesModel>((e)=>CategoriesModel.fromJson(e)));
        setState(() {

        });
      }
      print(response.body);
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: 57,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0XFF0f5e8a),
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                SizedBox(width: 20),
                Text(
                  "Home Screen",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(14,9,14,14),
            child: Container(
              padding: EdgeInsets.only(left: 5,right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(14)
              ),
              child: Row(
                children: [
                  InkWell(
                      onTap: (){},
                      child: Icon(Icons.search,color: Colors.grey,)),
                  SizedBox(width: 5,),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Find AI-curated deals...",
                        hintStyle: TextStyle(fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: (){
                        print("mic is on");
                        speechToText.isNotListening ? startListening() : stopListening();
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: speechToText.isListening ? Colors.red.withOpacity(0.2) : Colors.transparent,
                        ),
                        child: Icon(
                          Icons.mic,
                          color: speechToText.isListening ? Colors.red : Colors.black,
                        ),
                      ))
                ],
              ),
            ),
            ),
            SizedBox(height: 5,),
            SizedBox(
              height: 120,
              child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                 // physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context,int i){
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Container(
                          padding:EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.2, 0.2),
                                blurRadius: 2,
                                spreadRadius: 2,
                                color: Colors.black12
                              )
                            ]
                          ),
                          child:CachedNetworkImage(
                            imageUrl: categories[i].image_url.toString(),
                            height: 23,
                            width: 23,
                            fit: BoxFit.cover,
                              placeholder: (context,
                                  url) =>
                              const Center(
                                  child:
                                  CircularProgressIndicator()),
                              errorWidget: (context,
                                  url, error) =>
                                  Align(
                                    alignment: Alignment
                                        .center,
                                    child: Image.asset(
                                      '${Constants.ImagePath}noimage.jpg',
                                    ),
                                  )
                          ) ,
                        ),
                        SizedBox(height: 5,),
                        Text("${categories[i].name}",
                        style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  );
              }),
            )

          ],
        ),
      ),
    );
  }
void initSpeech() async{
  speechEnabled=await speechToText.initialize(  onStatus: (status) => print("STATUS: $status"),
    onError: (error) => print("ERROR: $error"),);
  setState(() {

  });
}

void startListening()async{
  print("START LISTENING");
    await speechToText.listen(onResult: onSpeechResult,
                     listenFor: Duration(seconds: 30),
                    pauseFor: Duration(seconds: 5),
                     partialResults: true,);
    setState(() {

    });
}
void stopListening()async{
  print("STOP LISTENING");
  await speechToText.stop();
  setState(() {});
}
void onSpeechResult(SpeechRecognitionResult result){
    print("hii");
setState(() {
lastWords=result.recognizedWords;
searchController.text = lastWords;
print("LastWords are ${lastWords}");
});
}

}