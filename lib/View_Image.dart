// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
// class View_Image extends StatefulWidget {
//
//   var image_link_2="";
//   View_Image({this.image_link_2});
//
//   @override
//   _View_ImageState createState() => _View_ImageState();
// }
//
// class _View_ImageState extends State<View_Image> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Image"),
//       ),
//       body: Center(
//         child: PhotoView(
//           imageProvider: NetworkImage(widget.image_link_2),
//           // minScale: PhotoViewComputedScale.contained * 0.8,
//           // maxScale: PhotoViewComputedScale.covered * 2,
//           loadingBuilder: (context, event) => Center(
//             child: Container(
//               width: 30.0,
//               height: 30.0,
//               child: CircularProgressIndicator(
//                 backgroundColor:Colors.orange,
//                 value: event == null
//                     ? 0
//                     : event.cumulativeBytesLoaded / event.expectedTotalBytes,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
