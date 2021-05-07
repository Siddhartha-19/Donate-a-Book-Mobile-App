import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'Authentication/login.dart';
import 'package:provider/provider.dart';
import 'usermodel/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Authservice/Authentication.dart';
import 'navigation.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
      duration: 2000,  
      splash: Image.asset("assets/images/logo.jpg"), 
      nextScreen: checkscreen(),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 200,
      backgroundColor: Colors.white30,
      
      )
    );
  }
}


class  checkscreen extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value:AuthService().user, 
   child:MaterialApp(
     debugShowCheckedModeBanner: false,
     home: Checkloggedin(),
   )
    );
  }
}
class Checkloggedin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    //print(user);
    if(user==null)
    {
    return LogIn();
      }
    else{
      return HomeScreen();
    }
  }
}



