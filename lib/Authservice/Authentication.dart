import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finalyear/usermodel/user.dart';
class AuthService {
  final FirebaseAuth _auth= FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user !=null ? User(uid:user.uid):null;
  }
  Stream<User> get user
  {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);

  }
 
   Future registerwithemailpassword(String email,String password) async
      {
         AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
          FirebaseUser user=result.user;
          print(user.uid);
        try{
         await user.sendEmailVerification();
        return _userFromFirebaseUser(user);
        }
        catch(e)
        {
           print("An error occured while trying to send email verification");
          print(e.toString());
          return null;
        }

      }
Future signinwithemailpassword(String email,String password) async
      {
        try{
          AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
          FirebaseUser user=result.user;
          if (user.isEmailVerified){
          return _userFromFirebaseUser(user);
          }
          else
          {
            FirebaseAuth.instance.signOut();
            if (!user.isEmailVerified) {
  await user.sendEmailVerification();
}
          }
        }
        catch(e)
        {
          print(e.toString());
          return null;
        }

      }

  // signOut
  signOut() {
    FirebaseAuth.instance.signOut();
  }
}