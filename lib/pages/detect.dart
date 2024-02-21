import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const lanuages = {
  "en": "English",
  "fr": "French",
  "es": "Spanish",
  "de": "German",
  "zh": "Chinese",
  "ja": "Japanese",
  "pt": "Portuguese",
  "ar": "Arabic",
  "ru": "Russian",
  "hi": "Hindi"
};

class DetectPage extends StatefulWidget {
  const DetectPage({super.key});

  @override
  State<DetectPage> createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  int _currentIndex = 0;
  String _inputText = '';
  String _detectedLanguage = '';
 
 

  static const _headers = {
    'content-type': 'application/x-www-form-urlencoded',
    'X-RapidAPI-Key': 'b86611b0fdmsh0cc804dcb662c70p1c6b8bjsn4824cc4241d5',
    'X-RapidAPI-Host': 'google-translate113.p.rapidapi.com'
  };

  static const api_uri = 'https://google-translate113.p.rapidapi.com/api/v1/translator/detect-language';

   Future<void> _detectText() async {
    final response = await http.post(
      Uri.parse(api_uri),
      headers : _headers,
      body: {
        'text': _inputText,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _detectedLanguage = jsonDecode(response.body)['source_lang_code'];
        print(jsonDecode(response.body)['source_lang_code']);
      });
    } else {
      print(response.body);
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25,10,25,10),
        child: Column(children: <Widget>[
          Center(
            child:  TextField(   
            keyboardType: TextInputType.multiline,
            maxLines: 9,
              
            onChanged: (value) {
              setState(() {
                _inputText = value;

                Timer(Duration(seconds: 2), () {
                  _detectText();
                });
              });
            },
            
            style: TextStyle(
              fontSize: 14,
            ),

            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Color(0xffE6E8E6) ,
              hintText: 'enter text to detect the launguage of...',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Color(0xffAAABAA),
              ),
              
            ),
          )
          ),
          Text(_detectedLanguage != '' ? 'Detected Language: ${lanuages[_detectedLanguage]}' : ''),
           
        ],)
      ),
      appBar: AppBar(
        title: Text('TRANSLAPP',style: TextStyle(
          color: Color(0xfff15025),
          fontSize:16, 
          fontWeight: FontWeight.bold,
          letterSpacing: 6,
        )), 
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      bottomNavigationBar:CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Color(0xffE6E8E6),
        index: _currentIndex,
        items: [
          Icon(Icons.graphic_eq_outlined, color: Color(0xfff15025),),
          Icon(Icons.home_outlined, color: Colors.black ),
          Icon(Icons.info_outlined, color: Colors.black),
         ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
            if (index == 1) {
              context.go("/");
            } else if (index == 2) {
              context.go("/about");
            }
          });
        },
      ),
    );
  }
}