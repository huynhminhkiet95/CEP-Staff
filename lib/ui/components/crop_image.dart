import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart';
import 'package:qr_code_demo/ui/components/ModalProgressHUDCustomize.dart';
import 'package:qr_code_demo/ui/components/loading_progress_indicator.dart';

class CropImageScreen extends ModalRoute<void> {
  final File fileImage;
  CropImageScreen(this.fileImage);
  final cropKey = GlobalKey<CropState>();
  StreamController<double> _value = StreamController<double>();
  double _value1 = 1;
  StreamController<bool> _isLoading = StreamController<bool>();
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  void dispose() {
    _value.close();
    _isLoading.close();
    super.dispose();
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.canvas,
      color: Colors.black,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _isLoading.stream,
        builder: (context, snapshot) {
          return ModalProgressHUD(
            progressIndicator: RefreshProgressIndicator(
              backgroundColor: Color(0xff223f92),
            ),
            color: Colors.grey,
            inAsyncCall: snapshot.data ?? false,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                          color: Colors.black.withOpacity(0.1),
                          child: Center(
                              child: Crop.file(
                            fileImage,
                            key: cropKey,
                            alwaysShowGrid: true,
                            scale: _value1 ?? 1,
                          ))),
                    ),
                    Container(
                        height: 150,
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.blueGrey[700],
                                inactiveTrackColor:
                                    Colors.blueGrey.withOpacity(0.2),
                                trackShape: RectangularSliderTrackShape(),
                                trackHeight: 4.0,
                                thumbColor: Colors.blueGrey,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 10.0,
                                    elevation: 2,
                                    pressedElevation: 10),
                                overlayColor: Colors.blueGrey.withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 30.0),
                              ),
                              child: Slider(
                                activeColor: Colors.grey,
                                value: _value1,
                                min: 1,
                                max: 3,
                                divisions: 20,
                                label: '$_value1',
                                onChanged: (value) {
                                  _value1 = value;
                                  changedExternalState();
                                },
                              ),
                            ),
                            Divider(
                              height: 10,
                            ),
                            Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.black38,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.black38)),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Chỉnh sửa ảnh",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _cropImage(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.black38,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.black38)),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 10,
                            ),
                          ],
                        ))
                  ],
                )

                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Container(
                //     padding: const EdgeInsets.only(bottom: 20.0),
                //     height: 50,
                //     width: 150,
                //     alignment: AlignmentDirectional.bottomCenter,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: <Widget>[
                //         TextButton(
                //           child: Text(
                //             'Crop Image',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .button
                //                 .copyWith(color: Colors.white),
                //           ),
                //           onPressed: () => _cropImage(context),
                //         ),
                //         //_buildOpenImage(),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          );
        });
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  Future<void> _cropImage(BuildContext context) async {
    _isLoading.sink.add(true);
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: fileImage,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();
    Timer(Duration(seconds: 1), () {
      _isLoading.sink.add(false);
      Navigator.of(context).pop(file);
    });
  }
}
