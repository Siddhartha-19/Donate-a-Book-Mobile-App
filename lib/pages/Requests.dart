import 'package:finalyear/pages/Bookdetail1.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Requestspage extends StatefulWidget {
  @override
  _RequestspageState createState() => _RequestspageState();
}

class _RequestspageState extends State<Requestspage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
  getcurrentuserdata();
  super.initState();
}
  String Uid;
  getcurrentuserdata() async
  {
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      Uid = user.uid.toString();
    });
     
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('YourRequests'),
        centerTitle: true,
        backgroundColor: HexColor("#274472"),
      ),
      body:Container(
        color: HexColor("#0C2D48"),
      child:StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Requests').where('userid',isEqualTo:Uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
           color: HexColor("#0C2D48"),
          );
        }
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot rdocument) {
            return StreamBuilder(
      stream: Firestore.instance.collection('Books').document(rdocument['Bookid']).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var document2 = snapshot.data;
        return 
        new Padding(
              padding:EdgeInsets.only(top:10,bottom:10,left: 10,right: 10),
              child:Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                actions: [
              
                ],
              child:Container(
              decoration: BoxDecoration(
                color:HexColor("#4E4F50"), 
                borderRadius: BorderRadius.circular(20)                
              ),
              child:Column(
              children:<Widget>[
                 ListTile(
                onTap: () {
                  String url;
                  DocumentSnapshot document1;
                   Navigator.push(context,MaterialPageRoute(builder: (context) => bookdetail1(url:document2["url"],document1:document2)),);
                },
                leading:ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(document2["url"],
            height: 50.0,
          ),
        ),
                title: Text("Book: "+document2["bookName"], style: TextStyle(
                  color: Colors.white
                ),),
                subtitle: Text("Genre: "+document2["genre"],style: TextStyle(
                  color: Colors.white
                ),),
              ),
              SizedBox(height:10)
              ]
              )
              )
              ),
        );
      }
  );
            /*new Padding(
              padding:EdgeInsets.only(top:10,bottom:10,left: 10,right: 10),
              child:Container(
              decoration: BoxDecoration(
                color:HexColor("#4E4F50"), 
                borderRadius: BorderRadius.circular(20)                
              ),
              //width: MediaQuery.of(context).size.width * 0.50,
              child:Column(
              children:<Widget>[
              ListTile(
                onTap: () {
                  String url;
                  DocumentSnapshot document1;
                   Navigator.push(context,MaterialPageRoute(builder: (context) => bookdetail1(url:document["url"],document1:document)),);
                },
                leading:ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(document["url"],
            height: 50.0,
          ),
        ),
                title: Text("Book: "+document["bookName"], style: TextStyle(
                  color: Colors.white
                ),),
                subtitle: Text("Genre: "+document["genre"],style: TextStyle(
                  color: Colors.white
                ),),
              ),
              SizedBox(height:10),
              ]
              )
              ),
            );*/
          }).toList(),
        );
      },
    ),
      ),
    );
  }
}