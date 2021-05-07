import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
class mylibrary extends StatefulWidget {
  @override
  _mylibraryState createState() => _mylibraryState();
}

class _mylibraryState extends State<mylibrary> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String Uid;
  String dname;
  String email;
  @override
  void initState() {
  getcurrentuserdata();
  super.initState();
}
  getcurrentuserdata() async
  {
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      Uid = user.uid.toString();
    });
     
  }
   Widget customcard(String bookname,String genre,String price,bool availability, String docid,DocumentSnapshot document) {
     if (price=='0')
     {
       price="Free";

     }
    return Padding(
        padding: EdgeInsets.all(10),
        child:Container(
          width: 400,
          height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [Colors.yellow,Colors.red[300]]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height:10),
           
              Text("Book: "+bookname,
            style: TextStyle(
              //color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.w700
            ),),
          
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
                Text("Genre: "+genre,
            style: TextStyle(
              //color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.w700
            ),),
            Text("Price: "+price,
            style: TextStyle(
              //color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
               ElevatedButton(
           child: Text("  Delete  "),
           onPressed: () {},
           style: ElevatedButton.styleFrom(
           primary: HexColor("#274472"),
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(48.0),
          ),
         ),
          ),
          ElevatedButton(
           child: Text("  Update  "),
           onPressed: () {},
           style: ElevatedButton.styleFrom(
           primary: HexColor("#274472"),
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(48.0),
          ),
         ),
          ),
          ElevatedButton(
           onPressed: ()async{
            await Firestore.instance
        .collection("Books")
        .document(docid)
        .updateData({'Availability':!availability});
         /*Firestore.instance.runTransaction((transaction)async{
            DocumentSnapshot qsnapshot=await transaction.get(document.reference);
            await transaction.update(qsnapshot.reference,{'Availability':!qsnapshot['Availability']});
          });*/
        setState(() {
          availability=!availability;
         

        });
           },
           child:availability? Text(" Remove Availability"): Text("Add Availability"),
           style: ElevatedButton.styleFrom(
           primary: HexColor("#274472"),
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(48.0),
          ),
         ),
          ),
             ],
           )
          ]
    )
    )
    );
  }
  @override
  
  Widget build(BuildContext context) {
    Query users = Firestore.instance.collection('Books').where('uid',isEqualTo: Uid);
    return 
       Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'My Books', 
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          
        ),
        body: Container(
          color: HexColor("#0C2D48"),
       child: StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
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
          children: snapshot.data.documents.map((DocumentSnapshot document) {
          return customcard(document["bookName"],document['genre'],document['price'],document['Availability'],document['docid'],document);
          }).toList(),
        );
         },
    ),
        ),
    );
  }
}