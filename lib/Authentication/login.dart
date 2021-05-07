import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:finalyear/Authservice/Authentication.dart';
import 'package:finalyear/colors.dart';
import 'package:finalyear/Authentication/registration.dart';
class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool checkBox = false;
  String phoneNo, verificationId, smsCode;
  String error='';
  bool codeSent = false;
  bool verified = false;
  final idController = TextEditingController();
  final passwordController = new TextEditingController();
  final key = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  bool canLogin = false;
  String _userNumber = "", _password = "";


AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Form(
            key: formKey,
            child: getContents(),
          ),
        ],
      ),
    );
  }

  getContents() {
    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          Container(
            height: height*0.2,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(child: new Image.asset('assets/images/logo.jpg')),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width / 1.35,
            child: Center(
                child: new Text('Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: height*0.04,
                        fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width / 1.35,
            child: new TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.grey[200],
                    width: 1.8,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.grey[200],
                    width: 1.8,
                  ),
                ),
                hintText: 'Enter Your email id',
                hintStyle: TextStyle(
                  fontSize: height*0.02
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
              controller: idController,
              keyboardType: TextInputType.text,
              validator: (val) => val.isEmpty ? 'email can\'t be empty' : null,
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width / 1.35,
            child: new TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.grey[200],
                    width: 1.8,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Colors.grey[200],
                    width: 1.8,
                  ),
                ),
                hintText: 'Enter Your Password',
                hintStyle: TextStyle(
                    fontSize: height*0.02
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
              controller: passwordController,
              validator: (val) => val.length < 6
                  ? 'Enter a valid minimum 6 chars long password'
                  : null,
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            onPressed: () async {
              if(formKey.currentState.validate())
              {
              dynamic result = await _auth.signinwithemailpassword(idController.text,passwordController.text);
         
               if(result==null)
                       {
                         setState(() {
                           error='Please enter valid email or password';
                           
                         });
                       }
              }
              },
              
          
           minWidth: MediaQuery.of(context).size.width / 1.35,
          color: brownColor,
            child: Text("Login",
              style: TextStyle(
                  fontSize: height*0.02,
                color: Colors.white
              ),),
            height: height*0.05,
          ),
          SizedBox(
            height: 45.0,
          ),
          Text(error),
          getRegisterRow(),
          
        ],
        
      ),
    );
  }

  getRegisterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Text('Don\'t have an account ? ',
            style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.white)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegistrationScreen()));
          },
          child:
              Text('Register', style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.white)),
        )
      ],
    );
  }

  /*getVerified() async {
    var user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance
        .collection('delivery-users')
        .document(user.uid)
        .get()
        .then((value) {
      print(value.data['password'] + " : - Password of the user");
      if (passwordController.text == value.data['password']) {
        setState(() {
          print(value.data['password'] + ' 8**********');
          _password = value.data['password'];
          canLogin = true;
        });
      }
    });
  }*/
}
/*
bool passnew = false;
bool valid;

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  AuthResult authresult;

  final formkey = GlobalKey<FormState>();
  bool islogin = true;
  String email = "";
  String password = "";

  final auth = FirebaseAuth.instance;
  var loading = false;

  void submitting(String email, String username, String password, String phone,
      BuildContext ctx) async {
    AuthResult authresult;
    try {
      setState(() {
        loading = true;
      });
      authresult = await auth.createUserWithEmailAndPassword(
          email: phone + "@test.com", password: password);
      await Firestore.instance
          .collection('users_main')
          .document(authresult.user.uid)
          .setData({
        'username': username,
        'email': email,
        'phone': phone,
        'password': password,
      });
      user = username;
      phoning = phone;
      mail = email;
      currentSelectedIndex = 6;

      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Homepage()));
    } on PlatformException catch (error) {
      var message = ' An error occured, please check credentials';
      if (error.message != null) {
        message = error.message;
      }

      /*  Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 5),
      ));
*/

      Alert(
        context: context,
        type: AlertType.error,
        title: "Error",
        buttons: [
          DialogButton(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          )
        ],
      ).show();
      setState(() {
        loading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        loading = false;
      });
    }
  }

  void submit(
      String phone, String password, bool login, BuildContext ctx) async {
    try {
      setState(() {
        loading = true;
      });

      authresult = await auth.signInWithEmailAndPassword(
          email: phone + "@test.com", password: password);
      final media =
          await Firestore.instance.collection('users_main').getDocuments();
      final orders =
          await Firestore.instance.collection('orders_cod').getDocuments();

      int i;
      for (i = 0; i < media.documents.length; i++)
        if (media.documents[i]['phone'] == email) {
          user = media.documents[i]['username'];
          phoning = media.documents[i]['phone'];
          mail = media.documents[i]['email'];

          break;
        }
      for (int j = 0; j < orders.documents.length; j++) {
        if (orders.documents[j]['mobile phone number'] == phoning ||
            orders.documents[j]['alternate number'] == phoning) {
          Meals_list_ordered.add({
            'id': 'Order ${orders.documents.length + 1}',
            'loc': 'images/pp.png',
            'status': 'ordered',
            'amount': orders.documents[j]['total'],
            'mode': 7,
          });
        }
      }
      currentSelectedIndex = 6;
      print(user);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Homepage()));
    } on PlatformException catch (error) {
      var message = ' An error occured, please check credentials';
      if (error.message != null) {
        message = error.message;
      }

      /*  Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 5),
      ));
*/

      Alert(
        context: context,
        type: AlertType.error,
        title: "Error",
        buttons: [
          DialogButton(
            child: Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
            color: Colors.white,
            onPressed: () async {
              Navigator.pop(context);
            },
          )
        ],
      ).show();
      setState(() {
        loading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        loading = false;
      });
    }
  }

  void trysubmit() async {
    valid = formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (valid) {
      formkey.currentState.save();
      submit(email.trim(), password.trim(), islogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'images/rtigger2.png',
            ),
            fit: BoxFit.cover,
          )),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 10.0),
                  child: Image.asset(
                    'images/logo.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.width / 2.5,
                  ),
                ),
                Container(
                    child: Text('Login',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  width: 0.8 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      //obscureText: true,
                      key: ValueKey('email'),

                      style: TextStyle(
                          color: Color.fromRGBO(00, 44, 64, 1),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,

                      decoration: InputDecoration(
                        hintText: '  Enter Mobile Number',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromRGBO(00, 44, 64, 1),
                        ),
                        border: InputBorder.none,
                      ),

                      onChanged: (val) {
                        email = val.trim();
                      },
                      onSaved: (value) {
                        email = value.trim();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                if (!passnew)
                  Container(
                    width: 0.8 * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        key: ValueKey('password'),
                        obscureText: true,
                        style: TextStyle(
                            color: Color.fromRGBO(00, 44, 64, 1),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: '  Enter Your Password',
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            color: Color.fromRGBO(00, 44, 64, 1),
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                        onSaved: (value) {
                          password = value;
                        },
                      ),
                    ),
                  ),
                if (!passnew)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: width * 0.4,
                      ),
                      FlatButton(
                          onPressed: () async {
                            final media = await Firestore.instance
                                .collection('users_main')
                                .getDocuments();
                            int i;
                            for (i = 0; i < media.documents.length; i++)
                              if (media.documents[i]['phone'] == email) {
                                pass = media.documents[i]['password'];
                                mobile = media.documents[i]['phone'];
                                ema = media.documents[i]['email'];
                                phoning = media.documents[i]['phone'];
                                mail = ema;
                                name = media.documents[i]['username'];
                                user = name;

                                id = media.documents[i].documentID;
                                print(id);
                                break;
                              }
                            print(user);
                            if (i == media.documents.length)
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "Error",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Mobile Number Does Not Exist",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                    color: Colors.white,
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ).show();
                            else {
                              authresult =
                                  await auth.signInWithEmailAndPassword(
                                      email: mobile + "@test.com",
                                      password: pass);

                              Firestore.instance
                                  .collection('users')
                                  .document(id)
                                  .delete();
                              currentSelectedIndex = 6;

                              authresult.user.delete();
                              setState(() {
                                passnew = true;
                              });
                            }
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Color.fromRGBO(173, 173, 117, 1),
                            ),
                            textAlign: TextAlign.right,
                          )),
                    ],
                  ),
                if (passnew)
                  Container(
                    width: 0.8 * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        key: ValueKey('password'),
                        obscureText: true,
                        style: TextStyle(
                            color: Color.fromRGBO(00, 44, 64, 1),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: '  Enter Your New Password',
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            color: Color.fromRGBO(00, 44, 64, 1),
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                        onSaved: (value) {
                          password = value;
                        },
                      ),
                    ),
                  ),
                Container(
                  width: 0.8 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.lime[800],
                    color: Color.fromRGBO(173, 173, 117, 1),
                  ),
                  child: FlatButton(
                    color: Color.fromRGBO(173, 173, 117, 1),
                    onPressed: () {
                      passnew
                          ? submitting(ema, name, password, mobile, context)
                          : trysubmit();

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Homepage()));
                    },
                    child: loading
                        ? CircularProgressIndicator()
                        : Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't Have An Account?",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => SignUp()));
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Color.fromRGBO(173, 173, 117, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/