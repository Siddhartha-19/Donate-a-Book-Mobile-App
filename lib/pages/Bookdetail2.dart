import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class bookdetail2 extends StatefulWidget {
  DocumentSnapshot document2;
  bookdetail2({Key key, @required this.document2}) : super(key: key);
  @override
  _bookdetail2State createState() => _bookdetail2State();
}

class _bookdetail2State extends State<bookdetail2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#000C66'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child:Center(
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Text(widget.document2["bookName"],style:TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700)),
          Text("Genre: "+widget.document2["genre"],style:TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700)),
          widget.document2["price"]!='0'?Text("Price: "+widget.document2["price"]+"/day",style:TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700)):Text("Price: Free",style:TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700))
      
        ],)
        ),
      ),
    );
  }
}