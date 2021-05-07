
import 'package:finalyear/pages/Bookdetail1.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String lat='';
  String long='';
  String ploc;
  @override
  void initState()  {
  //getcurrentuserdata();
  super.initState();
   getcurrentlocationdata();
                                         
}
  String Uid;
  getcurrentlocationdata()
 async {
  try{ final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   
   setState(() {
     lat='${position.latitude}';
     long='${position.longitude}';

   });
  }
  catch(e)
  {
    print(e);
  }
  if (lat!='' && long!='')
  {
  List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(lat),double.parse(long)); 
  }
  /*
  setState(() {
    ploc=placemarks[0].postalCode;
  });
  */
  }

  getcurrentuserdata() async
  {
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      Uid = user.uid.toString();
    });
     
  }
  String _chosenValue;
  String name = "";
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: 
        Container(

          child:
          !isSearching
            ? Text('Donate a Book')
            
            : TextField(
                onChanged: (val) {
                   setState(() {
                name = val;
              });
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                    hintText: "Search Books Here",
                    hintStyle: TextStyle(color: Colors.white))
              ),
              ),
              centerTitle:true,
              backgroundColor: HexColor("#274472"),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                      setState(() {
                        name='';
                      });
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                ),
            
 DropdownButton<String>(
  dropdownColor: HexColor("#0C2D48"),
  focusColor:Colors.yellowAccent,
  value: _chosenValue,
  elevation: 5,
  style: TextStyle(color: Colors.white),
  iconEnabledColor:Colors.yellowAccent,
  items: <String>[
    'All',
    'Crime',
    'Thriller',
    'Humour',
    'programming',
    'physics'
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.white,fontSize: 14),),
    );
  }).toList(),
  hint:Text(
    "Genre",
    style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500),
  ),
  onChanged: (String value) {
    setState(() {
      _chosenValue = value;
    });
  },
      ),
     /* Transform.scale(
        scale: 0.3,
       child:LiteRollingSwitch(
                value: true,
                textOn: "L-on",
                textOff: "L-off",
                colorOn: Colors.greenAccent,
                colorOff: Colors.redAccent,
                iconOn:Icons.location_on_sharp,
                iconOff: Icons.location_off_sharp,  
                onChanged: (bool val)
                {},
              ),
       ),*/
        ],
         
       ),
        /*Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),*/
        /*Text('Donate a Book'),
        centerTitle: true,*/
        //backgroundColor: HexColor("#274472"),
       /* leading: IconButton(icon: Icon(Icons.person), onPressed: ()
        async {
                await auth.signOut();
              },
        ),*/
      body:Container(
        color: HexColor("#0C2D48"),
      child:StreamBuilder<QuerySnapshot>(
      stream:(ploc!=""&& ploc!=null)?(name != "" && name != null)
            ? Firestore.instance
                .collection('Books').where('Availability',isEqualTo: true )
                .where("searchKeywords", arrayContains: name.toUpperCase()).where('location',isEqualTo: ploc)
                .snapshots()
            : Firestore.instance.collection("Books").where('Availability',isEqualTo: true ).where('location',isEqualTo: ploc).snapshots():
            (name != "" && name != null)? Firestore.instance
                .collection('Books').where('Availability',isEqualTo: true )
                .where("searchKeywords", arrayContains: name.toUpperCase())
                .snapshots()
            : Firestore.instance.collection("Books").where('Availability',isEqualTo: true ).snapshots(),

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
            return new Padding(
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
            );
          }).toList(),
        );
      },
    ),)
        
    );
  }
}