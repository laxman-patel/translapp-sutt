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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  String _inputText = '';
  String? _translatedText = null;
  String _targetLanguage = 'en';
  String _detectedLanguage = 'auto';
  List<dynamic> _availaibleLangauges = ['en', 'fr'];
 

   static const _headers = {
    'content-type': 'application/x-www-form-urlencoded',
    'X-RapidAPI-Key': 'b86611b0fdmsh0cc804dcb662c70p1c6b8bjsn4824cc4241d5',
    'X-RapidAPI-Host': 'google-translate113.p.rapidapi.com'
  };

  static const api_uri = 'https://google-translate113.p.rapidapi.com/api/v1/translator/detect-language';

  Future<void> _getAvailaibleLanguages() async {
    final response = await http.get(
      Uri.parse('https://google-translate113.p.rapidapi.com/api/v1/translator/support-languages'), 
      headers: {
    'X-RapidAPI-Key': 'b86611b0fdmsh0cc804dcb662c70p1c6b8bjsn4824cc4241d5',
    'X-RapidAPI-Host': 'google-translate113.p.rapidapi.com'
   }
    );

     if (response.statusCode == 200) {
      setState(() {
        _availaibleLangauges = jsonDecode(response.body).map((item) => item['code']).toList();
        
      });
    } else {
     
      throw Exception('Failed to load');
    }
  }

    Future<void> _translateText() async {
    final response = await http.post(
      Uri.parse('https://google-translate113.p.rapidapi.com/api/v1/translator/text'),
      headers : _headers,
      body: {
        'from': _detectedLanguage,
        'to': _targetLanguage,
        'text': _inputText
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _translatedText = jsonDecode(response.body)['trans'];
      });
    } else {
      print(response.body);
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    _getAvailaibleLanguages();
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
                  _translateText();
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
              hintText: 'enter text to translate',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Color(0xffAAABAA),
              ),
              
            ),
          )
          ),
              DropdownButton<String>(
              value: _targetLanguage,
              style: const TextStyle(color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  _targetLanguage = newValue ?? '';
                  _translateText();
                });
              },
              items: _availaibleLangauges
                  .map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

             Center(
            child:  TextField(   
            keyboardType: TextInputType.multiline,
            maxLines: 9,

            
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
              hintText: _translatedText ?? 'your trasnlated text in ${lanuages[_targetLanguage] ?? _targetLanguage} will appear here...',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Color(0xffAAABAA),
              ),
              
            ),
          )
          )
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
          Icon(Icons.graphic_eq_outlined, color: Colors.black,),
          Icon(Icons.home_outlined, color: Color(0xfff15025)),
          Icon(Icons.info_outlined, color: Colors.black),
         ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              context.go("/detect");
            } else if (index == 2) {
              context.go("/about");
            }
          });
        },
      ),
    );
  }
}