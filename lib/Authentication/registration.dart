
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalyear/colors.dart';
import 'login.dart';
import 'package:finalyear/Authservice/Authentication.dart';
import 'package:finalyear/usermodel/user.dart';
String otp;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final AuthService _auth=AuthService();
  final key = GlobalKey<ScaffoldState>();
  final nameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final mobileController = new TextEditingController();

  bool privacyCheck = false;
  bool drinkingCheck = false;
  bool canRegister = false;
 String fvalue;
  // Registration variables
  String smsCode, verificationId;
  bool codeSent = false;
  bool verified = false;
  bool registered = false;
  //AuthCredential loginKey;
 final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: getBody(),
      backgroundColor: blueColor,
    );
  }
  getBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: getContents(),
      ),
    );
  }

  getContents() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            height: height * 0.2,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(child: new Image.asset('assets/images/logo.jpg')),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            height: height * 0.042,
            width: MediaQuery.of(context).size.width / 1.35,
            child: Center(
                child: new Text('Register',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: height * 0.04,
                        fontWeight: FontWeight.bold))),
          ),
          
          SizedBox(
            height: height * 0.01,
          ),
         Container(
            height: 45.0,
            width: MediaQuery.of(context).size.width / 1.35,
            child: new TextFormField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  hintText: 'Full Name',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  disabledBorder: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              controller: nameController,
              validator: (val) => val.isEmpty ? 'Name cannot be empty' : null,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 45.0,
            width: MediaQuery.of(context).size.width / 1.35,
            child: new TextFormField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  hintText: 'E-Mail Id',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  disabledBorder: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              controller: emailController,
              validator: (val) => val.isEmpty ? 'email cannot be empty' : null,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
           Container(
            height: 45.0,
            width: MediaQuery.of(context).size.width / 1.35,
            child: new TextFormField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  disabledBorder: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              keyboardType: TextInputType.number,
              controller: passwordController,
              obscureText: true,
              validator: (val) => val.length < 6
                                    ? 'Enter a password atleast 6 chars long'
                                    : null,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 45.0,
            width: MediaQuery.of(context).size.width / 1.35,
            child: new TextFormField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  hintText: 'Mobile Number',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  disabledBorder: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              keyboardType: TextInputType.number,
              controller: mobileController,
              validator: (val) => val.length!=10 ? ' Enter Valid mobile Number' : null,
            ),
          ),
          
              /*Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.013, horizontal: width * 0.025),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.email),
                          iconSize: height * 0.03,
                          onPressed: null),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(
                                  right: width * 0.025, left: 0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle:
                                        TextStyle(fontSize: height * 0.023),
                                    border: InputBorder.none),
                               obscureText: true,
                                controller: passwordController,
                                validator: (val) => val.length < 6
                                    ? 'Enter a password atleast 6 chars long'
                                    : null,
                              )))
                    ],
                  ),
                )),
          ),*/
        /*  Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.call),
                          iconSize: height * 0.03,
                          onPressed: null),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right: 20, left: 0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Mobile Number ',
                                    hintStyle:
                                        TextStyle(fontSize: height * 0.023),
                                    border: InputBorder.none),
                                keyboardType: TextInputType.number,
                                controller: mobileController,
                                validator: (val) => val.length != 10
                                    ? 'Enter a valid 10 digit mobile number'
                                    : null,
                              )))
                    ],
                  ),
                )),
          ),*/
          SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            height: height * 0.02,
          ),
              MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0)),
            onPressed: () async{
               if (_formKey.currentState.validate()) {
  
                    dynamic result=await _auth.registerwithemailpassword(emailController.text, passwordController.text);
                     if(result==null)
                     {
                      key.currentState.showSnackBar(SnackBar(
                      content: new Text(
                          'Invalid email address or it has been used before'),
                      duration: Duration(
                        seconds: 5,
                      )));
                     }
                     else
               {
                  userSetup(nameController.text,mobileController.text,emailController.text);
                 key.currentState.showSnackBar(SnackBar(
                      content: new Text(
                          'Verification email has been sent to your email please verify!'),
                      duration: Duration(
                        seconds: 10,
                      )));
                      
               }
               }
                   
                 else {
                  key.currentState.showSnackBar(SnackBar(
                      content: new Text(
                          'Something Went Wrong !! Please try again later'),
                      duration: Duration(
                        seconds: 10,
                      )));
                }
              },
            
            minWidth: MediaQuery.of(context).size.width / 1.35,
            color: brownColor,
            child: Text("Continue",
                style: TextStyle(color: Colors.white, fontSize: height * 0.04)),
            height: height * 0.08,
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account? ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.02,
                      color: Colors.white)),
              GestureDetector(
                  child: Text(' Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: height * 0.02,
                          color: Colors.green)),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => LogIn()));
                  })
            ],
          ),
          Padding(padding: EdgeInsets.all(15.0)),
        ],
      ),
    );
  }
/*
  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      // AuthService().signIn(authResult);
      FirebaseAuth.instance.signInWithCredential(authResult).then((user) async {
        if (emailController != null &&
            mobileController != null &&
            nameController != null &&
            passwordController != null) {
          canRegister = true;
        }
        await FirebaseAuth.instance.currentUser();
        await Firestore.instance
            .collection('ShopKeeperUser')
            .document(user.user.uid)
            .setData({
          "email": emailController.text,
          "password": passwordController.text,
          "phone": mobileController.text,
          "username": nameController.text,
        });
      });
      setState(() async {
        this.verified = true;
        this.loginKey = authResult;
        otpController.text = smsCode;
      });
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');

      if (registered)
        key.currentState.showSnackBar(SnackBar(
          content: new Text('Already Registered please try Login'),
        ));

      registered = false;
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}

// ignore: camel_case_types
class otpField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: width * 0.0375),
      height: height * 0.04,
      width: width * 0.075,
      child: Container(
          alignment: Alignment.bottomCenter,
          child: TextField(
            decoration:
                InputDecoration(counterText: '', border: InputBorder.none),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            maxLengthEnforced: true,
            onChanged: (value) {
              otp = otp + value.toString();
              print(otp);
            },
          )),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }*/
}
