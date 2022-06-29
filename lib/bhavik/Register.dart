// import 'dart:io';
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import '../LoginPage.dart';
// import 'Login.dart';
//
// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//
//   GlobalKey _globalKey = GlobalKey();
//   TextEditingController _name = TextEditingController();
//   TextEditingController _contact = TextEditingController();
//   TextEditingController _email = TextEditingController();
//   TextEditingController _password = TextEditingController();
//
//   final RegExp lettersonly = new RegExp(r'^[a-zA-Z" "]+$'); //Name
//
//   var _gender = "male";
//   _radioMethod(v){
//     setState(() {
//       _gender = v;
//     });
//   }
//
//   PickedFile _imageFile = null;
//   File _image = null;
//
//   _getCamera()async{
//     final _pickedFile = await ImagePicker().getImage(
//       source: ImageSource.camera,
//     );
//     setState(() {
//       _imageFile = _pickedFile;
//       _image = File(_imageFile.path);
//     });
//   }
//
//   _gatGallery()async{
//     final _pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery,
//     );
//     setState(() {
//       _imageFile = _pickedFile;
//       _image = File(_imageFile.path);
//     });
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
//
//                   SizedBox(height: 60,),
//                   Center(
//                       child: Text("Create Account",style: TextStyle(
//                           fontSize: 40,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.blue.shade600
//                       ),)
//                   ),
//
//                   SizedBox(height: 10),
//                   Text("Name : "),
//
//                   SizedBox(height: 3),
//                   TextFormField(
//                     validator: (val) {
//                       if (val.isEmpty) {
//                         return ("Enter Name");
//                       } else if (!lettersonly.hasMatch(val)) {
//                         return "Only Letters Allowed";
//                       }
//                       return null;
//                     },
//                     keyboardType: TextInputType.name,
//                     controller: _name,
//                   ),
//
//                   SizedBox(height: 10),
//                   Text("Contact : "),
//
//                   SizedBox(height: 3),
//                   TextFormField(
//                     maxLength: 10,
//                     keyboardType: TextInputType.phone,
//                     controller: _contact,
//                   ),
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
//                     obscureText: true,
//                     keyboardType: TextInputType.visiblePassword,
//                     controller: _password,
//                   ),
//
//                   SizedBox(height: 10),
//                   Text("Gender :"),
//                   SizedBox(height: 3),
//                   Row(
//                     children: [
//                       Radio(
//                         value: "male",
//                         groupValue: _gender,
//                         onChanged: _radioMethod,
//                         activeColor: Colors.blue,
//                       ),
//                       Container(
//                         child: Text("Male"),
//                       ),
//
//                       SizedBox(width: 20),
//                       Radio(
//                         value: "female",
//                         groupValue: _gender,
//                         onChanged: _radioMethod,
//                         activeColor: Colors.blue,
//                       ),
//                       Container(
//                         child: Text("Female"),
//                       )
//                     ],
//                   ),
//
//                   SizedBox(height: 20),
//                   Center(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(400),
//                       child: (_image!=null)
//                           ?Image.file(_image,height: 150,width: 150,fit: BoxFit.cover,)
//                           :Image.asset("Assets/Images/Upload_Your_Photo.jpg",height: 150,width: 150,fit: BoxFit.cover,),
//                     ),
//                   ),
//
//                   SizedBox(height: 20),
//                   Row(
//                     children: [
//                       SizedBox(width: 20),
//                       Expanded(
//                         child: ElevatedButton(
//                           child: Text("Camera"),
//                           onPressed: (){
//                             _getCamera();
//                           },
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       Expanded(
//                         child: ElevatedButton(
//                           child: Text("Gallery"),
//                           onPressed: (){
//                             _gatGallery();
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   SizedBox(height: 50),
//                   Center(
//                     child: ElevatedButton(
//                       child: Text("Register"),
//                       onPressed: () async{
//                         var Name = _name.text.toString();
//                         var Contact = _contact.text.toString();
//                         var Email = _email.text.toString();
//                         var Password = _password.text.toString();
//
//                         if(_email.text=="" && _password.text=="") {
//                           print("Please Enter Details");
//                         }
//                         else {
//
//                           SimpleDialog alert = await SimpleDialog(
//                             children: [Center(child: CircularProgressIndicator(),)],
//                           );
//                           showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return alert;
//                               });
//                           // Fluttertoast.showToast(
//                           //     msg: "Creating New Account",
//                           //     toastLength: Toast.LENGTH_LONG,
//                           //     gravity: ToastGravity.BOTTOM,
//                           //     timeInSecForIosWeb: 10,
//                           //     backgroundColor: Colors.green,
//                           //     textColor: Colors.white,
//                           //     fontSize: 16.0
//                           // );
//                           Random random = new Random();
//                           String imagename = random.nextInt(9999).toString()+".jpg"; // 4526.jpg
//
//                           //Diuplication
//
//                           await FirebaseFirestore.instance.collection("Account")
//                               .where("email",isEqualTo: Email).get().then((document) async {
//                             if(document.size<=0)
//                               {
//                                 await FirebaseStorage.instance.ref(imagename).putFile(_image).whenComplete((){}).then((filedata)async{
//                                   await filedata.ref.getDownloadURL().then((imagelink)async{
//                                     await FirebaseFirestore.instance.collection("Account").add({
//                                       "name" : Name,
//                                       "contact" : Contact,
//                                       "email" : Email,
//                                       "password" : Password,
//                                       "_gender" : _gender,
//                                       "imagename" : imagename,
//                                       "imageurl" : imagelink,
//                                     }).then((value) {
//                                       print("\n");
//                                       print("Account Register Successful");
//                                       print("\n");
//                                       Fluttertoast.showToast(
//                                           msg: "Register Successful",
//                                           toastLength: Toast.LENGTH_SHORT,
//                                           gravity: ToastGravity.CENTER,
//                                           timeInSecForIosWeb: 1,
//                                           backgroundColor: Colors.green,
//                                           textColor: Colors.white,
//                                           fontSize: 16.0
//                                       );
//                                       Navigator.of(context).pop();
//                                       Navigator.of(context).pop();
//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(builder: (context) => LogInScreen())
//                                       );
//                                     });
//                                   });
//                                 });
//                               }
//                             else
//                               {
//                                 print("Email Already Exist!");
//                                 Fluttertoast.showToast(
//                                     msg: "Email Already Exist!",
//                                     toastLength: Toast.LENGTH_SHORT,
//                                     gravity: ToastGravity.CENTER,
//                                     timeInSecForIosWeb: 1,
//                                     backgroundColor: Colors.red,
//                                     textColor: Colors.white,
//                                     fontSize: 16.0
//                                 );
//                               }
//                           });
//                         }
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
