import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mlkit/mlkit.dart';
import 'dart:async';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScannerScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  List<VisionBarcode> _currentBarcodeLabels = <VisionBarcode>[];
  FirebaseVisionBarcodeDetector barcodeDetector =
      FirebaseVisionBarcodeDetector.instance;
  StreamController<bool> _isLoading = StreamController<bool>();
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void dispose() {
    _isLoading.close();
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  int dialogCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StreamBuilder<bool>(
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
                    children: <Widget>[
                      Expanded(child: _buildQrView(context)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    margin: EdgeInsets.only(top: 70),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.keyboard_arrow_left,
                                color: Colors.white),
                          ),
                          Text('Back',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.grey[100].withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // result != null
                          //     ? Text(
                          //         'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                          //     : Text('Scan a code'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                  future: controller?.getFlashStatus(),
                                  builder: (context, snapshot) {
                                    Widget widget;
                                    if (snapshot.data != null) {
                                      if (snapshot.data == true) {
                                        widget = Expanded(
                                          child: InkWell(
                                              onTap: () async {
                                                await controller?.toggleFlash();
                                                setState(() {});
                                              },
                                              child: Icon(Icons.flash_on,
                                                  color: Colors.white)),
                                        );
                                      } else {
                                        widget = Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              try {
                                                await controller?.toggleFlash();
                                              } catch (e) {
                                                final snackBar = new SnackBar(
                                                    content: new Text(
                                                        "Xin l???i ! Thi???t b??? c???a b???n hi???n kh??ng c?? flash."),
                                                    backgroundColor:
                                                        Colors.grey);
                                                _scaffoldKey.currentState
                                                    .showSnackBar(snackBar);
                                              }

                                              setState(() {});
                                            },
                                            child: Icon(Icons.flash_off,
                                                color: Colors.white),
                                          ),
                                        );
                                      }
                                    } else {
                                      widget = Container();
                                    }
                                    return widget;
                                  }),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.all(8),
                                    child: InkWell(
                                        onTap: () async {
                                          _stopCamera();
                                          final file =
                                              await ImagePicker.pickImage(
                                                  source: ImageSource.gallery);
                                          if (file == null) {
                                            _resumeCamera();
                                          } else {
                                            _isLoading.sink.add(true);
                                            var currentLabels =
                                                await barcodeDetector
                                                    .detectFromPath(file.path);

                                            _currentBarcodeLabels =
                                                currentLabels;
                                            _isLoading.sink.add(false);
                                            if (_currentBarcodeLabels.length >
                                                0) {
                                              showPopupResult(
                                                  _currentBarcodeLabels
                                                      .first.rawValue);
                                            } else {
                                              final snackBar = new SnackBar(
                                                  content: new Text(
                                                      "Xin l???i ! Kh??ng t??m th???y m?? QR."),
                                                  backgroundColor:
                                                      Colors.black);
                                              _scaffoldKey.currentState
                                                  .showSnackBar(snackBar);

                                              _resumeCamera();
                                            }
                                          }
                                        },
                                        child: Icon(Icons.image,
                                            color: Colors.white))),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () async {
                                      await controller?.flipCamera();
                                      setState(() {});
                                    },
                                    child: FutureBuilder(
                                      future: controller?.getCameraInfo(),
                                      builder: (context, snapshot) {
                                        if (snapshot.data != null) {
                                          return Icon(
                                              Icons.flip_camera_ios_outlined,
                                              color: Colors.white);
                                        } else {
                                          return Text('loading');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 180.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      cameraFacing: CameraFacing.back,
      overlay: QrScannerOverlayShape(
          cutOutBottomOffset: 0,
          borderColor: Colors.red,
          borderRadius: 5,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      _stopCamera();
      result = scanData;
      showPopupResult(result.code);
    });
  }

  showPopupResult(String barcode) {
    bool isCheck = _checkCitizenIdentificationCard(barcode);
    if (isCheck) {
      if (dialogCount == 0) {
        dialogCount++;
        print("dialogCount: " + dialogCount.toString());
        showGeneralDialog(
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              Size size = MediaQuery.of(context).size;
              double screenWidth = size.width;
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    insetPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    // (horizontal:10 = left:10, right:10)(vertical:10 = top:10, bottom:10)
                    contentPadding: EdgeInsets.zero,
                    scrollable: true,
                    backgroundColor: Colors.grey[200],
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    titlePadding: EdgeInsets.only(left: 15, right: 10, top: 10),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: screenWidth * 0.8,
                          child: Text(
                            "N???i dung m?? QR: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            _resumeCamera();
                            dialogCount--;
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey)),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    content: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 50),
                      width: 150,
                      child: Text(barcode),
                    ),
                    actions: [
                      new FlatButton(
                        padding: const EdgeInsets.only(top: 8.0),
                        textColor: Colors.grey,
                        onPressed: () {
                          Navigator.of(context).pop();
                          _resumeCamera();
                          dialogCount--;
                        },
                        child: new Text(
                          "????ng",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      new FlatButton(
                        padding: const EdgeInsets.only(top: 8.0),
                        textColor: Colors.pink[500],
                        onPressed: () {
                          Navigator.of(context).pop();
                          _sendDataToParent(barcode);
                        },
                        child: new Text(
                          "Sao ch??p",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 200),
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {});
      }
    } else {
      showGeneralDialog(
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            Size size = MediaQuery.of(context).size;
            double screenWidth = size.width;
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  insetPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  // (horizontal:10 = left:10, right:10)(vertical:10 = top:10, bottom:10)
                  contentPadding: EdgeInsets.zero,
                  scrollable: true,
                  backgroundColor: Colors.grey[200],
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  titlePadding: EdgeInsets.only(left: 15, right: 10, top: 10),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenWidth * 0.8,
                        child: Text(
                          "M?? QR n??y kh??ng ????ng ?????nh d???ng. Vui l??ng th??? l???i !",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          _resumeCamera();
                          dialogCount--;
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),

                  actions: [
                    new FlatButton(
                      padding: const EdgeInsets.only(top: 8.0),
                      textColor: Colors.pink[500],
                      onPressed: () {
                        Navigator.of(context).pop();
                        _resumeCamera();
                      },
                      child: new Text(
                        "Th??? l???i",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {});
    }
  }

  bool _checkCitizenIdentificationCard(String code) {
    var arr = code.split('|');
    bool isCard = true;
    if (arr.length < 7) {
      isCard = false;
    }
    return isCard;
  }

  _sendDataToParent(String barcode) {
    Navigator.of(context).pop(barcode);
  }

  _stopCamera() async {
    await controller?.pauseCamera();
  }

  _resumeCamera() async {
    await controller?.resumeCamera();
  }
}
