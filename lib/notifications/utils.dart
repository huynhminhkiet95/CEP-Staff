import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<String> saveImage(BuildContext context, Image image) {
  final completer = Completer<String>();

  image.image.resolve(ImageConfiguration()).addListener(
   ImageStreamListener((ImageInfo imageInfo, _) async {
    final byteData =
        await imageInfo.image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData.buffer.asUint8List();

    final fileName = pngBytes.hashCode;
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(pngBytes);

    completer.complete(filePath);
  }));

  // image.image.resolve(ImageConfiguration()).addListener(
  //       ImageStreamListener((ImageInfo image, bool synchronousCall) {
  //     if (mounted)
  //       setState(() => this._imageDownloadState = ImageDownloadState.Done);
  //   }));


  return completer.future;
}
// Future<String> saveImage(BuildContext context, Image image) {
//   final completer = Completer<String>();

//   image.image
//       .resolve(new ImageConfiguration())
//       .addListener(ImageStreamListener((ImageInfo imageInfo, bool _) async {
//     final byteData =
//         await imageInfo.image.toByteData(format: ImageByteFormat.png);
//     final pngBytes = byteData.buffer.asUint8List();

//     final fileName = pngBytes.hashCode;
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/$fileName';
//     final file = File(filePath);
//     await file.writeAsBytes(pngBytes);
//     completer.complete(filePath);
//   }));

//   return completer.future;
// }
