
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ChatScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _LoginName = "";
  var _LoginEmail = "";
  var _LoginPic = "";
  _checklogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("islogin")) {
      setState(() {
        _LoginName = prefs.getString("LoginName");
        _LoginEmail = prefs.getString("LoginEmail");
        _LoginPic = prefs.getString("LoginPic");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checklogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/Images/Background_Image_2.jpg"),
              fit: BoxFit.fill,
            ),
            color: Colors.lightGreen.shade100,
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Account").where("email", isNotEqualTo: _LoginEmail).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.size <= 0) {
                  return Center(
                    child: Text("No Data"),
                  );
                } else {
                  return ListView(
                      children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                      child: Card(
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: FadeInImage.assetNetwork(
                              placeholder: "Assets/Images/Profile_Image_Logo.jpg",
                              image: document["imageurl"],
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(document["name"]),
                          subtitle: Text(document["email"]),
                          trailing: Text(document["contact"]),
                          onTap: () async {
                            var id = document.id.toString();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("Reciverid", id.toString());
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ChatScreen(docid: id))
                            );
                          },
                        ),
                      ),
                      onLongPress: () {
                        AlertDialog alert = new AlertDialog(
                          title: Text("Delete"),
                          content: Text("Are You Sure"),
                          backgroundColor: Colors.blue.shade100,
                          contentPadding: EdgeInsets.all(10),
                          actions: [
                            RaisedButton(
                              child: Text("Yes"),
                              onPressed: () async {
                                var id = document.id.toString();
                                await FirebaseFirestore.instance
                                    .collection("Account")
                                    .doc(id)
                                    .delete();
                                print("\n");
                                print("Product Data Deleted To Firebase");
                                var id1 = await document.id.toString();
                                print("Delete Record : " + id1);
                                print("\n");
                                Fluttertoast.showToast(
                                    msg: "Delete Successful",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                Navigator.of(context).pop();
                              },
                            ),
                            RaisedButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                        showDialog(
                            context: context,
                            builder: (context) {
                              return alert;
                            });
                      },
                    );
                  }).toList());

                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
