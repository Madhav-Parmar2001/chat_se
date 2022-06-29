
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/theme.dart';
import 'RegisterPage.dart';
import 'Tab_View.dart';

class LogInScreen extends StatefulWidget {

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {


  GlobalKey _globalKey = GlobalKey();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  _checklogin2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("islogin")) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Tab_View())
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checklogin2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: aDefaultPadding,
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120.0,
                ),
                Text(
                  "Welcome Back",
                  style: titleText,
                ),

                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "New to this app?",
                  style: subTitle,
                ),

                SizedBox(
                  height: 10.0,
                ),
                // Text("Email"),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: aTextFieldColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: aPrimaryColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),
                // Text("Password"),
                TextFormField(
                  controller: _password,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: aTextFieldColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: aPrimaryColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),

                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: aPrimaryColor,
                    ),
                    child: Text(
                      "Log In",
                      style: textButton.copyWith(color: aWhiteColor),
                    ),
                  ),

                  onTap: () async {
                    var Email = _email.text.toString();
                    var Password = _password.text.toString();

                    if (_email.text == "" && _password.text == "") {
                      print("Please Enter Email & Password");
                    } else {
                      await FirebaseFirestore.instance.collection("Account")
                          .where("email", isEqualTo: Email)
                          .where("password", isEqualTo: Password)
                          .get().then((documents) {
                        if (documents.size <= 0) {
                          print("Login Failed!");
                          Fluttertoast.showToast(
                              msg: "Login Failed",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        } else {
                          documents.docs.forEach((element) async {
                            var Senderid = element.id.toString();
                            var LoginName = element["name"].toString();
                            var LoginEmail = element["email"].toString();
                            var LoginPic = element["imageurl"].toString();

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("islogin", "yes");
                            prefs.setString("Senderid", Senderid.toString());
                            prefs.setString("LoginName", LoginName.toString());
                            prefs.setString("LoginEmail", LoginEmail.toString());
                            prefs.setString("LoginPic", LoginPic.toString());

                            Fluttertoast.showToast(
                                msg: "Login Successful",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => Tab_View())
                            );
                          });
                          //print("Name : "+document.["name"].toString());
                        }
                      });
                    }
                  },
                ),

                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    "Or",
                    style: textButton,
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: TextButton(
                    child: Text(
                      "create Account",
                      style: textButton,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RegisterPage())
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
