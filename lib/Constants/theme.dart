import 'package:flutter/material.dart';

const aDefaultPadding = EdgeInsets.symmetric(horizontal: 30);
const aPrimaryColor = Color(0xFF1B383A);
const aSecondaryColor = Color(0xFF59706F);
const aTextFieldColor = Color(0xFF979797);
const aWhiteColor = Color(0xFFFFFFFF);


TextStyle titleText = TextStyle(color: aPrimaryColor, fontSize: 32, fontWeight: FontWeight.w700);
TextStyle subTitle = TextStyle(color: aSecondaryColor, fontSize: 18, fontWeight: FontWeight.w500);
TextStyle textButton = TextStyle(color: aPrimaryColor, fontSize: 18, fontWeight: FontWeight.w700);


// import 'package:flutter/material.dart';
// import 'package:flutter_tutorial/widgets/exit-popup.dart';
//
// class HomePage extends StatefulWidget {
//   HomePageState createState() => HomePageState();
// }
//
// class HomePageState extends State<HomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return WillPopScope(
//       onWillPop: () => showExitPopup(context),
//       child: Scaffold(
//           appBar: AppBar(title: Text("Flutter Tutorial"),),
//           body: Center(
//             child: Text("Welcome"),
//           )
//       ),
//     );
//
//   }
//
// }


