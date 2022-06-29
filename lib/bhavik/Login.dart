// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Home.dart';
// import 'Register.dart';
// import '../Tab_View.dart';
//
// ascls Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//
//   GlobalKey _globalKey = GlobalKey();
//   TextEditingController _email = TextEditingController();
//   TextEditingController _password = TextEditingController();
//
//   _checklogin2() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey("islogin")) {
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => Tab_View())
//       );
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _checklogin2();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Form(
//             key: _globalKey,
//             child: Padding(
//               padding: EdgeInsets.all(30.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 60),
//                   Center(
//                       child: Text("Login", style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.blue.shade600),
//                       )),
//
//                   SizedBox(height: 10),
//                   Text("Email : "),
//
//                   SizedBox(height: 3),
//                   TextFormField(
//                     keyboardType: TextInputType.emailAddress,
//                     controller: _email,
//                   ),
//
//                   SizedBox(height: 10),
//                   Text("Password : "),
//
//                   SizedBox(height: 3),
//                   TextFormField(
//                     keyboardType: TextInputType.visiblePassword,
//                     controller: _password,
//                   ),
//
//                   SizedBox(height: 50),
//                   Center(
//                     child: ElevatedButton(
//                       child: Text("Login"),
//                       onPressed: () async {
//                         var Email = _email.text.toString();
//                         var Password = _password.text.toString();
//
//                         if (_email.text == "" && _password.text == "") {
//                           print("Please Enter Email & Password");
//                         } else {
//                           await FirebaseFirestore.instance.collection("Account")
//                               .where("email", isEqualTo: Email)
//                               .where("password", isEqualTo: Password)
//                               .get().then((documents) {
//                             if (documents.size <= 0) {
//                               print("Login Failed!");
//                               Fluttertoast.showToast(
//                                   msg: "Login Failed",
//                                   toastLength: Toast.LENGTH_SHORT,
//                                   gravity: ToastGravity.CENTER,
//                                   timeInSecForIosWeb: 1,
//                                   backgroundColor: Colors.red,
//                                   textColor: Colors.white,
//                                   fontSize: 16.0);
//                             } else {
//                               documents.docs.forEach((element) async {
//                                 var Senderid = element.id.toString();
//                                 var LoginName = element["name"].toString();
//                                 var LoginEmail = element["email"].toString();
//                                 var LoginPic = element["imageurl"].toString();
//
//                                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                                 prefs.setString("islogin", "yes");
//                                 prefs.setString("Senderid", Senderid.toString());
//                                 prefs.setString("LoginName", LoginName.toString());
//                                 prefs.setString("LoginEmail", LoginEmail.toString());
//                                 prefs.setString("LoginPic", LoginPic.toString());
//                                 Navigator.of(context).pushReplacement(
//                                     MaterialPageRoute(builder: (context) => Tab_View())
//                                 );
//                               });
//                               //print("Name : "+document.["name"].toString());
//                             }
//                           });
//                         }
//                       },
//                     ),
//                   ),
//
//                   SizedBox(height: 10),
//                   Center(
//                     child: Text("or"),
//                   ),
//
//                   SizedBox(height: 10),
//                   Center(
//                     child: TextButton(
//                       child: Text("Create Account"),
//                       onPressed: () {
//                         Navigator.of(context).push(
//                             MaterialPageRoute(builder: (context) => Register())
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
