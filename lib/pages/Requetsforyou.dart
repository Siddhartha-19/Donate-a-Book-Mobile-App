import 'package:finalyear/pages/Bookdetail1.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';


class Requestsforyou extends StatefulWidget {
  @override
  _RequestsforyouState createState() => _RequestsforyouState();
}

class _RequestsforyouState extends State<Requestsforyou> {
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
        title: Text('Requests For You'),
        centerTitle: true,
        backgroundColor: HexColor("#274472"),
      ),
      body:Container(
        color: HexColor("#0C2D48"),
      child:StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Requests').where('ownerid',isEqualTo:Uid).snapshots(),
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
          return new Container(
           color: HexColor("#0C2D48"),
          );
        }
        var document2 = snapshot.data;
        return StreamBuilder(
      stream: Firestore.instance.collection('Users').document(rdocument['userid']).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Container(
           color: HexColor("#0C2D48"),
          );
        }
        var userdocument=snapshot.data;
        return 
        new Padding(
              padding:EdgeInsets.only(top:10,bottom:10,left: 10,right: 10),
              child:Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                actions: [
                   Padding(padding: EdgeInsets.symmetric(horizontal:10),
                  child:Container(
                    width:25,
                    height:100,
                    decoration: BoxDecoration(
                    color: HexColor("#4E4F50"),
                    borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(icon: Icon(Icons.phone_android_rounded), 
                    onPressed: ()
                    async{ 
                     DocumentSnapshot userdoc= await Firestore.instance.collection('Users').document(rdocument['userid']).get();
                     //launch(('tel:+${userdoc['mobilenumber']}'));
           FlutterPhoneDirectCaller.callNumber('+91'+userdoc['mobilenumber']);
                    },
                    iconSize: 30,
                    color: Colors.yellowAccent),
                  
                  )
                  )
                ],
                secondaryActions: [
                  Padding(padding: EdgeInsets.symmetric(horizontal:10),
                  child:Container(
                    width:25,
                    height:100,
                    decoration: BoxDecoration(
                    color: HexColor("#4E4F50"),
                    borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(icon: Icon(Icons.delete), 
                    onPressed: ()
                    async{ 
                      await Firestore.instance.collection('Requests').document(rdocument['docid']).delete();

                    },
                    iconSize: 30,
                    color: Colors.yellowAccent),
                  
                  )
                  )
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
                  /*String url;
                  DocumentSnapshot document1;
                   Navigator.push(context,MaterialPageRoute(builder: (context) => bookdetail1(url:document2["url"],document1:document2)),);
                */},
                leading:ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(document2["url"],
            height: 50.0,
          ),
        ),
                title: Text("Book: "+document2["bookName"], style: TextStyle(
                  color: Colors.white,
                  fontSize: 15

                ),),
                subtitle: Text("Requested User: "+userdocument["displayName"],style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),),
              ),
              SizedBox(height:10)
              ]
              )
              )
              )
        );
      }
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