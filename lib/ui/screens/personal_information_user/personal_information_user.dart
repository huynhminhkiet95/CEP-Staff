import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/ui/components/CusTextFormField.dart';
import 'package:qr_code_demo/ui/css/style.css.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:qr_code_scanner/qr_code_scanner.dart';

class PersonalInformationUser extends StatefulWidget {
  PersonalInformationUser({Key key}) : super(key: key);

  @override
  _PersonalInformationUserState createState() =>
      _PersonalInformationUserState();
}

class _PersonalInformationUserState extends State<PersonalInformationUser> {
  double screenHeight, screenWidth;
  QRViewController controller;
  Barcode result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TextEditingController _controllerIDNo = new TextEditingController();
  TextEditingController _controllerIDNoOld = new TextEditingController();
  TextEditingController _controllerFullName = new TextEditingController();
  TextEditingController _controllerBOD = new TextEditingController();
  TextEditingController _controllerNationality = new TextEditingController();
  TextEditingController _controllerSex = new TextEditingController();
  TextEditingController _controllerNativePlace = new TextEditingController();
  TextEditingController _controllerPlaceOfPermanent =
      new TextEditingController();
  TextEditingController _controllerDateOfIssue = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    Widget qrCodeChild = _buildQrView(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: ColorConstants.cepColorBackground,
        elevation: 20,
        title: Text(
          "Quét QR Code",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () async {
                // barcodeScanner();
                var data =
                    await Navigator.pushNamed(context, 'qrcode', arguments: {
                  'child': qrCodeChild,
                });
                if (data is String) {
                  var listInfoCard = data.split('|');
                  _controllerIDNo.text = listInfoCard[0];
                  _controllerIDNoOld.text = listInfoCard[1];
                  _controllerFullName.text = listInfoCard[2];
                  _controllerBOD.text = listInfoCard[3];
                  _controllerSex.text = listInfoCard[4];
                  _controllerNativePlace.text = listInfoCard[5];
                  _controllerDateOfIssue.text = listInfoCard[6];
                }
                print(data);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                height: (screenHeight * 1 / 3) - 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.deepPurple[900],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Thông Tin Khách Hàng",
                    //  textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        wordSpacing: 5),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 0.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 1,
                          spreadRadius: 0,
                          offset: Offset(1, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0)),
                  width: screenWidth,
                  height: (screenHeight * 1) - 200,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 1,
                                spreadRadius: 0,
                                offset:
                                    Offset(1, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                      child: CusTextFormField(
                                          controller: _controllerIDNo,
                                          title: allTranslations.text("IDNo"))),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: CusTextFormField(
                                          controller: _controllerIDNoOld,
                                          title:
                                              allTranslations.text("IDNoOld"))),
                                ],
                              ),
                              divider10,
                              CusTextFormField(
                                  controller: _controllerFullName,
                                  title: allTranslations.text("Name")),
                              divider10,
                              Row(
                                children: [
                                  Expanded(
                                    child: CusTextFormField(
                                        controller: _controllerSex,
                                        title: allTranslations.text("Gender")),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: CusTextFormField(
                                        controller: _controllerBOD,
                                        title: allTranslations.text("BOD")),
                                  ),
                                ],
                              ),
                              divider10,
                              CusTextFormField(
                                  controller: _controllerNativePlace,
                                  title: allTranslations.text("NativePlace")),
                              divider10,
                              // CusTextFormField(
                              //     title:
                              //         allTranslations.text("PlaceOfPermanent")),
                              // divider10,
                              CusTextFormField(
                                  controller: _controllerDateOfIssue,
                                  title: allTranslations.text("DateOfIssue")),
                            ],
                          ),
                        ),
                      )),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            )),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                  child: Text("Chỉnh Sửa",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold))),
                            ),
                            VerticalDivider(
                              width: 5,
                              thickness: 5,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Center(
                                  child: Text("Cập Nhật",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  Future barcodeScanner() async {
    String barcode = await BarcodeScanner.scan();
    print(barcode);
  }
}
