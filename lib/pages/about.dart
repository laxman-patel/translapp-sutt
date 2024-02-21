import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding( padding: const EdgeInsets.fromLTRB(25,10,25,10),child: Column(children: <Widget>[Text("Translapp can translate from and to over 100 languauges and can also detect the language from the text given."),SizedBox(height:20 ,),Text("This app is created by Laxman Patel for SUTT task 1.")],) ), 
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
          Icon(Icons.home_outlined, color: Colors.black),
          Icon(Icons.info_outlined, color: Color(0xfff15025)),
         ],
        onTap: ( index){
          setState(() {
            _currentIndex = index;
            if (index == 1) {
              context.go("/");
            } else if (index == 0) {
              context.go("/detect");
            }
          });
        },
      ),
    );
  }
}