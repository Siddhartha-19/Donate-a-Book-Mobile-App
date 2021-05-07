import 'package:finalyear/pages/Favourites.dart';
import 'package:flutter/material.dart';
import 'package:finalyear/Authservice/Authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalyear/usermodel/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'Bookimage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Favourites.dart';
import 'Requests.dart';
import 'Requetsforyou.dart';
class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: profilescreen(),
    );
    }
}
class profilescreen extends StatefulWidget {
  @override
  _profilescreenState createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
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
  @override
  Widget build(BuildContext context) { 
    print(Uid);
     CollectionReference users =Firestore.instance.collection('Users');
     return Scaffold(
       backgroundColor: HexColor("#0C2D48"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10,),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          CircleAvatar(radius: 55,
          backgroundImage: AssetImage("assets/images/logo.jpg")
          ),
          ]),
          Container(
            child:FutureBuilder<DocumentSnapshot>(
      future: users.document(Uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (!snapshot.hasData)
        {
          return Container( 
          color:HexColor("#0C2D48")
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
color: HexColor("#0C2D48"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
         
          return Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(snapshot.data['displayName'], style:TextStyle(fontSize:20,color: Colors.white),),
                SizedBox(height: 5,),
                Text(snapshot.data['mobilenumber'], style:TextStyle(fontSize:20,color: Colors.white),),
                SizedBox(height: 5,),
                Text(snapshot.data['email'], style:TextStyle(fontSize:20,color: Colors.white),),
              ],)
          );
          //Text(snapshot.data['displayName']);
        }
        return CircularProgressIndicator(backgroundColor: Colors.amberAccent,);
      },
    ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
           child: Text("     Update Profile      ",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
           onPressed: () {},
           style: ElevatedButton.styleFrom(
           primary: Colors.amberAccent,
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(48.0),
          ),
         ),
          ),
          SizedBox(height:15),
          ElevatedButton(
           child: Text("              Donate a Book             ",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
           onPressed: ()
           {
             Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => UploadingImageToFirebaseStorage()),
  );
           },
           style: ElevatedButton.styleFrom(
           primary: Colors.amberAccent,
           onPrimary: Colors.white,
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(48.0),
          ),
         ),
          ),
          SizedBox(height:15),
           ElevatedButton(
           child: Text("                     Wishlist                    ",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
           onPressed: ()
           {
             Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => favourites()),
  );
           },
           style: ElevatedButton.styleFrom(
           primary: Colors.amberAccent,
           onPrimary: Colors.white,
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(48.0),
          ),
         ),
          ),
          SizedBox(height:15),
           ElevatedButton(
           child: Text("                 Your Requests             ",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),),
           onPressed: (){
             Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Requestspage()),
  );
           },
           style: ElevatedButton.styleFrom(
           primary: Colors.amberAccent,
           onPrimary: Colors.white,
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(48.0),
          ),
         ),
          ),
          SizedBox(height:15),
           ElevatedButton(
           child: Text("             Requests for you            ",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),),
           onPressed: (){
             Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Requestsforyou()),
  );
           },
           style: ElevatedButton.styleFrom(
           primary: Colors.amberAccent,
           onPrimary: Colors.white,
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(48.0),
          ),
         ),
          ),
          SizedBox(height:15),
          ElevatedButton(
           child: Text("                      Log-Out                     ",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
           onPressed: ()async {
                await auth.signOut();
              },
           style: ElevatedButton.styleFrom(
           primary: Colors.amberAccent,
           onPrimary: Colors.white,
           shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(48.0),
          ),
         ),
          ),
          
             
        ],
      ), 
     );/*FutureBuilder<DocumentSnapshot>(
      future: users.document(Uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
         
          return Text(snapshot.data['displayName']);
        }

        return Text("loading");
      },
    );*/
  }
}
