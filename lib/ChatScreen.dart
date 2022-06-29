import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:full_screen_menu/full_screen_menu.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'Play_Video.dart';
import 'View_Image.dart';

class ChatScreen extends StatefulWidget {

  var docid="";
  ChatScreen({this.docid});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  PickedFile imageFile = null;
  File image = null;

  File _video;
  File _cameraVideo;

  ImagePicker picker = ImagePicker();

  // var myFormat1 = DateFormat('d-MMM-yyyy');
  GlobalKey _globalKey = GlobalKey();
  TextEditingController _chat = TextEditingController();
  VideoPlayerController _videoPlayerController;
  VideoPlayerController _cameraVideoPlayerController;

  var _ReciverName = "";
  var _ReciverPic = "";
  var _Senderid = "";
  var _Reciverid = "";
  _getsinglerecord() async
  {
    await FirebaseFirestore.instance.collection("Account").doc(widget.docid).get().then((document){
      setState(() {
        _ReciverName = document["name"].toString();
        _ReciverPic = document["imageurl"].toString();
      });
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _Senderid = prefs.getString("Senderid");
    _Reciverid = prefs.getString("Reciverid");
  }

  _pickImageFromCamera()async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    imageFile = await pickedFile;
    image = File(imageFile.path);

    SimpleDialog alert = await SimpleDialog(
      children: [Center(child: CircularProgressIndicator(),)],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });

    Random random = new Random();
    String imagename = random.nextInt(999999).toString()+".jpg"; // 4526.jpg

    await FirebaseStorage.instance.ref(imagename).putFile(image).whenComplete((){}).then((imagedata) async{
      await imagedata.ref.getDownloadURL().then((fileurl) async{
        await FirebaseFirestore.instance.collection("Account")
            .doc(_Senderid)
            .collection("Chats")
            .doc(_Reciverid).collection("Messages").add({
          "senderid":_Senderid,
          "receiverid":_Reciverid,
          "msg":fileurl,
          "msgtype":"image",
          "timestamp" :DateTime.now().millisecondsSinceEpoch
        });

        await FirebaseFirestore.instance.collection("Account")
            .doc(_Reciverid)
            .collection("Chats")
            .doc(_Senderid).collection("Messages").add({
          "senderid":_Senderid,
          "receiverid":_Reciverid,
          "msg":fileurl,
          "msgtype":"image",
          "timestamp":DateTime.now().millisecondsSinceEpoch
        });
      });
    });

    Fluttertoast.showToast(
        msg: "Camera Image Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.of(context).pop();
  }

  _pickImageFromGallery()async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    imageFile = await pickedFile;
    image = File(imageFile.path);

    SimpleDialog alert = await SimpleDialog(
      children: [Center(child: CircularProgressIndicator(),)],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });

    Random random = new Random();
    String imagename = random.nextInt(999999).toString()+".jpg"; // 4526.jpg

    await FirebaseStorage.instance.ref(imagename).putFile(image).whenComplete((){}).then((imagedata) async{
      await imagedata.ref.getDownloadURL().then((fileurl) async{
        await FirebaseFirestore.instance.collection("Account")
            .doc(_Senderid)
            .collection("Chats")
            .doc(_Reciverid).collection("Messages").add({
          "senderid":_Senderid,
          "receiverid":_Reciverid,
          "msg":fileurl,
          "msgtype":"image",
          "timestamp" :DateTime.now().millisecondsSinceEpoch
        });

        await FirebaseFirestore.instance.collection("Account")
            .doc(_Reciverid)
            .collection("Chats")
            .doc(_Senderid).collection("Messages").add({
          "senderid":_Senderid,
          "receiverid":_Reciverid,
          "msg":fileurl,
          "msgtype":"image",
          "timestamp":DateTime.now().millisecondsSinceEpoch
        });
      });
    });
    Fluttertoast.showToast(
        msg: "Gallary Image Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.of(context).pop();
  }

  _pickVideo() async {

    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
    _video = File(pickedFile.path);

     SimpleDialog alert = await SimpleDialog(
       children: [Center(child: CircularProgressIndicator(),)],
     );
     showDialog(
         context: context,
         builder: (context) {
           return alert;
         });

    // _videoPlayerController = VideoPlayerController.file(_video)
    //   ..initialize().then((_) {
    //     setState(() {});
    //     _videoPlayerController.play();
    //   });

    Random random = new Random();
    String videoname = random.nextInt(999).toString()+".mp4"; // 4526.jpg

    await FirebaseStorage.instance.ref(videoname).putFile(_video).whenComplete((){}).then((videodata) async{
      await videodata.ref.getDownloadURL().then((fileurl) async{
        await FirebaseFirestore.instance.collection("Account")
            .doc(_Senderid)
            .collection("Chats")
            .doc(_Reciverid).collection("Messages").add({
          "senderid":_Senderid,
          "receiverid":_Reciverid,
          "msg":fileurl,
          "msgtype":"video",
          "timestamp" :DateTime.now().millisecondsSinceEpoch
        });

        await FirebaseFirestore.instance.collection("Account")
            .doc(_Reciverid)
            .collection("Chats")
            .doc(_Senderid).collection("Messages").add({
          "senderid":_Senderid,
          "receiverid":_Reciverid,
          "msg":fileurl,
          "msgtype":"video",
          "timestamp":DateTime.now().millisecondsSinceEpoch
        });
      });
    });

    Fluttertoast.showToast(
        msg: "Gallary Video Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.of(context).pop();
  }

  _pickVideoFromCamera() async {

    PickedFile pickedFile = await picker.getVideo(source: ImageSource.camera);
    _cameraVideo = File(pickedFile.path);

    SimpleDialog alert = await SimpleDialog(
      children: [Center(child: CircularProgressIndicator(),)],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });

    // _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)
    //   ..initialize().then((_) {
    //     setState(() {});
    //     _cameraVideoPlayerController.play();
    //   });

    Random random = new Random();
    String videoname = random.nextInt(999).toString()+".mp4"; // 4526.jpg

    await FirebaseStorage.instance.ref(videoname).putFile(_cameraVideo).whenComplete((){}).then((videodata) async{
      await videodata.ref.getDownloadURL().then((fileurl) async{
        await FirebaseFirestore.instance.collection("Account")
            .doc(_Senderid)
            .collection("Chats")
            .doc(_Reciverid).collection("Messages").add({
          "senderid":_Senderid,
          "receiverid":_Reciverid,
          "msg":fileurl,
          "msgtype":"video",
          "timestamp" :DateTime.now().millisecondsSinceEpoch
        });

        await FirebaseFirestore.instance.collection("Account")
            .doc(_Reciverid)
            .collection("Chats")
            .doc(_Senderid).collection("Messages").add({
          "senderid":_Senderid,
          "receiverid":_Reciverid,
          "msg":fileurl,
          "msgtype":"video",
          "timestamp":DateTime.now().millisecondsSinceEpoch
        });
      });
    });

    Fluttertoast.showToast(
        msg: "Camera Video Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.of(context).pop();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getsinglerecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: FadeInImage.assetNetwork(
                placeholder: "Assets/Images/Profile_Image_Logo.jpg",
                image: _ReciverPic,
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15,),
            Text(_ReciverName),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/Images/lake.jpg"),
            fit: BoxFit.fill,
          ),
          color: Colors.lightGreen.shade100,
        ),

        child: Column(
          children: [
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Account")
                        .doc(_Senderid).collection("Chats")
                        .doc(_Reciverid).collection("Messages").orderBy("timestamp", descending: true).snapshots(),
                    builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                    {
                      if(snapshot.hasData) {
                        if(snapshot.data.size<=0) {
                          return Center(child: Text("No Data"));
                        }
                        else {
                          return Container(
                            // margin: EdgeInsets.only(right: 200),
                            child: ListView(

                              reverse: true,
                              children: snapshot.data.docs.map((document){

                                return(document["senderid"]==_Senderid)
                                    ?Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 5,bottom: 5,right: 10),
                                      padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.pink.shade100,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        // color: Colors.purple.shade100,
                                        child: (document["msgtype"]=="text")
                                            ?Text(document["msg"],style: TextStyle(fontSize: 17),)
                                            :
                                        (document["msgtype"]=="image")
                                            ?GestureDetector(
                                              child: FadeInImage.assetNetwork(
                                          placeholder: "Assets/Gif/Pre_Loader.gif",
                                          image: document["msg"],
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                          onTap: () async {
                                            var imagelink2 = document["msg"];
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(builder: (context) => View_Image(image_link_2: imagelink2))
                                            // );
                                          },
                                            )
                                            :GestureDetector(
                                          child: Image.asset("Assets/Images/Video_Play_5.png",width: 150,height: 150,),
                                          onTap: () async {
                                            var videolink2 = document["msg"];
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) => Play_Video(video_link_2: videolink2))
                                            );
                                          },
                                        )
                                    ),
                                    onLongPress: (){
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
                                              await FirebaseFirestore.instance.collection("Account")
                                                  .doc(_Senderid).collection("Chats")
                                                  .doc(_Reciverid).collection("Messages")
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
                                                  gravity: ToastGravity.BOTTOM,
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
                                  ),
                                )
                                    :Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 5,bottom: 5,left: 10),
                                      padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.purple.shade100,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        // color: Colors.purple.shade100,
                                        child: (document["msgtype"]=="text")
                                            ?Text(document["msg"],style: TextStyle(fontSize: 17),)
                                            :
                                        (document["msgtype"]=="image")
                                            ?GestureDetector(
                                              child: FadeInImage.assetNetwork(
                                          placeholder: "Assets/Gif/Pre_Loader.gif",
                                          image: document["msg"],
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                          onTap: () async {
                                            var imagelink2 = document["msg"];
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(builder: (context) => View_Image(image_link_2: imagelink2))
                                            // );
                                          },
                                            )
                                            :GestureDetector(
                                          child: Image.asset("Assets/Images/Video_Play_5.png",width: 150,height: 150,),
                                          onTap: () async {
                                            var videolink2 = document["msg"];
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) => Play_Video(video_link_2: videolink2))
                                            );
                                          },
                                        )
                                    ),
                                    onLongPress: (){
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
                                              await FirebaseFirestore.instance.collection("Account")
                                                  .doc(_Reciverid).collection("Chats")
                                                  .doc(_Senderid).collection("Messages")
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
                                                  gravity: ToastGravity.BOTTOM,
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
                                  ),
                                );

                                // return Container(
                                //   margin: EdgeInsets.all(2),
                                //   padding: EdgeInsets.all(10),
                                //   width: 200,
                                //   height: 45,
                                //   decoration: BoxDecoration(
                                //     color: Colors.purple.shade100,
                                //     borderRadius: BorderRadius.circular(15),
                                //   ),
                                //   child: Text(document["msg"],style: TextStyle(fontSize: 17),),
                                // );
                              }).toList(),
                            ),
                          );
                        }
                      }
                      else
                      {
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue.shade100,
              ),
              child: Form(
                key: _globalKey,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 150,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //image
                                    IconButton(
                                      icon: Icon(Icons.camera_alt_outlined),
                                      onPressed: (){
                                        _pickImageFromCamera();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.photo_size_select_actual_outlined),
                                      onPressed: (){
                                        _pickImageFromGallery();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    //video
                                    IconButton(
                                      icon: Icon(Icons.video_call),
                                      onPressed: (){
                                        _pickVideoFromCamera();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.video_collection),
                                      onPressed: (){
                                        _pickVideo();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _chat,
                        decoration: InputDecoration(
                          hintText: "type message",
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async{

                        var msg = _chat.text.toString();
                        print("Senderid : "+_Senderid);
                        print("Reciverid : "+_Reciverid);
                        print("Chat : "+msg);
                        _chat.text="";
                        await FirebaseFirestore.instance.collection("Account")
                            .doc(_Senderid).collection("Chats")
                            .doc(_Reciverid).collection("Messages").add({
                          "senderid" : _Senderid,
                          "receiverid" : _Reciverid,
                          "msg" : msg,
                          "msgtype":"text",
                          "timestamp" : DateTime.now().millisecondsSinceEpoch,
                        });
                        await FirebaseFirestore.instance.collection("Account")
                            .doc(_Reciverid).collection("Chats")
                            .doc(_Senderid).collection("Messages").add({
                          "senderid" : _Senderid,
                          "receiverid" : _Reciverid,
                          "msg" : msg,
                          "msgtype":"text",
                          "timestamp" : DateTime.now().millisecondsSinceEpoch,
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}


// Text(document["msg"]),
// Text(document["timestamp"].toString()),
// Text(DateTime.fromMillisecondsSinceEpoch(document["timestamp"]).toString()),
// Text("${myFormat1.format(
//     DateTime.fromMillisecondsSinceEpoch(document["timestamp"]).toString()
// )}"),
// Text(DateFormat('kk:mm:a').format(DateTime.fromMillisecondsSinceEpoch(document["timestamp"]).toString())),