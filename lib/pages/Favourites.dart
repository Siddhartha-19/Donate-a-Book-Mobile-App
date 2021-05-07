import 'package:finalyear/pages/Bookdetail1.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
class favourites extends StatefulWidget {
  @override
  _favouritesState createState() => _favouritesState();
}

class _favouritesState extends State<favourites> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
  getcurrentuserdata();
  super.initState();
}
 elementList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents.map((DocumentSnapshot document) {
      List<String> ids = List.from(document['Favourites']);
      print(ids);
      return ListTile() ;/*new StreamBuilder(
      stream: Firestore.instance.collection('Books').document(document['docid']).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        return new Text(userDocument["bookName"]);
      }
  );*/
    }).toList();
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
        title: Text('Wishlist'),
        centerTitle: true,
        backgroundColor: HexColor("#274472"),
      ),
      body:Container(
        color: HexColor("#0C2D48"),
        child: StreamBuilder(
    stream: Firestore.instance
      .collection('Users').where('uid',isEqualTo:Uid)
      .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return new ListView(
          children: snapshot.data.documents.map<Widget>((DocumentSnapshot document) {
            List<String> ids = List.from(document['Favourites']);
      print(ids);
      return Column(
        children:<Widget> [
      for (var did in ids)
        StreamBuilder(
      stream: Firestore.instance.collection('Books').document(did).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var document2 = snapshot.data;
        return 
        new Padding(
              padding:EdgeInsets.only(top:10,bottom:10,left: 10,right: 10),
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
        );
      }
  )
       ]
      );   
     //return ListTile() ;
     //
     //
     /*new StreamBuilder(
      stream: Firestore.instance.collection('Books').document(document['docid']).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        return new Text(userDocument["bookName"]);
      }
  );*/
    }).toList()
        );
      }
    }
  ),
      )
      );
  }
}