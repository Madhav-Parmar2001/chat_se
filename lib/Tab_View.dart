import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home.dart';
import 'LoginPage.dart';
import 'Profile.dart';

class Tab_View extends StatefulWidget
{
  @override
  Tab_ViewState createState() => Tab_ViewState();
}

class Tab_ViewState extends State<Tab_View> {

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: FadeInImage.assetNetwork(
                      placeholder: "Assets/Gif/Pre_Loader.gif",
                      image: _LoginPic,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                accountName: Text(_LoginName),
                accountEmail: Text(_LoginEmail),
              ),
              Divider(),

              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove("islogin");
                  prefs.remove("_LoginName");
                  prefs.remove("_LoginEmail");
                  Fluttertoast.showToast(
                      msg: "Logout",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LogInScreen()));
                },
              ),
              Divider(),
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled)
          {
            return <Widget>[
              new SliverAppBar(
                title: Text("Chat App"),
                pinned: true,
                // floating: true,
                bottom: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      child: Text("Chats"),
                    ),
                    Tab(
                      child: Text("Profile"),
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
              children: [
                Home(),
                Profile(),
              ]
          ),
        ),
      ),
    );
  }
}
