// import 'dart:async';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' show join;
// import 'package:path_provider/path_provider.dart';
// import 'package:image_picker/image_picker.dart';

// class TakePhoto extends StatefulWidget {
//   const TakePhoto({
//     Key key,
//   }) : super(key: key);

//   @override
//   TakePictureScreenState createState() => TakePictureScreenState();
// }

// class TakePictureScreenState extends State<TakePhoto> {
//   CameraController _controller;
//   CameraDescription camera;
//   Future<void> _initializeControllerFuture;
//   bool isLoading = false;
//   String name;
//   List<CameraDescription> cameras;
//   void loadCamera() async {
//     cameras = await availableCameras();
//     camera = cameras.first;
//     _controller = CameraController(
//       camera,
//       ResolutionPreset.high,
//     );
//     _controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {
//         isLoading = false;
//       });
//       _initializeControllerFuture = _controller.initialize();
//     });
//     print("object");
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadCamera();
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var size = MediaQuery.of(context).size;
//     // final deviceRatio = size.width / size.height;
//     return Scaffold(
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             final mediaSize = MediaQuery.of(context).size;
//             final deviceRatio = mediaSize.width / mediaSize.height;
//             final scale =
//                 1 / (_controller.value.aspectRatio * mediaSize.aspectRatio);
//             final xScale = _controller.value.aspectRatio / deviceRatio;
// // Modify the yScale if you are in Landscape
//             double yScale = 1;
//             return Container(
//               //  margin: EdgeInsets.only(top: 10),
//               child: ClipRect(
//                 clipper: _MediaSizeClipper(mediaSize),
//                 child: Transform.scale(
//                   scale: scale,
//                   alignment: Alignment.topCenter,
//                   child: CameraPreview(_controller),
//                 ),
//               ),
//             );

//             // Stack(
//             //   children: [

//             //     // Container(
//             //     //   child: AspectRatio(
//             //     //     aspectRatio: deviceRatio,
//             //     //     child: Transform(
//             //     //       alignment: Alignment.center,
//             //     //       transform: Matrix4.diagonal3Values(xScale, yScale, 1),
//             //     //       child: CameraPreview(_controller),
//             //     //     ),
//             //     //   ),
//             //     // ),
//             //     // //    CameraPreview(_controller),
//             //     // AppBar(
//             //     //     backgroundColor: Colors.red.shade100.withOpacity(0),
//             //     //     actions: <Widget>[
//             //     //       new IconButton(
//             //     //         icon: new Icon(Icons.photo_library),
//             //     //         tooltip: 'Choose gallery',
//             //     //         onPressed: () => _openGalery(context),
//             //     //       ),
//             //     //       Container(
//             //     //         width: 5,
//             //     //       )
//             //     //     ],
//             //     //     leading: new IconButton(
//             //     //         icon: new Icon(Icons.arrow_back),
//             //     //         onPressed: () {
//             //     //           //Navigator.pushReplacementNamed(context, '/webview');
//             //     //           // Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) =>   WebViewPlugin(
//             //     //           //     title: widget.itemId,
//             //     //           //     url: widget.url
//             //     //           //   )));
//             //     //         })),
//             //   ],
//             // );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blue,
//         child: Icon(
//           Icons.camera_alt,
//           color: Colors.white,
//         ),
//         onPressed: () async {
//           try {
//             await _initializeControllerFuture;
//             name = '22/5/2020' + '.png';
//             final path = join(
//               (await getTemporaryDirectory()).path,
//               name,
//             );
//             await _controller.takePicture();
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(
//             //     builder: (context) => DisplayPictureScreen(
//             //       imagePath: path,
//             //       name: name,
//             //       itemId: widget.itemId,
//             //     ),
//             //   ),
//             // );
//           } catch (e) {
//             print(e);
//           }
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }

//   _openGalery(context) async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         name = '22/5/2020' + '.png';
//       });
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => DisplayPictureScreen(
//       //       imagePath: image.path,
//       //       name: name,
//       //       itemId: widget.itemId,
//       //     ),
//       //   ),
//       // );
//     }
//   }
// }

// class _MediaSizeClipper extends CustomClipper<Rect> {
//   final Size mediaSize;
//   const _MediaSizeClipper(this.mediaSize);
//   @override
//   Rect getClip(Size size) {
//     return Rect.fromLTWH(0, 0, 900, 1200);
//   }

//   @override
//   bool shouldReclip(CustomClipper<Rect> oldClipper) {
//     return true;
//   }
// }
