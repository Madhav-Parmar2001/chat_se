import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/theme.dart';
import 'bhavik/Update_Register.dart';

class Profile extends StatefulWidget {

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var Fire ="";

  var _Loginid = "";
  var _LoginName = "";
  var _LoginEmail = "";
  var _LoginPic = "";
  getsinglerecord() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _Loginid = prefs.getString("Senderid");
    await FirebaseFirestore.instance.collection("Account").doc(_Loginid).get().then((document){
      setState(() {
        _LoginName = document["name"].toString();
        _LoginEmail = document["email"].toString();
        _LoginPic = document["imageurl"].toString();
      });
    });
    print("\n");
    print(_LoginPic);
    print("\n");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsinglerecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/Images/Background_Image_2.jpg"),
            fit: BoxFit.fitHeight,
          ),
          color: Colors.lightGreen.shade100,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: FadeInImage.assetNetwork(
                    placeholder: "Assets/Gif/Pre_Loader.gif",
                    image: _LoginPic,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 35,),

                Card(
                  elevation: 10,
                  color: Colors.pink.shade50,
                  shadowColor: Colors.red,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("Name : "+_LoginName,style: subTitle,),
                        SizedBox(height: 10,),
                        Text("Gmail : "+_LoginEmail,style: subTitle,),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30,),
                RaisedButton(
                  child: Text("Update"),
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Update_Register())
                    );
                  },
                ),
                SizedBox(height: 20,),
                // RaisedButton(
                //   child: Text("Refresh"),
                //   onPressed: (){
                //     Navigator.replace(
                //         context,
                //         oldRoute: MaterialPageRoute(builder: (context)=>Profile()),
                //         newRoute: MaterialPageRoute(builder: (context)=>Profile()),
                //     );
                //   },
                // )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
