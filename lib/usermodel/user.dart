import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 class User
{
  final String uid;
  User({this.uid});
final usercollection=Firestore.instance.collection('Users');
FirebaseAuth auth = FirebaseAuth.instance;

/* Future getUsersList() async {
    List itemsList = [];
     
CollectionReference users = Firestore.instance.collection('Users');
    try {
      await users.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
 }*/
 Stream<QuerySnapshot> get users{
   return usercollection.snapshots();
 }
 Future getcurrentuserdata() async
 {
   final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
   try{
   DocumentSnapshot ds=await usercollection.document(uid).get();
   print(ds.data);
   String name=ds.data['displayName'];
   String email=ds.data['email'];
   print(name);
   return [name,email];
   } catch(e)
   {
     print(e.toString());
     return null; 
   }
 }
}
Future<void> userSetup(String displayName,String mobilenumber,String email) async {
  CollectionReference users = Firestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
 final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
  await users.document(uid).setData
  ({
          "displayName": displayName,
          "mobilenumber": mobilenumber,
          "email":email,
          "Favourites":FieldValue.arrayUnion([])
        });
  return;
}
