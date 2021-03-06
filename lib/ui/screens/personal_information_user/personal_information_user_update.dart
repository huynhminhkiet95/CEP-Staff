import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/blocs/personal_information_user/personal_information_user_bloc.dart';
import 'package:qr_code_demo/blocs/personal_information_user/personal_information_user_event.dart';
import 'package:qr_code_demo/blocs/personal_information_user/personal_information_user_state.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/config/formatdate.dart';
import 'package:qr_code_demo/config/locatetype.dart';
import 'package:qr_code_demo/enum/typeInfor.dart';
import 'package:qr_code_demo/globalServer.dart';
import 'package:qr_code_demo/models/personal_information_user/customer_info.dart';
import 'package:qr_code_demo/models/personal_information_user/update_information_user.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/ui/components/CusTextFormField.dart';
import 'package:qr_code_demo/ui/css/style.css.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/ui/components/crop_image.dart';
import 'package:qr_code_demo/utils/always_disabled_focus_node.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PersonalInformationUserUpdate extends StatefulWidget {
  final CustomerInfo customerInfo;

  PersonalInformationUserUpdate({Key key, this.customerInfo}) : super(key: key);

  @override
  _PersonalInformationUserUpdateState createState() =>
      _PersonalInformationUserUpdateState();
}

class _PersonalInformationUserUpdateState
    extends State<PersonalInformationUserUpdate> with TickerProviderStateMixin {
  double screenHeight, screenWidth;
  QRViewController controller;
  Barcode result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  GlobalKey _scaffold = GlobalKey();

  TextEditingController _controllerCustomerCode = new TextEditingController();
  TextEditingController _controllerBranchID = new TextEditingController();
  TextEditingController _controllerLatLng = new TextEditingController();
  TextEditingController _controllerCurrentResidence =
      new TextEditingController();

  TextEditingController _controllerIDNo = new TextEditingController();
  TextEditingController _controllerIDNoOld = new TextEditingController();
  TextEditingController _controllerFullName = new TextEditingController();
  TextEditingController _controllerDOB = new TextEditingController();
  TextEditingController _controllerSex = new TextEditingController();
  TextEditingController _controllerNativePlace = new TextEditingController();

  TextEditingController _controllerDateOfIssue = new TextEditingController();
  // Animation<double> _animation;
  // AnimationController _controller;
  final cropKey = GlobalKey<CropState>();
  var _formKeyInfoCustomer = GlobalKey<FormState>();
  List<File> listFileImage = List<File>.generate(2, (int index) => null);
  List<File> listFileImageLast = List<File>.generate(2, (int index) => null);
  String fontImageUrl;
  String backImageUrl;
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
    services = Services.of(context);
    personalInformationUserBloc = new PersonalInformationUserBloc(
        services.sharePreferenceService, services.commonService);

    super.initState();
    _controllerCustomerCode.text = widget.customerInfo?.customerCode ?? '';
    _controllerBranchID.text = widget.customerInfo?.branchId.toString() ?? '';
    _controllerLatLng.text = widget.customerInfo?.coordinates ?? '';
    _controllerCurrentResidence.text =
        widget.customerInfo?.currentResidence ?? '';
    _controllerIDNo.text = widget.customerInfo?.newId ?? '';
    _controllerIDNoOld.text = widget.customerInfo?.oldId ?? '';
    _controllerFullName.text = widget.customerInfo?.fullName ?? '';
    _controllerDOB.text = widget.customerInfo?.dob ?? '';
    _controllerSex.text = widget.customerInfo?.sex ?? '';
    _controllerNativePlace.text = widget.customerInfo?.nativePlace ?? '';
    _controllerDateOfIssue.text = FormatDateConstants.convertDateTimeToDDMMYYYY(
        widget.customerInfo.dateOfIssue);
    fontImageUrl = globalServer.getServerAddress +
        widget.customerInfo.frontImage
            .replaceAll(r'\', r'/')
            .substring(24, widget.customerInfo.frontImage.length);
    backImageUrl = globalServer.getServerAddress +
        widget.customerInfo.backImage
            .replaceAll(r'\', r'/')
            .substring(24, widget.customerInfo.backImage.length);
    getCurrentResidenceFromCoordinates(widget.customerInfo.coordinates);
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
          loaithongtinId: TypeInfo.dob.index,
          giatriCu: "",
          giatriMoi: _controllerDOB.text));

      listChangeInfo.add(new TblThongtinthaydoi(
          loaithongtinId: TypeInfo.sex.index,
          giatriCu: "",
          giatriMoi: _controllerSex.text));

      List<UrlHinhanh> listCitizenIdentificationImage = new List<UrlHinhanh>();
      listCitizenIdentificationImage.add(new UrlHinhanh(
          loaithongtinId: TypeInfo.avatar.index,
          ismattruoc: true,
          urlHinhanh: widget.customerInfo.frontImage
          //base64Encode(listFileImageLast[0].readAsBytesSync())
          ));
      listCitizenIdentificationImage.add(new UrlHinhanh(
          loaithongtinId: TypeInfo.avatar.index,
          ismattruoc: false,
          urlHinhanh: widget.customerInfo.backImage
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
      model.locateType = LocateType.surveyCoordinates;
      model.latiLongTude = _controllerLatLng.text;
      personalInformationUserBloc.emitEvent(UpdatePersonalInformationUserEvent(
          context, model, listFileImageLast));
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
          centerTitle: true,
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
            widget.customerInfo.customerCode +
                ' - ' +
                widget.customerInfo.fullName +
                ' - CN' +
                widget.customerInfo.branchId.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: BlocEventStateBuilder<PersonalInformationUserState>(
            bloc: personalInformationUserBloc,
            builder:
                (BuildContext context, PersonalInformationUserState state) {
              return ModalProgressHUD(
                progressIndicator: RefreshProgressIndicator(
                  backgroundColor: Color(0xff223f92),
                ),
                color: Colors.grey,
                inAsyncCall: state?.isLoading ?? false,
                //inAsyncCall: false,
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
                              "Th??ng Tin Kh??ch H??ng",
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
                                          Text(
                                            "Th??ng Tin Chung",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                letterSpacing: 1,
                                                color: ColorConstants
                                                    .cepColorBackground),
                                          ),
                                          divider10,
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: CusTextFormField(
                                                      focusNode:
                                                          new AlwaysDisabledFocusNode(),
                                                      controller:
                                                          _controllerCustomerCode,
                                                      textInputType:
                                                          TextInputType.text,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Vui l??ng nh???p tr?????ng n??y!';
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
                                                      focusNode:
                                                          new AlwaysDisabledFocusNode(),
                                                      controller:
                                                          _controllerBranchID,
                                                      textInputType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Vui l??ng nh???p tr?????ng n??y!';
                                                        } else {
                                                          if (value
                                                              .contains(',')) {
                                                            return '?????nh d???ng s??? kh??ng h???p l???!';
                                                          }
                                                          if (double.parse(
                                                                      value) %
                                                                  1 !=
                                                              0) {
                                                            return 'Chi nh??nh kh??ng h???p l???!';
                                                          }
                                                        }
                                                        return null;
                                                      },
                                                      title: allTranslations
                                                          .text("BranchID"))),
                                            ],
                                          ),
                                          divider10,
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                  child: CusTextFormField(
                                                      controller:
                                                          _controllerLatLng,
                                                      textInputType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Vui l??ng nh???p tr?????ng n??y!';
                                                        }
                                                        return null;
                                                      },
                                                      title:
                                                          allTranslations.text(
                                                              "Coordinates"))),
                                              InkWell(
                                                onTap: () => getCurrentLatLng(),
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  color: Colors.green,
                                                  child: Icon(
                                                    Icons.gps_fixed,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  var coordinatesArr =
                                                      _controllerLatLng.text
                                                          .split(',');
                                                  LatLng coordinates;
                                                  if (coordinatesArr.length ==
                                                      2) {
                                                    coordinates = new LatLng(
                                                        double.parse(
                                                            coordinatesArr
                                                                .first),
                                                        double.parse(
                                                            coordinatesArr
                                                                .last));
                                                  }

                                                  dynamic result =
                                                      await Navigator.pushNamed(
                                                          _scaffold
                                                              .currentContext,
                                                          'googlemaps',
                                                          arguments: {
                                                        'coordinates':
                                                            coordinates,
                                                      });
                                                  print("object");
                                                  if (result != null) {
                                                    LatLng coordinates =
                                                        result['address']
                                                                ['coordinates']
                                                            as LatLng;
                                                    _controllerLatLng.text =
                                                        coordinates.latitude
                                                                .toString() +
                                                            ',' +
                                                            coordinates
                                                                .longitude
                                                                .toString();

                                                    _controllerCurrentResidence
                                                        .text = result[
                                                            'address']
                                                        ['descriptionAddress'];
                                                  }
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  color: Colors.green,
                                                  child: Icon(
                                                    Icons.map_sharp,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          divider10,
                                          CusTextFormField(
                                              focusNode:
                                                  new AlwaysDisabledFocusNode(),
                                              controller:
                                                  _controllerCurrentResidence,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Vui l??ng nh???p tr?????ng n??y!';
                                                }
                                                return null;
                                              },
                                              title: allTranslations
                                                  .text("CurrentResidence")),
                                          divider20,
                                          Text(
                                            "Th??ng Tin C?? Nh??n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                letterSpacing: 1,
                                                color: ColorConstants
                                                    .cepColorBackground),
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
                                                          return 'Vui l??ng nh???p tr?????ng n??y!';
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
                                                          return 'Vui l??ng nh???p tr?????ng n??y!';
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
                                                  return 'Vui l??ng nh???p tr?????ng n??y!';
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
                                                        return 'Vui l??ng nh???p tr?????ng n??y!';
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
                                                    controller: _controllerDOB,
                                                    focusNode:
                                                        new AlwaysDisabledFocusNode(),
                                                    onTab: () {
                                                      //print("object");
                                                    },
                                                    textInputType:
                                                        TextInputType.datetime,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Vui l??ng nh???p tr?????ng n??y!';
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
                                                  return 'Vui l??ng nh???p tr?????ng n??y!';
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
                                                  return 'Vui l??ng nh???p tr?????ng n??y!';
                                                }
                                                return null;
                                              },
                                              title: allTranslations
                                                  .text("DateOfIssue")),
                                          divider10,
                                          Text(
                                            "H??nh ???nh ????nh k??m",
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
                                                      "M???t tr?????c",
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
                                                          child: listFileImageLast[
                                                                      0] !=
                                                                  null
                                                              ? Container(
                                                                  width: 95,
                                                                  height: 55,
                                                                  decoration:
                                                                      new BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(
                                                                              5.0)),
                                                                          //color: Colors.redAccent,
                                                                          shape: BoxShape
                                                                              .rectangle,
                                                                          image: new DecorationImage(
                                                                              fit: BoxFit.fill,
                                                                              image: FileImage(listFileImageLast[0]))),
                                                                )
                                                              : fontImageUrl ==
                                                                      ''
                                                                  ? Container(
                                                                      width: 95,
                                                                      height:
                                                                          55,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.blueGrey[
                                                                              100],
                                                                          borderRadius: BorderRadius.circular(
                                                                              5.0),
                                                                          border: Border.all(
                                                                              color: isValidAttachFileFrontFace != false ? Colors.grey[400] : Colors.red[300],
                                                                              width: 1.3)),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                                child: Container(
                                                                              height: 40,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                              child: Center(
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
                                                                              width: 5,
                                                                            ),
                                                                            Expanded(
                                                                                child: Container(
                                                                              height: 40,
                                                                              child: Column(
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
                                                                    )
                                                                  : Container(
                                                                      width: 95,
                                                                      height:
                                                                          55,
                                                                      decoration: new BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                                          //color: Colors.redAccent,
                                                                          shape: BoxShape.rectangle,
                                                                          image: new DecorationImage(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            image:
                                                                                NetworkImage(
                                                                              fontImageUrl,
                                                                            ),
                                                                          )),
                                                                    )),
                                                    ),
                                                    isValidAttachFileFrontFace !=
                                                            false
                                                        ? Container()
                                                        : Text(
                                                            "Vui l??ng nh???p tr?????ng n??y!",
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
                                                      "M???t sau",
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
                                                                : backImageUrl ==
                                                                        ''
                                                                    ? Container(
                                                                        width:
                                                                            95,
                                                                        height:
                                                                            55,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.blueGrey[100],
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                            border: Border.all(color: isValidAttachFileFrontFace != false ? Colors.grey[400] : Colors.red[300], width: 1.3)),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                  child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                                                width: 5,
                                                                              ),
                                                                              Expanded(
                                                                                  child: Container(
                                                                                height: 40,
                                                                                child: Column(
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
                                                                      )
                                                                    : Container(
                                                                        width:
                                                                            95,
                                                                        height:
                                                                            55,
                                                                        decoration: new BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                                            //color: Colors.redAccent,
                                                                            shape: BoxShape.rectangle,
                                                                            image: new DecorationImage(
                                                                              fit: BoxFit.fill,
                                                                              image: NetworkImage(
                                                                                backImageUrl,
                                                                              ),
                                                                            )),
                                                                      ),
                                                      ),
                                                    ),
                                                    isValidAttachFileBackFace !=
                                                            false
                                                        ? Container()
                                                        : Text(
                                                            "Vui l??ng nh???p tr?????ng n??y!",
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
                                        // Expanded(
                                        //   child: InkWell(
                                        //     onTap: () => clearData(),
                                        //     child: Center(
                                        //         child: Text("X??a",
                                        //             style: TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontSize: 14,
                                        //                 fontWeight:
                                        //                     FontWeight.bold))),
                                        //   ),
                                        // ),
                                        // VerticalDivider(
                                        //   width: 5,
                                        //   thickness: 5,
                                        //   color: Colors.white,
                                        // ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () => onSubmit(context),
                                            child: Center(
                                                child: Text("C???p Nh???t",
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
                          "X??a",
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
                          "Ch???nh s???a l???i",
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
                        "Ch???n ???nh t??? th?? vi???n",
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
    // if (listFileImageLast[0] == null) {
    //   isValid = false;
    //   isValidAttachFileFrontFace = false;
    // }
    // if (listFileImageLast[1] == null) {
    //   isValid = false;
    //   isValidAttachFileBackFace = false;
    // }
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
    _controllerDOB.text = "";
    _controllerNativePlace.text = "";
    _controllerDateOfIssue.text = "";
    listFileImageLast = List<File>.generate(2, (int index) => null);
  }

  getCurrentLatLng() async {
    var location = new Location();
    LocationData currentLocation = await location.getLocation();
    _controllerLatLng.text = currentLocation.latitude.toString() +
        ',' +
        currentLocation.longitude.toString();

    var coordinates =
        new Coordinates(currentLocation.latitude, currentLocation.longitude);

    var addressDescription =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    _controllerCurrentResidence.text = addressDescription.first.addressLine;
  }

  getCurrentResidenceFromCoordinates(String coordinatesStr) async {
    var coordinates = coordinatesStr.split(',');
    var coordinatesModel = new Coordinates(
        double.parse(coordinates[0]), double.parse(coordinates[1]));
    var addressDescription =
        await Geocoder.local.findAddressesFromCoordinates(coordinatesModel);
    _controllerCurrentResidence.text = addressDescription.first.addressLine;
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
