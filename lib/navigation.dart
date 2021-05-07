import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'pages/profile.dart';
import 'pages/homepage.dart';
import 'pages/library.dart';
import 'package:hexcolor/hexcolor.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final pages=[mylibrary(),homepage(),profile()];
  var page=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
    bottomNavigationBar: CurvedNavigationBar(
      index:1,
      color: HexColor("#868B8E"),
      buttonBackgroundColor:HexColor("#F8D210"),
      backgroundColor: HexColor("#0C2D48"),
      animationDuration: Duration(milliseconds:300),
      animationCurve: Curves.bounceOut,
          items: <Widget>[
            Icon(Icons.my_library_books,size: 30),
            Icon(LineIcons.home, size: 30),
            Icon(Icons.person, size: 30),
          ],
          onTap: (index) {
            setState(() {
              page = index;
            });
          },
        ),
        body:pages[page]
    );
  }
}