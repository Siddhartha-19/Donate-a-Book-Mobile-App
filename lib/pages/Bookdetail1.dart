
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/Bookmodel/Book.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'Bookdetail2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
final CollectionReference collectionReference =Firestore.instance.collection("Users");
class bookdetail1 extends StatefulWidget {
  final String url;
  DocumentSnapshot document1;
  bookdetail1({Key key, @required this.url,this.document1}) : super(key: key);
  @override
  _bookdetail1State createState() => _bookdetail1State();
}

class _bookdetail1State extends State<bookdetail1> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final usercollection=Firestore.instance.collection('Users');
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
  bool add=false;
  bool request=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back,color:HexColor('#050A30') ,size: 30),onPressed: (){
          Navigator.pop(context);
        },),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
     body:Container(
      color: HexColor('#D4F1F4'),//HexColor("#0C2D48"),
      width: MediaQuery.of(context).size.width*1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height:30),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(160),
              color:  HexColor("#53565A"),
            ),
          width:MediaQuery.of(context).size.width*0.80,
          height: MediaQuery.of(context).size.width*0.80,
            child: Image.network(widget.url,
            
            fit: BoxFit.contain,
            
            //height: 400,
            ),
          ),
          /*Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             // SizedBox(width:10),
              IconButton(icon:Icon(LineAwesomeIcons.arrow_right,size: 70,color: HexColor("#F8D210"),), onPressed:()
              {
                DocumentSnapshot document2;
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>bookdetail2(document2:widget.document1)),
  );

              }
              ),
            ],
            )*/
            Container(
        child:Column(
       // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height:10),

        Text(widget.document1["bookName"],style:TextStyle(color:HexColor('#050A30'), fontSize: 25, fontWeight: FontWeight.w700)),
         SizedBox(height: 10,),
           FittedBox(fit: BoxFit.scaleDown,
                      child:Text("Genre: "+widget.document1["genre"],style:TextStyle(color:HexColor('#050A30'), fontSize: 20, fontWeight: FontWeight.w700)),
            ), 
            //SizedBox(width:20),
 
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children:<Widget>[
             Spacer(),
            widget.document1["price"]!='0'?FittedBox(fit: BoxFit.scaleDown,
                      child:Text("Price: "+widget.document1["price"]+"/day",style:TextStyle(color:HexColor('#050A30'), fontSize: 20, fontWeight: FontWeight.w700))):FittedBox(fit: BoxFit.scaleDown,
                      child:Text("Price:Free",style:TextStyle(color:HexColor('#050A30'), fontSize:20 , fontWeight: FontWeight.w700)),),
         Spacer(),
           new StreamBuilder(
      stream: Firestore.instance.collection('Users').document(Uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        else
        {
        var userDocument = snapshot.data;
        List<String> ids = List.from(userDocument['Favourites']);
        if (ids.contains(widget.document1['docid']))
        {
          add=true;
        }
        else
        {
            add=false;
        }
         return IconButton(icon:add?Icon(Icons.favorite, color:HexColor('#050A30')):Icon(Icons.favorite_border),
            onPressed: ()
            
async { 
             await usercollection.document(Uid).updateData(
               add?{"Favourites":FieldValue.arrayRemove([widget.document1['docid']])}:{"Favourites":FieldValue.arrayUnion([widget.document1['docid']]),} 
            
             );
             setState(() {
               add=!add;
             });
            },
            iconSize: 30,
           );
      }
  },
  ),
  Spacer(),
           ],
  ),
           
        new StreamBuilder(
      stream: Firestore.instance.collection('Users').document(widget.document1['uid']).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var ownerDocument = snapshot.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              
              children:<Widget>[
                Spacer(),
            Text("Owner:"+ownerDocument["displayName"],style:TextStyle(color:HexColor('#050A30'), fontSize: 20, fontWeight: FontWeight.w700)),
           Spacer(),
           IconButton(icon: Icon(Icons.phone_android_outlined),iconSize: 30, 
           onPressed: ()async {
           //launch(('tel:+${ownerDocument['mobilenumber']}'));
           FlutterPhoneDirectCaller.callNumber('+91'+ownerDocument['mobilenumber']);
           },
           color:HexColor('#050A30')),
         
               Spacer(), ]
              ),  // SizedBox(height:10),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
              
            IconButton(icon: Icon(LineAwesomeIcons.phone),iconSize: 30, onPressed: null,color:HexColor('#050A30')),
            //Text(":"+ownerDocument["mobilenumber"],style:TextStyle(color:HexColor('#050A30'), fontSize: 20, fontWeight: FontWeight.w700))
              ],
            ),
            */
            
          ],
        );
      }
          
  ),
 new StreamBuilder(
      stream: Firestore.instance.collection('Requests').where('userid',isEqualTo: Uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        else
        {

        //List<String> ids = List.from(userDocument['Favourites']);
       /* snapshot.data.documents.map((DocumentSnapshot document)
        {
        });*/
          var requestDocument = snapshot.data.documents;
          for (var i=0;i<requestDocument.length;i++ )
          {
        if (requestDocument[i]["Bookid"]==widget.document1['docid'])
        {
        
            request=true;
                   
        }
          }
         return 
         ButtonTheme(
              minWidth: 200.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: HexColor('#050A30')),
                  
                  ),
                  child:RaisedButton(
elevation: 10,
 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                color:HexColor('#18A558'),
                hoverColor: HexColor('#050A30'),
                child:
                request? 
                Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                  SizedBox(height:10),
                    Icon(LineAwesomeIcons.arrow_circle_o_left, size: 30,color:HexColor('#050A30') ,),
                    Text("Remove Request",
                    style: TextStyle(
                    fontSize: 15,
                   color: HexColor('#050A30'),
                   fontWeight: FontWeight.w700
                    ),
                    ),
                    SizedBox(height:8),
                  ],
                ):
               Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                  SizedBox(height:10),
                    Icon(LineAwesomeIcons.arrow_circle_o_right,size:30,color:HexColor('#050A30'),),
                    Text("Request",style: TextStyle(
                   color: HexColor('#050A30'),
                   fontSize: 15,
                   fontWeight: FontWeight.w700
                    ),),
                    SizedBox(height:8),
                  ],
                ),
                
                onPressed: ()
                  async{
                    if (!request)
                   {
                      CollectionReference requests = Firestore.instance.collection('Requests');
                      var randomDoc = Uid+widget.document1['docid'];
                     print(randomDoc);
    await requests.document(randomDoc).setData(
      {
      'ownerid':widget.document1['uid'],
      'Bookid':widget.document1['docid'],
      'docid':randomDoc,
      'userid':Uid,
      }
    );
                    }
                  
                    else
                   {
                      CollectionReference requests = Firestore.instance.collection('Requests');
    var randomDoc = Uid+widget.document1['docid'];
    await requests.document(randomDoc).delete();
                    }
                       setState(() {
               request=!request;
             });
                  /*request?requestbooks(Uid,widget.document1['docid'],widget.document1['uid']):deleterequestbooks(Uid,widget.document1['docid'],widget.document1['uid']),
                  setState(() {
               request=!request;
             })*/
                },
              ));
           

           /* IconButton(icon:add?Icon(Icons.favorite, color:HexColor('#050A30')):Icon(Icons.favorite_border),
            onPressed: ()
            
async { 
             await usercollection.document(Uid).updateData(
               add?{"Favourites":FieldValue.arrayRemove([widget.document1['docid']])}:{"Favourites":FieldValue.arrayUnion([widget.document1['docid']]),} 
            
             );
             setState(() {
               add=!add;
             });
            },
            iconSize: 30,
           );*/
      }
  },
  
  ),
 
          
        ],)
            )
        ],
      ),
    )
    );
  }
}
  