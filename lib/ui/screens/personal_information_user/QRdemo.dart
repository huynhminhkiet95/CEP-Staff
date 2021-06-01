import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/ui/components/CustomDialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCodeScreen> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(child: _buildQrView(context)),
            ],
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
                                                "Xin lỗi ! Thiết bị của bạn hiện không có flash."),
                                            backgroundColor: Colors.grey);
                                        Scaffold.of(context)
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
                            child: Icon(Icons.image, color: Colors.white)),
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
                                  return Icon(Icons.flip_camera_ios_outlined,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //       margin: EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //         onPressed: () async {
                  //           await controller?.pauseCamera();
                  //         },
                  //         child: Text('pause', style: TextStyle(fontSize: 20)),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //         onPressed: () async {
                  //           await controller?.resumeCamera();
                  //         },
                  //         child: Text('resume', style: TextStyle(fontSize: 20)),
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          )
        ],
      ),
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
      bool isCheck = _checkCitizenIdentificationCard(result.code);
      if (isCheck) {
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
                            "Nội dung mã QR: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
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
                      child: Text(result.code),
                    ),
                    actions: [
                      new FlatButton(
                        padding: const EdgeInsets.only(top: 8.0),
                        textColor: Colors.grey,
                        onPressed: () {
                          Navigator.of(context).pop();
                          _resumeCamera();
                        },
                        child: new Text(
                          "Đóng",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      new FlatButton(
                        padding: const EdgeInsets.only(top: 8.0),
                        textColor: Colors.pink[500],
                        onPressed: () {
                          Navigator.of(context).pop();
                          _sendDataToParent();
                        },
                        child: new Text(
                          "Sao chép",
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
                            "Mã QR này không đúng định dạng. Vui lòng thử lại !",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
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
                          "Thử lại",
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

      // setState(() {

      // });
    });
  }

  bool _checkCitizenIdentificationCard(String code) {
    var arr = code.split('|');
    bool isCard = true;
    if (arr.length < 7) {
      isCard = false;
    }
    return isCard;
  }

  _sendDataToParent() {
    Navigator.of(context).pop(result.code);
  }

  _stopCamera() async {
    await controller?.pauseCamera();
  }

  _resumeCamera() async {
    await controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
