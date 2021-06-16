import 'dart:convert';
import 'dart:io';

import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/blocs/personal_information_user/personal_information_user_bloc.dart';
import 'package:qr_code_demo/blocs/personal_information_user/personal_information_user_event.dart';
import 'package:qr_code_demo/blocs/personal_information_user/personal_information_user_state.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/config/formatdate.dart';
import 'package:qr_code_demo/enum/typeInfor.dart';
import 'package:qr_code_demo/models/personal_information_user/update_information_user.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/ui/components/CusTextFormField.dart';
import 'package:qr_code_demo/ui/components/ModalProgressHUDCustomize.dart';
import 'package:qr_code_demo/ui/css/style.css.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/ui/components/crop_image.dart';
import 'package:qr_code_demo/utils/always_disabled_focus_node.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class PersonalInformationUser extends StatefulWidget {
  PersonalInformationUser({Key key}) : super(key: key);

  @override
  _PersonalInformationUserState createState() =>
      _PersonalInformationUserState();
}

class _PersonalInformationUserState extends State<PersonalInformationUser>
    with TickerProviderStateMixin {
  double screenHeight, screenWidth;
  QRViewController controller;
  Barcode result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  GlobalKey _scaffold = GlobalKey();

  TextEditingController _controllerCustomerCode = new TextEditingController();
  TextEditingController _controllerBranchID = new TextEditingController();
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
  Animation<double> _animation;
  AnimationController _controller;
  String _path = null;
  final cropKey = GlobalKey<CropState>();
  var _formKeyInfoCustomer = GlobalKey<FormState>();
  List<File> listFileImage = List<File>.generate(2, (int index) => null);
  List<File> listFileImageLast = List<File>.generate(2, (int index) => null);

  final picker = ImagePicker();

  PersonalInformationUserBloc personalInformationUserBloc;
  Services services;

  bool isValidAttachFileFrontFace;
  bool isValidAttachFileBackFace;

  Future _showPhotoLibrary(int index) async {
    listFileImage[index] =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (listFileImage[index] != null) {
        listFileImage[index] = File(listFileImage[index].path);
        listFileImageLast[index] = listFileImage[index];
        showCropImage(_scaffold.currentContext, index);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _showCamera(BuildContext context, int index) async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 25);
    setState(() {
      if (pickedFile != null) {
        listFileImage[index] = File(pickedFile.path);
        listFileImageLast[index] = listFileImage[index];
        showCropImage(_scaffold.currentContext, index);
      } else {
        print('No image selected.');
      }
    });
  }

  removeImage(int index) {
    setState(() {
      listFileImage[index] = null;
      listFileImageLast[index] = null;
    });
  }

  showCropImage(BuildContext context, int index) async {
    final file =
        await Navigator.of(context).push(CropImageScreen(listFileImage[index]));
    setState(() {
      if (file as File != null) {
        listFileImageLast[index] = file as File;
      }
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    services = Services.of(context);
    personalInformationUserBloc = new PersonalInformationUserBloc(
        services.sharePreferenceService, services.commonService);

    super.initState();
  }

  onSubmit(BuildContext context) {
    if (validationForm()) {
      DateTime dateOfIssue = DateFormat('dd/MM/yyyy HH:mm')
          .parse(_controllerDateOfIssue.text.replaceAll('-', '/') + ' 23:59');
      List<TblThongtinthaydoi> listChangeInfo = List<TblThongtinthaydoi>();
      listChangeInfo.add(new TblThongtinthaydoi(
        loaithongtinId: TypeInfo.idNO.index,
        giatriCu: _controllerIDNoOld.text,
        giatriMoi: _controllerIDNo.text,
        ngaycap: FormatDateConstants.convertDateTimeToStringT(dateOfIssue),
      ));
      listChangeInfo.add(new TblThongtinthaydoi(
          loaithongtinId: TypeInfo.addressPermanent.index,
          giatriCu: "",
          giatriMoi: _controllerNativePlace.text));
      listChangeInfo.add(new TblThongtinthaydoi(
          loaithongtinId: TypeInfo.fullName.index,
          giatriCu: "",
          giatriMoi: _controllerFullName.text));

      listChangeInfo.add(new TblThongtinthaydoi(
          loaithongtinId: TypeInfo.bod.index,
          giatriCu: "",
          giatriMoi: _controllerBOD.text));

      listChangeInfo.add(new TblThongtinthaydoi(
          loaithongtinId: TypeInfo.sex.index,
          giatriCu: "",
          giatriMoi: _controllerSex.text));

      List<UrlHinhanh> listCitizenIdentificationImage = new List<UrlHinhanh>();
      listCitizenIdentificationImage.add(new UrlHinhanh(
          loaithongtinId: TypeInfo.avatar.index,
          ismattruoc: true,
          urlHinhanh: ""
          //base64Encode(listFileImageLast[0].readAsBytesSync())
          ));
      listCitizenIdentificationImage.add(new UrlHinhanh(
          loaithongtinId: TypeInfo.avatar.index,
          ismattruoc: false,
          urlHinhanh: ""
          //base64Encode(listFileImageLast[1].readAsBytesSync())
          ));

      UpdateInformationUser model = new UpdateInformationUser();
      model.ngay = FormatDateConstants.convertDateTimeToStringT(DateTime.now());
      model.makhachhang = _controllerCustomerCode.text;
      model.usernameNhanvien = globalUser.getUserInfo.masoql; // ma so ql
      model.ngaycapnhatNhanvien =
          FormatDateConstants.convertDateTimeToStringT(DateTime.now());
      model.chinhanhid = int.parse(_controllerBranchID.text);
      model.checksum = "";
      model.tblThongtinthaydoi = listChangeInfo;
      model.urlHinhanh = listCitizenIdentificationImage;
      personalInformationUserBloc
          .emitEvent(UpdatePersonalInformationUserEvent(context, model));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
        key: _scaffold,
        backgroundColor: Colors.white,
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  var data = await Navigator.pushNamed(context, 'qrcode');
                  if (data is String) {
                    var listInfoCard = data.split('|');
                    _controllerIDNo.text = listInfoCard[0];
                    _controllerIDNoOld.text = listInfoCard[1];
                    _controllerFullName.text = listInfoCard[2];
                    String bod = listInfoCard[3].substring(0, 2) +
                        '/' +
                        listInfoCard[3].substring(2, 4) +
                        '/' +
                        listInfoCard[3].substring(4, 8);
                    _controllerBOD.text = DateFormat('dd-MM-yyyy')
                        .format(DateFormat("dd/MM/yyyy").parse(bod));
                    _controllerSex.text = listInfoCard[4];
                    _controllerNativePlace.text = listInfoCard[5];
                    String dateOfIssue = listInfoCard[6].substring(0, 2) +
                        '/' +
                        listInfoCard[6].substring(2, 4) +
                        '/' +
                        listInfoCard[6].substring(4, 8);
                    _controllerDateOfIssue.text = DateFormat('dd-MM-yyyy')
                        .format(DateFormat("dd/MM/yyyy").parse(dateOfIssue));
                  }
                  print(data);
                }),
          ],
        ),
        body: BlocEventStateBuilder<PersonalInformationUserState>(
            bloc: personalInformationUserBloc,
            builder:
                (BuildContext context, PersonalInformationUserState state) {
              return ModalProgressHUDCustomize(
                inAsyncCall: state?.isLoading ?? false,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
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
                                    offset: Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15.0)),
                            width: screenWidth,
                            height: (screenHeight * 1) - 200,
                            child: Form(
                              key: _formKeyInfoCustomer,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Container(
                                    padding: EdgeInsets.only(
                                        top: 16,
                                        right: 16,
                                        left: 16,
                                        bottom: 16),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 1,
                                            spreadRadius: 0,
                                            offset: Offset(1,
                                                1), // changes position of shadow
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: CusTextFormField(
                                                      controller:
                                                          _controllerCustomerCode,
                                                      textInputType:
                                                          TextInputType.text,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Vui lòng nhập trường này!';
                                                        }
                                                        return null;
                                                      },
                                                      title:
                                                          allTranslations.text(
                                                              "CustomerCode"))),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                  child: CusTextFormField(
                                                      controller:
                                                          _controllerBranchID,
                                                      textInputType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Vui lòng nhập trường này!';
                                                        }
                                                        return null;
                                                      },
                                                      title: allTranslations
                                                          .text("BranchID"))),
                                            ],
                                          ),
                                          divider10,
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: CusTextFormField(
                                                      controller:
                                                          _controllerIDNo,
                                                      textInputType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Vui lòng nhập trường này!';
                                                        }
                                                        return null;
                                                      },
                                                      title: allTranslations
                                                          .text("IDNo"))),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                  child: CusTextFormField(
                                                      controller:
                                                          _controllerIDNoOld,
                                                      textInputType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Vui lòng nhập trường này!';
                                                        }
                                                        return null;
                                                      },
                                                      title: allTranslations
                                                          .text("IDNoOld"))),
                                            ],
                                          ),
                                          divider10,
                                          CusTextFormField(
                                              controller: _controllerFullName,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Vui lòng nhập trường này!';
                                                }
                                                return null;
                                              },
                                              title:
                                                  allTranslations.text("Name")),
                                          divider10,
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CusTextFormField(
                                                    controller: _controllerSex,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Vui lòng nhập trường này!';
                                                      }
                                                      return null;
                                                    },
                                                    title: allTranslations
                                                        .text("Gender")),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: CusTextFormField(
                                                    controller: _controllerBOD,
                                                    focusNode:
                                                        new AlwaysDisabledFocusNode(),
                                                    onTab: () {
                                                      //print("object");
                                                    },
                                                    textInputType:
                                                        TextInputType.datetime,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Vui lòng nhập trường này!';
                                                      }
                                                      return null;
                                                    },
                                                    title: allTranslations
                                                        .text("BOD")),
                                              ),
                                            ],
                                          ),
                                          divider10,
                                          CusTextFormField(
                                              controller:
                                                  _controllerNativePlace,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Vui lòng nhập trường này!';
                                                }
                                                return null;
                                              },
                                              title: allTranslations
                                                  .text("NativePlace")),
                                          divider10,
                                          CusTextFormField(
                                              controller:
                                                  _controllerDateOfIssue,
                                              focusNode:
                                                  new AlwaysDisabledFocusNode(),
                                              onTab: () {
                                                //print("object");
                                              },
                                              textInputType:
                                                  TextInputType.datetime,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Vui lòng nhập trường này!';
                                                }
                                                return null;
                                              },
                                              title: allTranslations
                                                  .text("DateOfIssue")),
                                          divider10,
                                          Text(
                                            "Hình ảnh đính kèm",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Color(0xff9596ab)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: InkWell(
                                                onTap: () {
                                                  _showOptions(context, 0);
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Mặt trước",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.red[600],
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Container(
                                                      height:
                                                          (screenWidth * 0.35) -
                                                              40,
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      // decoration: BoxDecoration(
                                                      //     color: Colors.white,
                                                      //     borderRadius:
                                                      //         BorderRadius
                                                      //             .circular(8.0),
                                                      //     border: Border.all(
                                                      //         color: Colors
                                                      //             .grey[400],
                                                      //         width: 2.0)),
                                                      child: FittedBox(
                                                        fit: BoxFit.fitHeight,
                                                        child:
                                                            listFileImageLast[
                                                                        0] !=
                                                                    null
                                                                ? Container(
                                                                    width: 95,
                                                                    height: 55,
                                                                    decoration: new BoxDecoration(
                                                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                                        //color: Colors.redAccent,
                                                                        shape: BoxShape.rectangle,
                                                                        image: new DecorationImage(fit: BoxFit.fill, image: FileImage(listFileImageLast[0]))),
                                                                  )
                                                                : Container(
                                                                    width: 95,
                                                                    height: 55,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.blueGrey[
                                                                            100],
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5.0),
                                                                        border: Border.all(
                                                                            color: isValidAttachFileFrontFace != false
                                                                                ? Colors.grey[400]
                                                                                : Colors.red[300],
                                                                            width: 1.3)),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child: Container(
                                                                            height:
                                                                                40,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: Container(
                                                                                height: 27,
                                                                                width: 20,
                                                                                child: FittedBox(
                                                                                    fit: BoxFit.cover,
                                                                                    child: Icon(
                                                                                      Icons.person,
                                                                                      color: Colors.blueGrey[200],
                                                                                    )),
                                                                              ),
                                                                            ),
                                                                          )),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Expanded(
                                                                              child: Container(
                                                                            height:
                                                                                40,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Flexible(
                                                                                  flex: 1,
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(color: Colors.blueGrey[200], borderRadius: BorderRadius.circular(8.0), border: Border.all(color: Colors.blueGrey[100], width: 2.0)),
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  flex: 1,
                                                                                  fit: FlexFit.tight,
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(color: Colors.blueGrey[200], borderRadius: BorderRadius.circular(8.0), border: Border.all(color: Colors.blueGrey[100], width: 4.0)),
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  flex: 1,
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(color: Colors.blueGrey[200], borderRadius: BorderRadius.circular(8.0), border: Border.all(color: Colors.blueGrey[100], width: 3.0)),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                      ),
                                                    ),
                                                    isValidAttachFileFrontFace !=
                                                            false
                                                        ? Container()
                                                        : Text(
                                                            "Vui lòng nhập trường này!",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 12),
                                                          )
                                                  ],
                                                ),
                                              )),
                                              Container(
                                                width: 5,
                                                color: Colors.white,
                                              ),
                                              Expanded(
                                                  child: InkWell(
                                                onTap: () {
                                                  _showOptions(context, 1);
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Mặt sau",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.red[600],
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Container(
                                                      height:
                                                          (screenWidth * 0.35) -
                                                              40,
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      // decoration: BoxDecoration(
                                                      //     color: Colors.white,
                                                      //     borderRadius:
                                                      //         BorderRadius
                                                      //             .circular(8.0),
                                                      //     border: Border.all(
                                                      //         color: Colors
                                                      //             .grey[400],
                                                      //         width: 2.0)),
                                                      child: FittedBox(
                                                        fit: BoxFit.fitHeight,
                                                        child:
                                                            listFileImageLast[
                                                                        1] !=
                                                                    null
                                                                ? Container(
                                                                    width: 95,
                                                                    height: 55,
                                                                    decoration: new BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                5.0)),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        image: new DecorationImage(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            image: FileImage(listFileImageLast[1]))),
                                                                  )
                                                                : Container(
                                                                    width: 95,
                                                                    height: 55,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.blueGrey[
                                                                            100],
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5.0),
                                                                        border: Border.all(
                                                                            color: isValidAttachFileFrontFace != false
                                                                                ? Colors.grey[400]
                                                                                : Colors.red[300],
                                                                            width: 1.3)),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Container(
                                                                                height: 20,
                                                                                width: 30,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Container(
                                                                                    height: 27,
                                                                                    width: 20,
                                                                                    child: RotatedBox(
                                                                                      quarterTurns: 1,
                                                                                      child: FittedBox(
                                                                                          fit: BoxFit.cover,
                                                                                          child: Icon(
                                                                                            Icons.fingerprint,
                                                                                            color: Colors.blueGrey[200],
                                                                                          )),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                height: 20,
                                                                                width: 30,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Container(
                                                                                    height: 27,
                                                                                    width: 20,
                                                                                    child: RotatedBox(
                                                                                      quarterTurns: 1,
                                                                                      child: FittedBox(
                                                                                          fit: BoxFit.cover,
                                                                                          child: Icon(
                                                                                            Icons.fingerprint_rounded,
                                                                                            color: Colors.blueGrey[200],
                                                                                          )),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Expanded(
                                                                              child: Container(
                                                                            height:
                                                                                40,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Flexible(
                                                                                  flex: 1,
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(color: Colors.blueGrey[200], borderRadius: BorderRadius.circular(8.0), border: Border.all(color: Colors.blueGrey[100], width: 2.0)),
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  flex: 1,
                                                                                  fit: FlexFit.tight,
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(color: Colors.blueGrey[200], borderRadius: BorderRadius.circular(8.0), border: Border.all(color: Colors.blueGrey[100], width: 4.0)),
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  flex: 1,
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(color: Colors.blueGrey[200], borderRadius: BorderRadius.circular(8.0), border: Border.all(color: Colors.blueGrey[100], width: 3.0)),
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  flex: 1,
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(color: Colors.blueGrey[200], borderRadius: BorderRadius.circular(8.0), border: Border.all(color: Colors.blueGrey[100], width: 3.0)),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                      ),
                                                    ),
                                                    isValidAttachFileBackFace !=
                                                            false
                                                        ? Container()
                                                        : Text(
                                                            "Vui lòng nhập trường này!",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 12),
                                                          )
                                                  ],
                                                ),
                                              )),
                                            ],
                                          )
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
                                          child: InkWell(
                                            onTap: () => clearData(),
                                            child: Center(
                                                child: Text("Xóa",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ),
                                        ),
                                        VerticalDivider(
                                          width: 5,
                                          thickness: 5,
                                          color: Colors.white,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () => onSubmit(context),
                                            child: Center(
                                                child: Text("Cập Nhật",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              height: listFileImageLast[index] != null ? 270 : 170,
              // color: ColorConstants.cepColorBackground,
              decoration: BoxDecoration(
                  color: ColorConstants.cepColorBackground,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(26),
                      topRight: const Radius.circular(26))),
              child: Builder(
                builder: (context) {
                  List<Widget> buildTileImage = List<Widget>();
                  if (listFileImageLast[index] != null) {
                    buildTileImage.add(ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          removeImage(index);
                        },
                        leading: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Xóa",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )));
                    buildTileImage.add(ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          showCropImage(context, index);
                        },
                        leading: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Chỉnh sửa lại",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )));
                  }

                  buildTileImage.add(
                    ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          _showCamera(context, index);
                        },
                        leading: Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Camera",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  );

                  buildTileImage.add(ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        _showPhotoLibrary(index);
                      },
                      leading: Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Chọn ảnh từ thư viện",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )));
                  return Column(
                    children: [
                      Container(
                        //height: 40,
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: buildTileImage),
                    ],
                  );
                },
              ));
        });
  }

  bool validationForm() {
    isValidAttachFileFrontFace = true;
    isValidAttachFileBackFace = true;
    bool isValid;
    isValid = _formKeyInfoCustomer.currentState.validate();
    if (listFileImageLast[0] == null) {
      isValid = false;
      isValidAttachFileFrontFace = false;
    }
    if (listFileImageLast[1] == null) {
      isValid = false;
      isValidAttachFileBackFace = false;
    }
    if (!isValid) {
      setState(() {});
    }
    _formKeyInfoCustomer.currentState.save();
    return isValid;
  }

  clearData() {
    _controllerCustomerCode.text = "";
    _controllerBranchID.text = "";
    _controllerIDNo.text = "";
    _controllerIDNoOld.text = "";
    _controllerFullName.text = "";
    _controllerSex.text = "";
    _controllerBOD.text = "";
    _controllerNativePlace.text = "";
    _controllerDateOfIssue.text = "";
    listFileImageLast = List<File>.generate(2, (int index) => null);
  }

//   Future decode(String file) async {
//   String data = await QrCodeToolsPlugin.decodeFrom(file);
//   setState(() {
//     _data = data;
//   });
// }
}

class ClipPainter1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = new Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, height);
    path.lineTo(size.width, 0);

    /// [Bottom Left corner]
    var thirdControlPoint = Offset(0, height);
    var thirdEndPoint = Offset(width, height);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
