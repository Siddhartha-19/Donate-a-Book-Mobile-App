import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
Future<void> addbooks(String bookname,String price,String genre,String mobilenumber,String url,String postal) async {
  CollectionReference books = Firestore.instance.collection('Books');
  FirebaseAuth auth = FirebaseAuth.instance;
 final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    var randomDoc = await books.document().documentID;
    bookname=bookname.toUpperCase();
    genre=genre.toLowerCase();
    await books.document(randomDoc).setData(
      {
      'Availability':true,
      'bookName':bookname,
      'price':price,
      'genre':genre,
      'docid':randomDoc,
      'uid':uid,
      'url':url,
      'location':postal

      }
    );
    String temp = "";
  for (int i = 0; i < bookname.length; i++) {
    temp = temp + bookname[i];
    await books.document(randomDoc).updateData(
      {
      'searchKeywords':FieldValue.arrayUnion([temp])
      }
    );
  }
  
  
  return;
}
Future<void> requestbooks(String userid,String bookid,String ownerid) async {
  CollectionReference books = Firestore.instance.collection('Requests');
    var randomDoc = userid+bookid;
    print(randomDoc);
    await books.document(randomDoc).setData(
      {
      'ownerid':ownerid,
      'Bookid':bookid,
      'docid':randomDoc,
      'userid':userid,

      }
    );
  
  
  return;
}
Future<void> deleterequestbooks(String userid,String bookid,String ownerid) async {
  CollectionReference requests = Firestore.instance.collection('Requests');
    var randomDoc = userid+bookid;
    await requests.document(randomDoc).delete();
  
  return;
}




