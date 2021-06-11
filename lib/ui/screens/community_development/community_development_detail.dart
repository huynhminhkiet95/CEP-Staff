import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/blocs/community_development/community_development_bloc.dart';
import 'package:qr_code_demo/blocs/community_development/community_development_event.dart';
import 'package:qr_code_demo/blocs/community_development/community_development_state.dart';
import 'package:qr_code_demo/blocs/survey/survey_bloc.dart';
import 'package:qr_code_demo/config/CustomIcons/my_flutter_app_icons.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/config/moneyformat.dart';
import 'package:qr_code_demo/models/common/metadata_checkbox.dart';
import 'package:qr_code_demo/models/download_data/comboboxmodel.dart';
import 'package:qr_code_demo/resources/CurrencyInputFormatter.dart';
import 'package:qr_code_demo/services/helper.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/ui/components/CardWithMultipleCheckbox.dart';
import 'package:qr_code_demo/ui/components/CustomDialog.dart';
import 'package:qr_code_demo/ui/components/animated_flip_counter.dart';
import 'package:qr_code_demo/ui/components/dropdown.dart';
import 'package:qr_code_demo/ui/css/style.css.dart';
import 'package:qr_code_demo/ui/screens/survey/style.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/models/community_development/comunity_development.dart';
import 'package:qr_code_demo/config/formatdate.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;

import 'community_development.style.dart';

class CommunityDevelopmentDetail extends StatefulWidget {
  final KhachHang khachHang;
  final List<ComboboxModel> listCombobox;
  CommunityDevelopmentDetail({Key key, this.khachHang, this.listCombobox})
      : super(key: key);

  @override
  _CommunityDevelopmentDetailState createState() =>
      _CommunityDevelopmentDetailState();
}

class _CommunityDevelopmentDetailState extends State<CommunityDevelopmentDetail>
    with TickerProviderStateMixin {
  double screenWidth, screenHeight;
  bool _showBackToTopButton = false;

  ScrollController _scrollController;
  AnimationController _controllerFadeTransitionScholarship;
  Animation<double> _animationFadeTransitionScholarship;

  AnimationController _controllerFadeTransitionGiftTET;
  Animation<double> _animationFadeTransitionGiftTET;

  AnimationController _controllerFadeTransitionHomeCEP;
  Animation<double> _animationFadeTransitionHomeCEP;

  AnimationController _controllerFadeTransitionCareerDevelopment;
  Animation<double> _animationFadeTransitionCareerDevelopment;

  AnimationController _controllerFadeTransitionInsurance;
  Animation<double> _animationFadeTransitionInsurance;

  int selectedIndexIsOfficerInFamily;
  int selectedIndexCareerModel;

  AnimationController _controllerRotateIconScholarship;
  AnimationController _controllerRotateIconGiftTET;
  AnimationController _controllerRotateIconHomeCEP;
  AnimationController _controllerRotateIconCareerDevelopment;
  AnimationController _controllerRotateIconInsurance;

  TabController _tabController;
  bool isCollapseScholarship = false;
  bool isCollapseGiftTET = false;
  bool isCollapseHomeCEP = false;
  bool isCollapseCareerDevelopment = false;
  bool isCollapseInsurance = false;

  bool isShowContainerScholarshipAndGift = false;
  //region Propertu
  TextEditingController _controllerCareerSpecific =
      new TextEditingController(text: "");
  TextEditingController _controllerFamilysMonthlyIncome =
      new TextEditingController(text: "");

  TextEditingController _controllerFullNameForScholarship =
      new TextEditingController(text: "");

  TextEditingController _controllerSchoolName =
      new TextEditingController(text: "");
  TextEditingController _controllerClassName =
      new TextEditingController(text: "");
  TextEditingController _controllerFamilyCircumstances =
      new TextEditingController(text: "");
  TextEditingController _controllerSpecificPurpose =
      new TextEditingController(text: "");
  TextEditingController _controllerScholarshipValue =
      new TextEditingController(text: "");

  TextEditingController _controllerAmountProposeCEPSupport =
      new TextEditingController(text: "");
  TextEditingController _controllerAmountFamilySupport =
      new TextEditingController(text: "");
  TextEditingController _controllerAmountSaving =
      new TextEditingController(text: "");
  TextEditingController _controllerAmountLoan =
      new TextEditingController(text: "");
  TextEditingController _controllerFamilyCircumstancesNote =
      new TextEditingController(text: "");
  TextEditingController _controllerFullNameOfRelative =
      new TextEditingController(text: "");
  TextEditingController _controllerFamilyCircumstancesForDevelopOccupation =
      new TextEditingController(text: "");
  TextEditingController _controllerInsuranceFees =
      new TextEditingController(text: "");
  TextEditingController _controllerFullNameOfRelativeForInsurance =
      new TextEditingController(text: "");
  int totalAmount = 0;

  DateTime selectedTimetoUseLoanDate;
  List<DropdownMenuItem<String>> _occupationOfCustomerModelDropdownList;
  List<DropdownMenuItem<String>> _birthOfYearModelDropdownList;
  List<DropdownMenuItem<String>> _relationsWithCustomersModelDropdownList;
  List<DropdownMenuItem<String>> _capacityModelDropdownList;
  List<DropdownMenuItem<String>> _typeCustomerModelDropdownList;
  List<DropdownMenuItem<String>> _depenRatioModelDropdownList;
  List<DropdownMenuItem<String>> _incomeModelDropdownList;
  List<DropdownMenuItem<String>> _assetsModelDropdownList;
  List<DropdownMenuItem<String>> _homeOwnershipModelDropdownList;
  List<DropdownMenuItem<String>> _customerBuildSuggestionsModelDropdownList;
  List<DropdownMenuItem<String>>
      _relationsWithCustomersJobDevelopModelDropdownList;
  List<DropdownMenuItem<String>>
      _conditionToHaveInsuranceServiceModelDropdownList;
  List<DropdownMenuItem<String>> _customerStatusHealthModelDropdownList;
  List<DropdownMenuItem<String>>
      _relationsWithCustomersForInsuranceModelDropdownList;
  List<DropdownMenuItem<String>> _birthOfYearInsuranceModelDropdownList;
  TextStyle textStyleTextFieldCEP =
      TextStyle(color: ColorConstants.cepColorBackground, fontSize: 14);

  String _occupationOfCustomerValue;
  String _birthOfYearValue;
  String _relationsWithCustomersValue;
  String _capacityValue;
  String _typeCustomerValue;
  String _depenRatioCustomerValue;
  String _incomeValue;
  String _assetsValue;
  String _homeOwnershipValue;
  String _customerBuildSuggestionsValue;
  String _relationsWithCustomersJobDevelop;
  String _conditionToHaveInsuranceServiceValue;
  String _customerStatusHealthValue;
  String _relationsWithCustomersForInsuranceValue;
  String _birthOfYearInsuranceValue;

  bool isScholarship = false;
  bool isGiftTET = false;
  bool isHomeCEP = false;
  bool isCareerDevelopment = false;
  bool isInsurance = false;
  int selectedIndexScholarshipAndGift;
  int selectedIndexGetScholarshipSomeYearsAgo;
  int selectedIndexGetConfirmBuild;

  //
  //
  //
  //
  //

  List<String> listTypeArea = [
    'Có',
    'Không',
  ];
  List<String> listTypeScholarship = [
    'Học Bổng',
    'Quà Học Tập',
  ];

  List<String> listTypeGetScholarship = [
    'Có',
    'Không',
  ];

  Map<String, bool> values = {
    'Đóng học phí': false,
    'Mua dụng cụ học tập': false,
    'Khác': false,
  };
  List<String> listFamilyConfirmToBuild = [
    'Có',
    'Không',
  ];

  List<MetaDataCheckbox> listAttachment;
  List<MetaDataCheckbox> listUsePurpose;
  List<MetaDataCheckbox> listStudentSituation;
  List<MetaDataCheckbox> listHousingConditionsOfCustomers;
  List<MetaDataCheckbox> listAttachmentForHomeCEP;
  List<MetaDataCheckbox> listJoinReason;
  List<MetaDataCheckbox> listSightseeingOccupationModel;
  List<MetaDataCheckbox> listEngineerSupportSeminar;
  List<MetaDataCheckbox> listSCC;
  List<MetaDataCheckbox> listIECD;
  List<MetaDataCheckbox> listREACH;

  CommunityDevelopmentBloc communityDevelopmentBloc;
  Services services;

  void changeIndexIsOfficerInFamily(int index) {
    setState(() {
      selectedIndexIsOfficerInFamily = index;
    });
  }

  void changeIndexCareerModel(int index) {
    setState(() {
      selectedIndexCareerModel = index;
    });
  }

  void changeIndexScholarshipAndGift(int index) {
    setState(() {
      selectedIndexScholarshipAndGift = index;
      isShowContainerScholarshipAndGift = index == 1 ? true : false;
    });
  }

  void changeIndexGetScholarshipSomeYearsAgo(int index) {
    setState(() {
      selectedIndexGetScholarshipSomeYearsAgo = index;
    });
  }

  void changeIndexGetConfirmBuild(int index) {
    setState(() {
      selectedIndexGetConfirmBuild = index;
    });
  }

  void loadInitData() {
    _tabController = new TabController(length: 2, vsync: this);

    // co vo chong la CNV
    selectedIndexIsOfficerInFamily = widget.khachHang.coVoChongConLaCnv ? 1 : 0;
    // mo hinh nghe
    selectedIndexCareerModel = widget.khachHang.moHinhNghe ? 1 : 0;
    // nghe nghiep cu the
    _controllerCareerSpecific.text = widget.khachHang.ghiChu;
    // nghe nghiep cu the
    _controllerFamilysMonthlyIncome.text =
        widget.khachHang.thunhapHangthangCuaho.toString();
    // nghe nghiep
    _occupationOfCustomerModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'NgheNghiep').toList());
    _occupationOfCustomerValue = widget.khachHang.ngheNghiep.toInt().toString();
    // thu nhap hang thang cua ho
    _controllerFamilysMonthlyIncome.text = MoneyFormat.moneyFormat(
        widget.khachHang.thunhapHangthangCuaho.toInt().toString());

    /// Hoc Bong///
    // ho va ten hoc sinh hoc bong
    _controllerFullNameForScholarship.text =
        widget.khachHang.hocBong.hotenhocsinh;

    ///nam sinh
    _birthOfYearModelDropdownList = Helper.buildDropdownNonMetaData(
        List<String>.generate(42, (int index) => (1980 + index).toString()));
    _birthOfYearValue = widget.khachHang.hocBong.namsinh.toInt().toString();

    //quan he voi KH
    _relationsWithCustomersModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox
            .where((e) => e.groupId == 'QuanHeConChau')
            .toList());
    _relationsWithCustomersValue =
        widget.khachHang.hocBong.quanhekhachhang.toInt().toString();

    // truong
    _controllerSchoolName.text = widget.khachHang.hocBong.truonghoc;
    // lop
    _controllerClassName.text = widget.khachHang.hocBong.lop.toInt().toString();
    // hoc luc
    _capacityModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'Hocluc').toList());
    _capacityValue = widget.khachHang.hocBong.hocluc.toInt().toString();

    // hoan canh gia dinh
    _controllerFamilyCircumstances.text =
        widget.khachHang.hocBong.hoancanhgiadinh;

    // trao hoc bong & qua tang
    selectedIndexScholarshipAndGift =
        widget.khachHang.hocBong.hocbong_Quatang.toInt() == 0 ? 2 : 1;

    // muc dich su dung hoc bong
    listUsePurpose = widget.listCombobox
        .where((e) => e.groupId == 'MucDichSuDungHocBong')
        .map((e) => MetaDataCheckbox(
            groupText: e.itemText,
            itemID: int.parse(e.itemId),
            value: Helper.checkFlag(
                widget.khachHang.hocBong.mucdich.toInt(), int.parse(e.itemId))))
        .toList();
    // muc dich cu the
    _controllerSpecificPurpose.text = widget.khachHang.hocBong.ghiChu;
    // gia tri hoc bong
    _controllerScholarshipValue.text = MoneyFormat.moneyFormat(
        widget.khachHang.hocBong.giatri.toInt().toString());

    // ho so dinh kem
    listAttachment = widget.listCombobox
        .where((e) => e.groupId == 'DinhKemHoSo')
        .map((e) => MetaDataCheckbox(
            groupText: e.itemText,
            itemID: int.parse(e.itemId),
            value: Helper.checkFlag(
                widget.khachHang.hocBong.dinhKemHoSo.toInt(),
                int.parse(e.itemId))))
        .toList();

    // hoan canh cua hoc sinh
    listStudentSituation = widget.listCombobox
        .where((e) => e.groupId == 'HoanCanhHocSinh')
        .map((e) => MetaDataCheckbox(
            groupText: e.itemText,
            itemID: int.parse(e.itemId),
            value: Helper.checkFlag(
                widget.khachHang.hocBong.hoancanhhocsinh.toInt(),
                int.parse(e.itemId))))
        .toList();
    // da nhan hoc bong nhung nam truoc

    selectedIndexGetScholarshipSomeYearsAgo =
        widget.khachHang.hocBong.danhanhocbong ? 1 : 0;
    ////// final Hoc Bong///////
    ///
    // Qua tet
    // khach hang thuoc ho
    _typeCustomerModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'LoaiHoNgheo').toList());
    _typeCustomerValue = widget.khachHang.quaTet.loaiHoNgheo.toInt().toString();

    /// final Qua tet
    // ty le phu thuoc

    _depenRatioModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'Tilephuthuoc').toList());
    _depenRatioCustomerValue =
        widget.khachHang.maiNha.tilephuthuoc.toInt().toString();
    // thu nhap
    _incomeModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'Thunhap').toList());
    _incomeValue = widget.khachHang.maiNha.thunhap.toInt().toString();
    // tai san
    _assetsModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'Taisan').toList());
    _assetsValue = widget.khachHang.maiNha.taisan.toInt().toString();
    // quyen so huu nha
    _homeOwnershipModelDropdownList = Helper.buildDropdownFromMetaData(widget
        .listCombobox
        .where((e) => e.groupId == 'QuyenSoHuuNha')
        .toList());
    _homeOwnershipValue =
        widget.khachHang.maiNha.quyenSoHuuNha.toInt().toString();

    // dieu kien nha o cua khach hang
    listHousingConditionsOfCustomers = widget.listCombobox
        .where((e) => e.groupId == 'Dieukiennhao')
        .map((e) => MetaDataCheckbox(
            groupText: e.itemText,
            itemID: int.parse(e.itemId),
            value: Helper.checkFlag(
                widget.khachHang.maiNha.dieukiennhao.toInt(),
                int.parse(e.itemId))))
        .toList();
    // de xuat xay sua cua kh
    _customerBuildSuggestionsModelDropdownList =
        Helper.buildDropdownFromMetaData(
            widget.listCombobox.where((e) => e.groupId == 'CBDexuat').toList());
    _customerBuildSuggestionsValue =
        widget.khachHang.maiNha.cbDexuat.toInt().toString();
    _controllerAmountProposeCEPSupport.text = MoneyFormat.moneyFormat(
        widget.khachHang.maiNha.deXuatHoTro.toInt().toString());
    _controllerAmountFamilySupport.text = MoneyFormat.moneyFormat(
        widget.khachHang.maiNha.giaDinhHoTro.toInt().toString());
    _controllerAmountSaving.text = MoneyFormat.moneyFormat(
        widget.khachHang.maiNha.tietKiem.toInt().toString());
    _controllerAmountLoan.text = MoneyFormat.moneyFormat(
        widget.khachHang.maiNha.tienVay.toInt().toString());

    onTotalAmountForRoof();

    // ho so dinh kem mai nha cep
    listAttachmentForHomeCEP = widget.listCombobox
        .where((e) => e.groupId == 'Hosodinhkem')
        .map((e) => MetaDataCheckbox(
            groupText: e.itemText,
            itemID: int.parse(e.itemId),
            value: Helper.checkFlag(widget.khachHang.maiNha.hosodinhkem.toInt(),
                int.parse(e.itemId))))
        .toList();

    _controllerFamilyCircumstancesNote.text =
        widget.khachHang.maiNha.ghichuhoancanh;

    selectedIndexGetConfirmBuild = widget.khachHang.maiNha.giaDinhDongY ? 1 : 0;
    // Phat Trien Nghe //
    // ho ten nguoi than
    _controllerFullNameOfRelative.text =
        widget.khachHang.phatTrienNghe.nguoithan;
    // quan he voi khach hang phat trien nghe
    _relationsWithCustomersJobDevelopModelDropdownList =
        Helper.buildDropdownFromMetaData(widget.listCombobox
            .where((e) => e.groupId == 'QuanHeKhachHang')
            .toList());
    _relationsWithCustomersJobDevelop =
        widget.khachHang.phatTrienNghe.quanHeKhacHang.toInt().toString();
    // hoan canh gia dinh
    _controllerFamilyCircumstancesForDevelopOccupation.text =
        widget.khachHang.phatTrienNghe.hoancanh;
    // ly do tham gia
    listJoinReason = widget.listCombobox
        .where((e) => e.groupId == 'LyDo')
        .map((e) => MetaDataCheckbox(
            groupText: e.itemText,
            itemID: int.parse(e.itemId),
            value: Helper.checkFlag(widget.khachHang.phatTrienNghe.lyDo.toInt(),
                int.parse(e.itemId))))
        .toList();

    // tham quan mo hinh nghe nghiep
    listSightseeingOccupationModel = widget.listCombobox
        .where((e) => e.groupId == 'Nguyenvongthamgia')
        .map((e) => MetaDataCheckbox(
            groupText: e.itemText,
            itemID: int.parse(e.itemId),
            value: Helper.checkFlag(
                widget.khachHang.phatTrienNghe.nguyenvongthamgia.toInt(),
                int.parse(e.itemId))))
        .toList();
    // hoi thao ho tro ky thuat
    listEngineerSupportSeminar = widget.listCombobox
        .where((e) => e.groupId == 'Nguyenvonghoithao')
        .map((e) => MetaDataCheckbox(
            groupText: e.itemText,
            itemID: int.parse(e.itemId),
            value: Helper.checkFlag(
                widget.khachHang.phatTrienNghe.nguyenvonghoithao.toInt(),
                int.parse(e.itemId))))
        .toList();
    // SCC
    listSCC = widget.listCombobox
        .where((e) => e.groupId == 'SCCnguyenvong')
        .map((e) => MetaDataCheckbox(
            groupText: e.itemText,
            itemID: int.parse(e.itemId),
            value: Helper.checkFlag(
                widget.khachHang.phatTrienNghe.scCnguyenvong.toInt(),
                int.parse(e.itemId))))
        .toList();
    // IECD
    listIECD = widget.listCombobox
        .where((e) => e.groupId == 'IECDnguyenvong')
        .map((e) => MetaDataCheckbox(
            groupText: e.itemText,
            itemID: int.parse(e.itemId),
            value: Helper.checkFlag(
                widget.khachHang.phatTrienNghe.iecDnguyenvong.toInt(),
                int.parse(e.itemId))))
        .toList();
    // REACH
    listREACH = widget.listCombobox
        .where((e) => e.groupId == 'REACHnguyenvong')
        .map((e) => MetaDataCheckbox(
            groupText: e.itemText,
            itemID: int.parse(e.itemId),
            value: Helper.checkFlag(
                widget.khachHang.phatTrienNghe.reacHnguyenvong.toInt(),
                int.parse(e.itemId))))
        .toList();
    // muc phi bao hiem
    _controllerInsuranceFees.text = MoneyFormat.moneyFormat(
        widget.khachHang.bhyt.mucphibaohiem.toInt().toString());
    // dieu kien tiep can dich vu BHYT
    _conditionToHaveInsuranceServiceModelDropdownList =
        Helper.buildDropdownFromMetaData(widget.listCombobox
            .where((e) => e.groupId == 'Dieukienbhyt')
            .toList());
    _conditionToHaveInsuranceServiceValue =
        widget.khachHang.bhyt.dieukienbhyt.toInt().toString();
    // tinh trang suc khoe
    _customerStatusHealthModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox
            .where((e) => e.groupId == 'Tinhtrangsuckhoe')
            .toList());
    _customerStatusHealthValue =
        widget.khachHang.bhyt.tinhtrangsuckhoe.toInt().toString();
    // ho va ten nguoi than
    _controllerFullNameOfRelativeForInsurance.text =
        widget.khachHang.bhyt.nguoithan;
    // quan he voi khach hang bhyt
    _relationsWithCustomersForInsuranceModelDropdownList =
        Helper.buildDropdownFromMetaData(widget.listCombobox
            .where((e) => e.groupId == 'QuanHeKhachHang')
            .toList());
    _relationsWithCustomersForInsuranceValue =
        widget.khachHang.bhyt.quanHeKhachHang.toInt().toString();
    // nam sinh insurance
    ///nam sinh
    _birthOfYearInsuranceModelDropdownList = Helper.buildDropdownNonMetaData(
        List<String>.generate(42, (int index) => (1980 + index).toString()));
    _birthOfYearInsuranceValue =
        widget.khachHang.bhyt.namsinh.toInt().toString();
  }

  void fillCheckboxTypeCommunityDevelopment() {
    isInsurance = widget.khachHang.isCheckBHYT;
    isScholarship = widget.khachHang.isCheckHocBong;
    isGiftTET = widget.khachHang.isCheckQuaTet;
    isHomeCEP = widget.khachHang.isCheckMaiNha;
    isCareerDevelopment = widget.khachHang.isCheckPhatTrienNghe;
  }

  @override
  void initState() {
    services = Services.of(context);
    communityDevelopmentBloc = new CommunityDevelopmentBloc(
        services.sharePreferenceService, services.commonService);
    loadInitData();
    fillCheckboxTypeCommunityDevelopment();

    //services = Services.of(context);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });

    _controllerRotateIconScholarship =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _controllerRotateIconGiftTET =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _controllerRotateIconHomeCEP =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _controllerRotateIconCareerDevelopment =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _controllerRotateIconInsurance =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    // surVeyBloc =
    //     new SurveyBloc(services.sharePreferenceService, services.commonService);
    //surVeyBloc.emitEvent(LoadSurveyEvent());
    _controllerFadeTransitionScholarship = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _animationFadeTransitionScholarship = CurvedAnimation(
      parent: _controllerFadeTransitionScholarship,
      curve: Curves.easeIn,
    );

    _controllerFadeTransitionGiftTET = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animationFadeTransitionGiftTET = CurvedAnimation(
      parent: _controllerFadeTransitionGiftTET,
      curve: Curves.easeIn,
    );

    _controllerFadeTransitionHomeCEP = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _animationFadeTransitionHomeCEP = CurvedAnimation(
      parent: _controllerFadeTransitionHomeCEP,
      curve: Curves.easeIn,
    );

    _controllerFadeTransitionCareerDevelopment = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _animationFadeTransitionCareerDevelopment = CurvedAnimation(
      parent: _controllerFadeTransitionCareerDevelopment,
      curve: Curves.easeIn,
    );

    _controllerFadeTransitionInsurance = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _animationFadeTransitionInsurance = CurvedAnimation(
      parent: _controllerFadeTransitionInsurance,
      curve: Curves.easeIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controllerFadeTransitionScholarship.dispose();
    _controllerFadeTransitionGiftTET.dispose();
    _controllerFadeTransitionHomeCEP.dispose();
    _controllerFadeTransitionCareerDevelopment.dispose();
    _controllerFadeTransitionInsurance.dispose();
    _controllerRotateIconScholarship.dispose();
    _controllerRotateIconGiftTET.dispose();
    _controllerRotateIconHomeCEP.dispose();
    _controllerRotateIconCareerDevelopment.dispose();
    _controllerRotateIconInsurance.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  _onChangeOccupationOfCustomerModelDropdown(String value) {
    setState(() {
      _occupationOfCustomerValue = value;
    });
  }

  _onChangeBirthOfYearModelDropdown(String value) {
    setState(() {
      _birthOfYearValue = value;
    });
  }

  _onChangeRelationsWithCustomersModelDropdown(String value) {
    setState(() {
      _relationsWithCustomersValue = value;
    });
  }

  _onSaveToSqlite() {
    communityDevelopmentBloc
        .emitEvent(UpdateCommunityDevelopmentEvent(context, getVM()));
  }

  _onSaveToServer() {
    communityDevelopmentBloc
        .emitEvent(UpdateCommunityDevelopmentToServerEvent(context, getVM()));
  }

  KhachHang getVM() {
    KhachHang model = new KhachHang();
    model.id = widget.khachHang.id;
    model.coVoChongConLaCnv =
        selectedIndexIsOfficerInFamily == 1 ? true : false;
    model.moHinhNghe = selectedIndexCareerModel == 1 ? true : false;
    model.ghiChu = _controllerCareerSpecific.text;
    model.ngheNghiep = double.parse(_occupationOfCustomerValue);
    model.thunhapHangthangCuaho =
        MoneyFormat.convertCurrencyToInt(_controllerFamilysMonthlyIncome.text)
            .toDouble();

    // Hoc Bong//
    model.hocBong = new HocBong();
    model.hocBong.hotenhocsinh = _controllerFullNameForScholarship.text;
    model.hocBong.namsinh = double.parse(_birthOfYearValue);
    model.hocBong.quanhekhachhang = double.parse(_relationsWithCustomersValue);
    model.hocBong.truonghoc = _controllerSchoolName.text;
    model.hocBong.lop = double.parse(_controllerClassName.text);
    model.hocBong.hocluc = double.parse(_capacityValue);
    model.hocBong.hoancanhgiadinh = _controllerFamilyCircumstances.text;
    model.hocBong.hocbong_Quatang = selectedIndexScholarshipAndGift.toDouble();
    model.hocBong.mucdich =
        Helper.sumValueCheckedForListCheckbox(listUsePurpose);
    model.hocBong.ghiChu = _controllerSpecificPurpose.text;
    model.hocBong.giatri =
        MoneyFormat.convertCurrencyToInt(_controllerScholarshipValue.text)
            .toDouble();
    model.hocBong.dinhKemHoSo =
        Helper.sumValueCheckedForListCheckbox(listAttachment);
    model.hocBong.hoancanhhocsinh =
        Helper.sumValueCheckedForListCheckbox(listStudentSituation);
    model.hocBong.danhanhocbong =
        selectedIndexGetScholarshipSomeYearsAgo == 1 ? true : false;
    print("a");
    ////// final Hoc Bong ///////

    // Qua Tet//
    model.quaTet = new QuaTet();
    model.quaTet.loaiHoNgheo = double.parse(_typeCustomerValue);
    //
    // Mai Nha//
    model.maiNha = new MaiNha();
    model.maiNha.tilephuthuoc = double.parse(_depenRatioCustomerValue);
    model.maiNha.thunhap = double.parse(_incomeValue);
    model.maiNha.taisan = double.parse(_assetsValue);
    model.maiNha.quyenSoHuuNha = double.parse(_homeOwnershipValue);
    model.maiNha.dieukiennhao =
        Helper.sumValueCheckedForListCheckbox(listHousingConditionsOfCustomers);
    model.maiNha.cbDexuat = double.parse(_customerBuildSuggestionsValue);
    model.maiNha.deXuatHoTro = MoneyFormat.convertCurrencyToInt(
            _controllerAmountProposeCEPSupport.text)
        .toDouble();
    model.maiNha.giaDinhHoTro =
        MoneyFormat.convertCurrencyToInt(_controllerAmountFamilySupport.text)
            .toDouble();
    model.maiNha.tietKiem =
        MoneyFormat.convertCurrencyToInt(_controllerAmountSaving.text)
            .toDouble();
    model.maiNha.tienVay =
        MoneyFormat.convertCurrencyToInt(_controllerAmountLoan.text).toDouble();
    model.maiNha.hosodinhkem =
        Helper.sumValueCheckedForListCheckbox(listAttachmentForHomeCEP);
    model.maiNha.ghichuhoancanh = _controllerFamilyCircumstancesNote.text;
    model.maiNha.giaDinhDongY =
        selectedIndexGetConfirmBuild == 1 ? true : false;
    model.maiNha.duTruKinhPhi = totalAmount.toDouble();
    //
    // Phat Trien Nghe//
    model.phatTrienNghe = new PhatTrienNghe();
    model.phatTrienNghe.nguoithan = _controllerFullNameOfRelative.text;
    model.phatTrienNghe.quanHeKhacHang =
        double.parse(_relationsWithCustomersJobDevelop);
    model.phatTrienNghe.hoancanh =
        _controllerFamilyCircumstancesForDevelopOccupation.text;
    model.phatTrienNghe.lyDo =
        Helper.sumValueCheckedForListCheckbox(listJoinReason);
    model.phatTrienNghe.nguyenvongthamgia =
        Helper.sumValueCheckedForListCheckbox(listSightseeingOccupationModel);
    model.phatTrienNghe.nguyenvonghoithao =
        Helper.sumValueCheckedForListCheckbox(listEngineerSupportSeminar);
    model.phatTrienNghe.scCnguyenvong =
        Helper.sumValueCheckedForListCheckbox(listSCC);
    model.phatTrienNghe.iecDnguyenvong =
        Helper.sumValueCheckedForListCheckbox(listIECD);
    model.phatTrienNghe.reacHnguyenvong =
        Helper.sumValueCheckedForListCheckbox(listREACH);
    //
    // Bao Hiem//
    model.bhyt = new BHYT();
    model.bhyt.mucphibaohiem =
        MoneyFormat.convertCurrencyToInt(_controllerInsuranceFees.text)
            .toDouble();
    model.bhyt.dieukienbhyt =
        double.parse(_conditionToHaveInsuranceServiceValue);
    model.bhyt.tinhtrangsuckhoe = double.parse(_customerStatusHealthValue);
    model.bhyt.tinhtrangsuckhoe = double.parse(_customerStatusHealthValue);
    model.bhyt.nguoithan = _controllerFullNameOfRelativeForInsurance.text;
    model.bhyt.quanHeKhachHang =
        double.parse(_relationsWithCustomersForInsuranceValue);
    model.bhyt.namsinh = double.parse(_birthOfYearInsuranceValue);
    //
    model.isCheckBHYT = isInsurance;
    model.isCheckHocBong = isScholarship;
    model.isCheckQuaTet = isGiftTET;
    model.isCheckMaiNha = isHomeCEP;
    model.isCheckPhatTrienNghe = isCareerDevelopment;
    return model;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                _onSaveToSqlite();
                // Navigator.pop(context, false);
              }),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.upload_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  dialogCustomForCEP(context,
                      "Bạn có muốn lưu dữ liệu đến server ?", _onSaveToServer,
                      children: [], width: screenWidth * 0.7);
                })
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 20,
          title: const Text('Chi Tiết Phát triển Cộng Đồng'),
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.blueGrey.shade300,
            indicatorColor: Colors.red,
            labelColor: Colors.white,
            tabs: [
              Tab(
                child: Column(
                  children: [
                    Center(
                      child: Icon(Icons.list),
                    ),
                    Center(
                        child: Text(
                      'Thông Tin Thành Viên',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Center(
                      child: Icon(IconsCustomize.insurance),
                    ),
                    Center(
                        child: Text(
                      'Chương Trình PT Cộng Đồng',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
              ),
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        body: BlocEventStateBuilder<CommunityDevelopmentState>(
            bloc: communityDevelopmentBloc,
            builder: (BuildContext context, CommunityDevelopmentState state) {
              return TabBarView(
                children: [
                  tabbarContent1(),
                  tabbarContent2(),
                ],
                controller: _tabController,
              );
            }),
      ),
    );
  }

  Widget tabbarContent1() => Container(
        padding: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 20),
        color: Colors.grey[200],
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(child: titleHeader("Thông Tin Thành Viên")),
            divider15,
            Card(
              elevation: 20,
              color: Colors.brown[100],
              shadowColor: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            labelCard("Chi nhánh"),
                            cardVerticalDivider,
                            labelValue(
                                widget.khachHang.chinhanhId.toInt().toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            labelCard("Lần vay"),
                            cardVerticalDivider,
                            labelValue(
                                widget.khachHang.lanvay.toInt().toString()),
                          ],
                        ),
                      ],
                    ),
                    divider15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        labelCard("Thành viên:"),
                        cardVerticalDivider,
                        labelValue(widget.khachHang.thanhVienId +
                            ' - ' +
                            widget.khachHang.hoTen),
                      ],
                    ),
                    divider15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            cardIcon(IconsCustomize.birth_date),
                            cardVerticalDivider,
                            labelValue(
                                FormatDateConstants.convertDateTimeToDDMMYYYY(
                                    widget.khachHang.ngaysinh)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              IconsCustomize.gender,
                              size: 20,
                              color: Colors.blue,
                            ),
                            cardVerticalDivider,
                            labelValue(
                                widget.khachHang.gioitinh == 0 ? "Nữ" : "Nam"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone_iphone,
                              color: Colors.blue,
                            ),
                            cardVerticalDivider,
                            labelValue(widget.khachHang.dienthoai),
                          ],
                        ),
                      ],
                    ),
                    divider15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                        cardVerticalDivider,
                        SizedBox(
                          width: screenWidth * 0.77,
                          child: Text(
                            widget.khachHang.diachi,
                            style: TextStyle(
                                color: Colors.green[800],
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    divider15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.blue,
                            ),
                            cardVerticalDivider,
                            labelValue(
                                FormatDateConstants.convertDateTimeToDDMMYYYY(
                                    widget.khachHang.thoigianthamgia)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            labelCard("Mã số hộ nghèo:"),
                            cardVerticalDivider,
                            labelValue(widget.khachHang.maHongheoCanngheo),
                          ],
                        ),
                      ],
                    ),
                    divider15,
                  ],
                ),
              ),
            ),
            divider15,
            Card(
              elevation: 20,
              color: Colors.grey[200],
              borderOnForeground: false,
              clipBehavior: Clip.hardEdge,
              shadowColor: Colors.grey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                    ),
                    padding: EdgeInsets.all(5.0),
                    width: double.infinity,
                    child: Container(
                      width: screenWidth * 0.77,
                      child: Text(
                        "Có vợ/chồng/con là CNV",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        customRadioIsOfficerInFamily(listTypeArea[0], 1),
                        VerticalDivider(
                          width: 10,
                          color: Colors.grey.withOpacity(0),
                        ),
                        customRadioIsOfficerInFamily(listTypeArea[1], 0),
                      ],
                    ),
                  )
                ],
              ),
            ),
            divider15,
            Card(
              elevation: 20,
              color: Colors.grey[200],
              borderOnForeground: false,
              clipBehavior: Clip.hardEdge,
              shadowColor: Colors.grey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                    ),
                    padding: EdgeInsets.all(5.0),
                    width: double.infinity,
                    child: Container(
                      width: screenWidth * 0.77,
                      child: Text(
                        "Mô hình nghề hiệu quả",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        customRadioCareerModel(listTypeArea[0], 1),
                        VerticalDivider(
                          width: 10,
                          color: Colors.grey.withOpacity(0),
                        ),
                        customRadioCareerModel(listTypeArea[1], 0),
                      ],
                    ),
                  )
                ],
              ),
            ),
            divider15,
            Card(
              elevation: 20,
              color: Colors.grey[200],
              borderOnForeground: false,
              clipBehavior: Clip.hardEdge,
              shadowColor: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          //width: screenWidth * 0.38,
                          child: Text(
                            "Nghề nghiệp",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        CustomDropdown(
                          dropdownMenuItemList:
                              _occupationOfCustomerModelDropdownList,
                          onChanged: _onChangeOccupationOfCustomerModelDropdown,
                          value: _occupationOfCustomerValue,
                          width: screenWidth * 0.5,
                          isEnabled: true,
                          isUnderline: false,
                        ),
                      ],
                    ),
                    Divider(
                      height: 8,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.38,
                          child: Text(
                            "Nghề nghiệp cụ thể",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            child: TextField(
                              controller: _controllerCareerSpecific,
                              style: textStyleTextFieldCEP,
                              decoration: inputDecorationTextFieldCEP(
                                  "Nhập tối đa 40 ký tự"),
                              keyboardType: TextInputType.text,
                              // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 8,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.38,
                          child: Text(
                            "Thu nhập hàng tháng của hộ",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            style: textStyleTextFieldCEP,
                            controller: _controllerFamilysMonthlyIncome,
                            decoration: inputDecorationTextFieldCEP(
                                "Nhập số tiền...",
                                suffixText: "VNĐ"),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              CurrencyInputFormatter(),
                            ], // Only numbers can be entered
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget tabbarContent2() => Container(
        padding: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 20),
        color: Colors.grey[200],
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            controller: _scrollController,
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                Center(child: titleHeader("Chương Trình Phát Triển Cộng Đồng")),
                divider15,
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        // Provide an optional curve to make the animation feel smoother.
                        curve: Curves.easeOut,
                        height: 40,
                        padding: EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isScholarship) {
                                isCollapseScholarship = !isCollapseScholarship;
                                if (isCollapseScholarship == true) {
                                  isShowContainerScholarshipAndGift =
                                      selectedIndexScholarshipAndGift == 1
                                          ? true
                                          : false;
                                  _controllerRotateIconScholarship.forward();
                                  _controllerFadeTransitionScholarship
                                      .forward();
                                } else {
                                  isShowContainerScholarshipAndGift = false;
                                  _controllerRotateIconScholarship.reverse();
                                  _controllerFadeTransitionScholarship
                                      .reverse();
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (!isScholarship) {
                                              _controllerRotateIconScholarship
                                                  .reset();
                                              _controllerFadeTransitionScholarship
                                                  .forward();
                                            } else {
                                              isCollapseScholarship = false;
                                              isShowContainerScholarshipAndGift =
                                                  false;
                                              _controllerFadeTransitionScholarship
                                                  .reverse();
                                            }
                                            isScholarship = !isScholarship;
                                          });
                                        },
                                        child: Container(
                                          width: 80,
                                          margin: EdgeInsets.only(bottom: 30),
                                          child: CheckboxListTile(
                                            value: isScholarship,
                                            checkColor: Colors.white,
                                            activeColor: Colors.blue,
                                            onChanged: (newValue) {},
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: AnimatedDefaultTextStyle(
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: isScholarship
                                                  ? Colors.red
                                                  : Colors.blue,
                                              fontWeight: FontWeight.bold),

                                          duration: Duration(milliseconds: 500),
                                          // Provide an optional curve to make the animation feel smoother.
                                          curve: Curves.easeOut,
                                          child: Text(
                                            "Học Bổng CEP",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  // Provide an optional curve to make the animation feel smoother.
                                  curve: Curves.easeOut,
                                  opacity: !isScholarship ? 0 : 1,
                                  child: AnimatedBuilder(
                                    animation: _controllerRotateIconScholarship,
                                    builder: (_, child) {
                                      return Transform.rotate(
                                        angle: _controllerRotateIconScholarship
                                                .value *
                                            1 *
                                            math.pi,
                                        child: child,
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedSize(
                        vsync: this,
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeTransition(
                          opacity: _animationFadeTransitionScholarship,
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1500),
                                curve: Curves.fastOutSlowIn,
                                height: isCollapseScholarship == true ? 420 : 0,
                                color: Colors.white,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.38,
                                          child: Text(
                                            "Họ & tên học sinh",
                                            style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 40,
                                            child: TextField(
                                              controller:
                                                  _controllerFullNameForScholarship,
                                              style: textStyleTextFieldCEP,
                                              decoration:
                                                  inputDecorationTextFieldCEP(
                                                      "Nhập..."),
                                              keyboardType: TextInputType.text,
                                              // Only numbers can be entered
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    divider5,
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.38,
                                            child: Text(
                                              "Năm sinh",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              child: CustomDropdown(
                                                dropdownMenuItemList:
                                                    _birthOfYearModelDropdownList,
                                                onChanged:
                                                    _onChangeBirthOfYearModelDropdown,
                                                value: _birthOfYearValue,
                                                width: screenWidth * 1,
                                                isEnabled: true,
                                                isUnderline: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider5,
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.38,
                                            child: Text(
                                              "Quan hệ với KH",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              child: CustomDropdown(
                                                dropdownMenuItemList:
                                                    _relationsWithCustomersModelDropdownList,
                                                onChanged:
                                                    _onChangeRelationsWithCustomersModelDropdown,
                                                value:
                                                    _relationsWithCustomersValue,
                                                width: screenWidth * 1,
                                                isEnabled: true,
                                                isUnderline: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider5,
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.38,
                                            child: Text(
                                              "Trường",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              child: TextField(
                                                controller:
                                                    _controllerSchoolName,
                                                style: textStyleTextFieldCEP,
                                                decoration:
                                                    inputDecorationTextFieldCEP(
                                                        "Nhập..."),
                                                keyboardType:
                                                    TextInputType.text,
                                                // Only numbers can be entered
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider5,
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.38,
                                            child: Text(
                                              "Lớp",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              child: TextField(
                                                controller:
                                                    _controllerClassName,
                                                style: textStyleTextFieldCEP,
                                                decoration:
                                                    inputDecorationTextFieldCEP(
                                                        "Nhập..."),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  WhitelistingTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                // Only numbers can be entered
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider5,
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.38,
                                            child: Text(
                                              "Học lực",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              child: CustomDropdown(
                                                dropdownMenuItemList:
                                                    _capacityModelDropdownList,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _capacityValue = value;
                                                  });
                                                },
                                                value: _capacityValue,
                                                width: screenWidth * 1,
                                                isEnabled: true,
                                                isUnderline: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              "Hoàn cảnh gia đình",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: TextField(
                                              controller:
                                                  _controllerFamilyCircumstances,
                                              style: textStyleTextFieldCEP,
                                              decoration:
                                                  inputDecorationTextFieldCEP(
                                                      "Nhập..."),
                                              keyboardType: TextInputType.text,
                                              // Only numbers can be entered
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.5,
                                            child: Text(
                                              "Trao Học Bổng & Quà Học Tập",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              customRadioScholarshipAndGift(
                                                  listTypeScholarship[0], 1),
                                              VerticalDivider(
                                                width: 10,
                                              ),
                                              customRadioScholarshipAndGift(
                                                  listTypeScholarship[1], 2),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1500),
                                curve: Curves.fastOutSlowIn,
                                height:
                                    isShowContainerScholarshipAndGift == true
                                        ? 1080
                                        : 0,
                                color: Colors.white,
                                padding: EdgeInsets.all(8),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    CardWithMultipleCheckbox(
                                      title: "Mục đích sử dụng học bổng",
                                      height: 180,
                                      children: listUsePurpose.map((item) {
                                        return new CheckboxListTile(
                                          title: new Text(
                                            item.groupText,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: item.value,
                                          activeColor:
                                              ColorConstants.cepColorBackground,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              item.value = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.38,
                                            child: Text(
                                              "Mục đích cụ thể",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              child: TextField(
                                                controller:
                                                    _controllerSpecificPurpose,
                                                style: textStyleTextFieldCEP,
                                                decoration:
                                                    inputDecorationTextFieldCEP(
                                                        "Nhập..."),
                                                keyboardType:
                                                    TextInputType.text,
                                                // Only numbers can be entered
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.38,
                                            child: Text(
                                              "Giá trị học bổng",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              child: TextField(
                                                  controller:
                                                      _controllerScholarshipValue,
                                                  style: textStyleTextFieldCEP,
                                                  decoration:
                                                      inputDecorationTextFieldCEP(
                                                          "Nhập số tiền...",
                                                          suffixText: "VNĐ"),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    CurrencyInputFormatter(),
                                                  ]
                                                  // Only numbers can be entered
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    CardWithMultipleCheckbox(
                                      title: "Hồ sơ đính kèm",
                                      height: 380,
                                      children: listAttachment.map((item) {
                                        return new CheckboxListTile(
                                          title: new Text(
                                            item.groupText,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: item.value,
                                          activeColor:
                                              ColorConstants.cepColorBackground,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              item.value = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    divider15,
                                    CardWithMultipleCheckbox(
                                      title: "Hoàn cảnh của học sinh",
                                      height: 180,
                                      children:
                                          listStudentSituation.map((item) {
                                        return new CheckboxListTile(
                                          title: new Text(
                                            item.groupText,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: item.value,
                                          activeColor:
                                              ColorConstants.cepColorBackground,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              item.value = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.7,
                                            child: Text(
                                              "Đã nhận học bổng những năm trước",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              customRadioGetScholarshipSomeYearsAgo(
                                                  listTypeGetScholarship[0], 1),
                                              VerticalDivider(
                                                width: 10,
                                              ),
                                              customRadioGetScholarshipSomeYearsAgo(
                                                  listTypeGetScholarship[1], 0),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                divider15,
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        // Provide an optional curve to make the animation feel smoother.
                        curve: Curves.easeOut,
                        height: 40,
                        padding: EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isGiftTET) {
                                isCollapseGiftTET = !isCollapseGiftTET;
                                if (isCollapseGiftTET == true) {
                                  //isShowContainerScholarshipAndGift = selectedIndexScholarshipAndGift == 1 ? true :false;
                                  _controllerRotateIconGiftTET.forward();
                                  _controllerFadeTransitionGiftTET.forward();
                                } else {
                                  _controllerRotateIconGiftTET.reverse();
                                  _controllerFadeTransitionGiftTET.reverse();
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (!isGiftTET) {
                                              _controllerRotateIconGiftTET
                                                  .reset();
                                              _controllerFadeTransitionGiftTET
                                                  .forward();
                                            } else {
                                              isCollapseGiftTET = false;
                                              isShowContainerScholarshipAndGift =
                                                  false;
                                              _controllerFadeTransitionGiftTET
                                                  .reverse();
                                            }
                                            isGiftTET = !isGiftTET;
                                          });
                                        },
                                        child: Container(
                                          width: 80,
                                          margin: EdgeInsets.only(bottom: 30),
                                          child: CheckboxListTile(
                                            checkColor: Colors.white,
                                            activeColor: Colors.blue,
                                            value: isGiftTET,
                                            onChanged: (newValue) {},
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: AnimatedDefaultTextStyle(
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: isGiftTET
                                                  ? Colors.red
                                                  : Colors.blue,
                                              fontWeight: FontWeight.bold),

                                          duration: Duration(milliseconds: 500),
                                          // Provide an optional curve to make the animation feel smoother.
                                          curve: Curves.easeOut,
                                          child: Text(
                                            "Nhận Quà Tết",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  // Provide an optional curve to make the animation feel smoother.
                                  curve: Curves.easeOut,
                                  opacity: !isGiftTET ? 0 : 1,
                                  child: AnimatedBuilder(
                                    animation: _controllerRotateIconGiftTET,
                                    builder: (_, child) {
                                      return Transform.rotate(
                                        angle:
                                            _controllerRotateIconGiftTET.value *
                                                1 *
                                                math.pi,
                                        child: child,
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedSize(
                        vsync: this,
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeTransition(
                          opacity: _animationFadeTransitionGiftTET,
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1500),
                                curve: Curves.fastOutSlowIn,
                                height: isCollapseGiftTET == true ? 70 : 0,
                                color: Colors.white,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              "Khách hàng thuộc hộ",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: CustomDropdown(
                                              dropdownMenuItemList:
                                                  _typeCustomerModelDropdownList,
                                              onChanged: (value) {
                                                setState(() {
                                                  _typeCustomerValue = value;
                                                });
                                              },
                                              value: _typeCustomerValue,
                                              width: screenWidth * 1,
                                              isEnabled: true,
                                              isUnderline: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                divider15,
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 1500),
                        // Provide an optional curve to make the animation feel smoother.
                        curve: Curves.easeOut,
                        height: 40,
                        padding: EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isHomeCEP) {
                                isCollapseHomeCEP = !isCollapseHomeCEP;
                                if (isCollapseHomeCEP == true) {
                                  //isShowContainerScholarshipAndGift = selectedIndexScholarshipAndGift == 1 ? true :false;
                                  _controllerRotateIconHomeCEP.forward();
                                  _controllerFadeTransitionHomeCEP.forward();
                                } else {
                                  _controllerRotateIconHomeCEP.reverse();
                                  _controllerFadeTransitionHomeCEP.reverse();
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (!isHomeCEP) {
                                              _controllerRotateIconHomeCEP
                                                  .reset();
                                              _controllerFadeTransitionHomeCEP
                                                  .forward();
                                            } else {
                                              isCollapseHomeCEP = false;
                                              isShowContainerScholarshipAndGift =
                                                  false;
                                              _controllerFadeTransitionHomeCEP
                                                  .reverse();
                                            }
                                            isHomeCEP = !isHomeCEP;
                                          });
                                        },
                                        child: Container(
                                          width: 80,
                                          margin: EdgeInsets.only(bottom: 30),
                                          child: CheckboxListTile(
                                            checkColor: Colors.white,
                                            activeColor: Colors.blue,
                                            value: isHomeCEP,
                                            onChanged: (newValue) {},
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: AnimatedDefaultTextStyle(
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: isHomeCEP
                                                  ? Colors.red
                                                  : Colors.blue,
                                              fontWeight: FontWeight.bold),

                                          duration: Duration(milliseconds: 500),
                                          // Provide an optional curve to make the animation feel smoother.
                                          curve: Curves.easeOut,
                                          child: Text(
                                            "Mái Nhà CEP",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  // Provide an optional curve to make the animation feel smoother.
                                  curve: Curves.easeOut,
                                  opacity: !isHomeCEP ? 0 : 1,
                                  child: AnimatedBuilder(
                                    animation: _controllerRotateIconHomeCEP,
                                    builder: (_, child) {
                                      return Transform.rotate(
                                        angle:
                                            _controllerRotateIconHomeCEP.value *
                                                1 *
                                                math.pi,
                                        child: child,
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedSize(
                        vsync: this,
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeTransition(
                          opacity: _animationFadeTransitionHomeCEP,
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1500),
                                curve: Curves.fastOutSlowIn,
                                height: isCollapseHomeCEP == true ? 1540 : 0,
                                color: Colors.white,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.38,
                                            child: Text(
                                              "Tỷ lệ phụ thuộc",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              child: CustomDropdown(
                                                dropdownMenuItemList:
                                                    _depenRatioModelDropdownList,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _depenRatioCustomerValue =
                                                        value;
                                                  });
                                                },
                                                value: _depenRatioCustomerValue,
                                                width: screenWidth * 1,
                                                isEnabled: true,
                                                isUnderline: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider5,
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.38,
                                            child: Text(
                                              "Thu nhập",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              child: CustomDropdown(
                                                dropdownMenuItemList:
                                                    _incomeModelDropdownList,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _incomeValue = value;
                                                  });
                                                },
                                                value: _incomeValue,
                                                width: screenWidth * 1,
                                                isEnabled: true,
                                                isUnderline: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider5,
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.38,
                                            child: Text(
                                              "Tài sản",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              child: CustomDropdown(
                                                dropdownMenuItemList:
                                                    _assetsModelDropdownList,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _assetsValue = value;
                                                  });
                                                },
                                                value: _assetsValue,
                                                width: screenWidth * 1,
                                                isEnabled: true,
                                                isUnderline: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.6,
                                            child: Text(
                                              "Quyền sở hữu nhà đề xuất xây/sửa",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: CustomDropdown(
                                              dropdownMenuItemList:
                                                  _homeOwnershipModelDropdownList,
                                              onChanged: (value) {
                                                setState(() {
                                                  _homeOwnershipValue = value;
                                                });
                                              },
                                              value: _homeOwnershipValue,
                                              width: screenWidth * 1,
                                              isEnabled: true,
                                              isUnderline: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    CardWithMultipleCheckbox(
                                      title: "Điều kiện nhà ở của khách hàng",
                                      height: 320,
                                      children: listHousingConditionsOfCustomers
                                          .map((item) {
                                        return new CheckboxListTile(
                                          title: new Text(
                                            item.groupText,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: item.value,
                                          activeColor:
                                              ColorConstants.cepColorBackground,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              item.value = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.6,
                                            child: Text(
                                              "Đề xuất xây/sửa của khách hàng",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: CustomDropdown(
                                              dropdownMenuItemList:
                                                  _customerBuildSuggestionsModelDropdownList,
                                              onChanged: (value) {
                                                setState(() {
                                                  _customerBuildSuggestionsValue =
                                                      value;
                                                });
                                              },
                                              value:
                                                  _customerBuildSuggestionsValue,
                                              width: screenWidth * 1,
                                              isEnabled: true,
                                              isUnderline: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.6,
                                            child: Text(
                                              "Đề xuất CEP hỗ trợ",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: TextField(
                                              onEditingComplete: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                onTotalAmountForRoof();
                                              },
                                              maxLength: 13,
                                              style: textStyleTextFieldCEP,
                                              controller:
                                                  _controllerAmountProposeCEPSupport,
                                              decoration:
                                                  inputDecorationTextFieldCEP(
                                                      "Nhập số tiền...",
                                                      suffixText: "VNĐ"),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                CurrencyInputFormatter(),
                                              ], // Only numbers can be entered
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.6,
                                            child: Text(
                                              "Gia đình hỗ trợ",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: TextField(
                                              style: textStyleTextFieldCEP,
                                              onEditingComplete: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                onTotalAmountForRoof();
                                              },
                                              maxLength: 13,
                                              controller:
                                                  _controllerAmountFamilySupport,
                                              decoration:
                                                  inputDecorationTextFieldCEP(
                                                      "Nhập số tiền...",
                                                      suffixText: "VNĐ"),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                CurrencyInputFormatter(),
                                              ], // Only numbers can be entered
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.6,
                                            child: Text(
                                              "Tiết kiệm",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: TextField(
                                              onEditingComplete: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                onTotalAmountForRoof();
                                              },
                                              maxLength: 13,
                                              style: textStyleTextFieldCEP,
                                              controller:
                                                  _controllerAmountSaving,
                                              decoration:
                                                  inputDecorationTextFieldCEP(
                                                      "Nhập số tiền...",
                                                      suffixText: "VNĐ"),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                CurrencyInputFormatter(),
                                              ], // Only numbers can be entered
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.6,
                                            child: Text(
                                              "Tiền vay",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: TextField(
                                              onEditingComplete: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                onTotalAmountForRoof();
                                              },
                                              maxLength: 13,
                                              style: textStyleTextFieldCEP,
                                              controller: _controllerAmountLoan,
                                              decoration:
                                                  inputDecorationTextFieldCEP(
                                                      "Nhập số tiền...",
                                                      suffixText: "VNĐ"),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                CurrencyInputFormatter(),
                                              ], // Only numbers can be entered
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.4,
                                            child: Text(
                                              "Dự trù kinh phí",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                                child: Opacity(
                                                  opacity: 1,
                                                  child: Text(
                                                    new String.fromCharCodes(
                                                        new Runes('\u{20ab}')),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              AnimatedFlipCounter(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                value: totalAmount,
                                                /* pass in a number like 2014 */
                                                color: Colors.grey,
                                                size: 14,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    CardWithMultipleCheckbox(
                                      title: "Hồ sơ đính kèm",
                                      height: 350,
                                      children:
                                          listAttachmentForHomeCEP.map((item) {
                                        return new CheckboxListTile(
                                          title: new Text(
                                            item.groupText,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: item.value,
                                          activeColor:
                                              ColorConstants.cepColorBackground,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              item.value = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              "Ghi chú về hoàn cảnh",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: TextField(
                                              controller:
                                                  _controllerFamilyCircumstancesNote,
                                              style: textStyleTextFieldCEP,
                                              decoration:
                                                  inputDecorationTextFieldCEP(
                                                      "Nhập..."),
                                              keyboardType: TextInputType.text,
                                              // Only numbers can be entered
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.7,
                                            child: Text(
                                              "Gia đình có đồng ý xây/sửa",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              customRadioGetConfirmBuild(
                                                  listFamilyConfirmToBuild[0],
                                                  1),
                                              VerticalDivider(
                                                width: 10,
                                              ),
                                              customRadioGetConfirmBuild(
                                                  listFamilyConfirmToBuild[1],
                                                  0),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                divider15,
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        // Provide an optional curve to make the animation feel smoother.
                        curve: Curves.easeOut,
                        height: 40,
                        padding: EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isCareerDevelopment) {
                                isCollapseCareerDevelopment =
                                    !isCollapseCareerDevelopment;
                                if (isCollapseCareerDevelopment == true) {
                                  //isShowContainerScholarshipAndGift = selectedIndexScholarshipAndGift == 1 ? true :false;
                                  _controllerRotateIconCareerDevelopment
                                      .forward();
                                  _controllerFadeTransitionCareerDevelopment
                                      .forward();
                                } else {
                                  _controllerRotateIconCareerDevelopment
                                      .reverse();
                                  _controllerFadeTransitionCareerDevelopment
                                      .reverse();
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (!isCareerDevelopment) {
                                              _controllerRotateIconCareerDevelopment
                                                  .reset();
                                              _controllerFadeTransitionCareerDevelopment
                                                  .forward();
                                            } else {
                                              isCollapseCareerDevelopment =
                                                  false;
                                              isShowContainerScholarshipAndGift =
                                                  false;
                                              _controllerFadeTransitionCareerDevelopment
                                                  .reverse();
                                            }
                                            isCareerDevelopment =
                                                !isCareerDevelopment;
                                          });
                                        },
                                        child: Container(
                                          width: 80,
                                          margin: EdgeInsets.only(bottom: 30),
                                          child: CheckboxListTile(
                                            value: isCareerDevelopment,
                                            checkColor: Colors.white,
                                            activeColor: Colors.blue,
                                            onChanged: (newValue) {},
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: AnimatedDefaultTextStyle(
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: isCareerDevelopment
                                                  ? Colors.red
                                                  : Colors.blue,
                                              fontWeight: FontWeight.bold),

                                          duration: Duration(milliseconds: 500),
                                          // Provide an optional curve to make the animation feel smoother.
                                          curve: Curves.easeOut,
                                          child: Text(
                                            "Phát Triển Nghề",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  // Provide an optional curve to make the animation feel smoother.
                                  curve: Curves.easeOut,
                                  opacity: !isCareerDevelopment ? 0 : 1,
                                  child: AnimatedBuilder(
                                    animation:
                                        _controllerRotateIconCareerDevelopment,
                                    builder: (_, child) {
                                      return Transform.rotate(
                                        angle:
                                            _controllerRotateIconCareerDevelopment
                                                    .value *
                                                1 *
                                                math.pi,
                                        child: child,
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedSize(
                        vsync: this,
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeTransition(
                          opacity: _animationFadeTransitionCareerDevelopment,
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1500),
                                curve: Curves.fastOutSlowIn,
                                height: isCollapseCareerDevelopment == true
                                    ? 1970
                                    : 0,
                                color: Colors.white,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              "Họ và tên người thân",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: TextField(
                                              controller:
                                                  _controllerFullNameOfRelative,
                                              style: textStyleTextFieldCEP,
                                              decoration:
                                                  inputDecorationTextFieldCEP(
                                                      "Nhập..."),
                                              keyboardType: TextInputType.text,
                                              // Only numbers can be entered
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              "Quan hệ với khách hàng",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: CustomDropdown(
                                              dropdownMenuItemList:
                                                  _relationsWithCustomersJobDevelopModelDropdownList,
                                              onChanged: (value) {
                                                setState(() {
                                                  _relationsWithCustomersJobDevelop =
                                                      value;
                                                });
                                              },
                                              value:
                                                  _relationsWithCustomersJobDevelop,
                                              width: screenWidth * 1,
                                              isEnabled: true,
                                              isUnderline: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              "Hoàn cảnh gia đình",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: TextField(
                                              controller:
                                                  _controllerFamilyCircumstancesForDevelopOccupation,
                                              style: textStyleTextFieldCEP,
                                              decoration:
                                                  inputDecorationTextFieldCEP(
                                                      "Nhập..."),
                                              keyboardType: TextInputType.text,
                                              // Only numbers can be entered
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    CardWithMultipleCheckbox(
                                      title: "Lý do tham gia chương trình",
                                      height: 180,
                                      children: listJoinReason.map((item) {
                                        return new CheckboxListTile(
                                          title: new Text(
                                            item.groupText,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: item.value,
                                          activeColor:
                                              ColorConstants.cepColorBackground,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              item.value = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    divider15,
                                    CardWithMultipleCheckbox(
                                      title: "Tham quan mô hình nghề hiệu quả",
                                      height: 480,
                                      children: listSightseeingOccupationModel
                                          .map((item) {
                                        return new CheckboxListTile(
                                          title: new Text(
                                            item.groupText,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: item.value,
                                          activeColor:
                                              ColorConstants.cepColorBackground,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              item.value = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    divider15,
                                    CardWithMultipleCheckbox(
                                      title: "Hội thảo hỗ trợ kỹ thuật",
                                      height: 280,
                                      children: listEngineerSupportSeminar
                                          .map((item) {
                                        return new CheckboxListTile(
                                          title: new Text(
                                            item.groupText,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: item.value,
                                          activeColor:
                                              ColorConstants.cepColorBackground,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              item.value = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    divider15,
                                    CardWithMultipleCheckbox(
                                      title: "SCC",
                                      height: 280,
                                      children: listSCC.map((item) {
                                        return new CheckboxListTile(
                                          title: new Text(
                                            item.groupText,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: item.value,
                                          activeColor:
                                              ColorConstants.cepColorBackground,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              item.value = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    divider15,
                                    CardWithMultipleCheckbox(
                                      title: "IECD",
                                      height: 80,
                                      children: listIECD.map((item) {
                                        return new CheckboxListTile(
                                          title: new Text(
                                            item.groupText,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: item.value,
                                          activeColor:
                                              ColorConstants.cepColorBackground,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              item.value = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    divider15,
                                    CardWithMultipleCheckbox(
                                      title: "REACH",
                                      height: 140,
                                      children: listREACH.map((item) {
                                        return new CheckboxListTile(
                                          title: new Text(
                                            item.groupText,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          value: item.value,
                                          activeColor:
                                              ColorConstants.cepColorBackground,
                                          checkColor: Colors.white,
                                          onChanged: (bool value) {
                                            setState(() {
                                              item.value = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                divider15,
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        // Provide an optional curve to make the animation feel smoother.
                        curve: Curves.easeOut,
                        height: 40,
                        padding: EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isInsurance) {
                                isCollapseInsurance = !isCollapseInsurance;
                                if (isCollapseInsurance == true) {
                                  //isShowContainerScholarshipAndGift = selectedIndexScholarshipAndGift == 1 ? true :false;
                                  _controllerRotateIconInsurance.forward();
                                  _controllerFadeTransitionInsurance.forward();
                                } else {
                                  _controllerRotateIconInsurance.reverse();
                                  _controllerFadeTransitionInsurance.reverse();
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 40,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (!isInsurance) {
                                              _controllerRotateIconInsurance
                                                  .reset();
                                              _controllerFadeTransitionInsurance
                                                  .forward();
                                            } else {
                                              isCollapseInsurance = false;
                                              isShowContainerScholarshipAndGift =
                                                  false;
                                              _controllerFadeTransitionInsurance
                                                  .reverse();
                                            }
                                            isInsurance = !isInsurance;
                                          });
                                        },
                                        child: Container(
                                          width: 80,
                                          margin: EdgeInsets.only(bottom: 30),
                                          child: CheckboxListTile(
                                            checkColor: Colors.white,
                                            activeColor: Colors.blue,
                                            value: isInsurance,
                                            onChanged: (newValue) {},
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: AnimatedDefaultTextStyle(
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: isInsurance
                                                  ? Colors.red
                                                  : Colors.blue,
                                              fontWeight: FontWeight.bold),

                                          duration: Duration(milliseconds: 500),
                                          // Provide an optional curve to make the animation feel smoother.
                                          curve: Curves.easeOut,
                                          child: Text(
                                            "Bảo Hiểm Y Tế",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  // Provide an optional curve to make the animation feel smoother.
                                  curve: Curves.easeOut,
                                  opacity: !isInsurance ? 0 : 1,
                                  child: AnimatedBuilder(
                                    animation: _controllerRotateIconInsurance,
                                    builder: (_, child) {
                                      return Transform.rotate(
                                        angle: _controllerRotateIconInsurance
                                                .value *
                                            1 *
                                            math.pi,
                                        child: child,
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedSize(
                        vsync: this,
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeTransition(
                          opacity: _animationFadeTransitionInsurance,
                          child: Column(
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1500),
                                curve: Curves.fastOutSlowIn,
                                height: isCollapseInsurance == true ? 430 : 0,
                                color: Colors.white,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.6,
                                            child: Text(
                                              "Mức phí bảo hiểm",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: TextField(
                                              style: textStyleTextFieldCEP,
                                              controller:
                                                  _controllerInsuranceFees,
                                              decoration:
                                                  inputDecorationTextFieldCEP(
                                                      "Nhập số tiền...",
                                                      suffixText: "VNĐ"),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                CurrencyInputFormatter(),
                                              ], // Only numbers can be entered
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              "Điều kiện tiếp cận dịch vụ BHYT",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: CustomDropdown(
                                              dropdownMenuItemList:
                                                  _conditionToHaveInsuranceServiceModelDropdownList,
                                              onChanged: (value) {
                                                setState(() {
                                                  _conditionToHaveInsuranceServiceValue =
                                                      value;
                                                });
                                              },
                                              value:
                                                  _conditionToHaveInsuranceServiceValue,
                                              width: screenWidth * 1,
                                              isEnabled: true,
                                              isUnderline: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              "Tình trạng sức khỏe của khách hàng và người thân",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: CustomDropdown(
                                              dropdownMenuItemList:
                                                  _customerStatusHealthModelDropdownList,
                                              onChanged: (value) {
                                                setState(() {
                                                  _customerStatusHealthValue =
                                                      value;
                                                });
                                              },
                                              value: _customerStatusHealthValue,
                                              width: screenWidth * 1,
                                              isEnabled: true,
                                              isUnderline: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.38,
                                          child: Text(
                                            "Họ & tên người thân",
                                            style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 40,
                                            child: TextField(
                                              controller:
                                                  _controllerFullNameOfRelativeForInsurance,
                                              style: textStyleTextFieldCEP,
                                              decoration:
                                                  inputDecorationTextFieldCEP(
                                                      "Nhập..."),
                                              keyboardType: TextInputType.text,
                                              // Only numbers can be entered
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    divider15,
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              "Quan hệ với khách hàng",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            child: CustomDropdown(
                                              dropdownMenuItemList:
                                                  _relationsWithCustomersForInsuranceModelDropdownList,
                                              onChanged: (value) {
                                                setState(() {
                                                  _relationsWithCustomersForInsuranceValue =
                                                      value;
                                                });
                                              },
                                              value:
                                                  _relationsWithCustomersForInsuranceValue,
                                              width: screenWidth * 1,
                                              isEnabled: true,
                                              isUnderline: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    divider15,
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.38,
                                            child: Text(
                                              "Năm sinh",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              child: CustomDropdown(
                                                dropdownMenuItemList:
                                                    _birthOfYearInsuranceModelDropdownList,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _birthOfYearInsuranceValue =
                                                        value;
                                                  });
                                                },
                                                value:
                                                    _birthOfYearInsuranceValue,
                                                width: screenWidth * 1,
                                                isEnabled: true,
                                                isUnderline: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            mini: true,
            onPressed: _scrollToTop,
            child: Icon(Icons.arrow_upward),
          ),
        ),
      );

  Widget customRadioIsOfficerInFamily(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndexIsOfficerInFamily(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color: selectedIndexIsOfficerInFamily == index
              ? ColorConstants.cepColorBackground
              : Colors.grey),
      child: Text(
        txt,
        style: TextStyle(
            color: selectedIndexIsOfficerInFamily == index
                ? ColorConstants.cepColorBackground
                : Colors.grey),
      ),
    );
  }

  Widget customRadioCareerModel(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndexCareerModel(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color: selectedIndexCareerModel == index
              ? ColorConstants.cepColorBackground
              : Colors.grey),
      child: Text(
        txt,
        style: TextStyle(
            color: selectedIndexCareerModel == index
                ? ColorConstants.cepColorBackground
                : Colors.grey),
      ),
    );
  }

  Widget customRadioScholarshipAndGift(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndexScholarshipAndGift(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color: selectedIndexScholarshipAndGift == index
              ? ColorConstants.cepColorBackground
              : Colors.grey),
      child: Text(
        txt,
        style: TextStyle(
            color: selectedIndexScholarshipAndGift == index
                ? ColorConstants.cepColorBackground
                : Colors.grey),
      ),
    );
  }

  Widget customRadioGetScholarshipSomeYearsAgo(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndexGetScholarshipSomeYearsAgo(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color: selectedIndexGetScholarshipSomeYearsAgo == index
              ? ColorConstants.cepColorBackground
              : Colors.grey),
      child: Text(
        txt,
        style: TextStyle(
            color: selectedIndexGetScholarshipSomeYearsAgo == index
                ? ColorConstants.cepColorBackground
                : Colors.grey),
      ),
    );
  }

  Widget customRadioGetConfirmBuild(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndexGetConfirmBuild(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color: selectedIndexGetConfirmBuild == index
              ? ColorConstants.cepColorBackground
              : Colors.grey),
      child: Text(
        txt,
        style: TextStyle(
            color: selectedIndexGetConfirmBuild == index
                ? ColorConstants.cepColorBackground
                : Colors.grey),
      ),
    );
  }

  buildTimetoUseLoanPicker(
      BuildContext context, DateTime selectedDateTime) async {
    DateTime picked = await showDateTime(selectedDateTime);
    if (picked != null) {
      setState(() {
        selectedTimetoUseLoanDate = picked;
      });
    }
  }

  Future<DateTime> showDateTime(DateTime selectedDate) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),

      //  initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.year,
      // selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Chọn ngày',
      cancelText: 'Hủy',
      confirmText: 'Chọn',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Chọn ngày',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    return picked;
  }

  onTotalAmountForRoof() {
    totalAmount = MoneyFormat.convertCurrencyToInt(
            _controllerAmountProposeCEPSupport.text) +
        MoneyFormat.convertCurrencyToInt(_controllerAmountFamilySupport.text) +
        MoneyFormat.convertCurrencyToInt(_controllerAmountSaving.text) +
        MoneyFormat.convertCurrencyToInt(_controllerAmountLoan.text);
    print("1");
  }

  Future<bool> _onWillPop() {
    return dialogCustomForCEP(
        context, "Bạn muốn thoát khỏi màn hình này ?", navigationTrue,
        children: [], width: screenWidth * 0.7);
  }

  navigationTrue() {
    Navigator.of(context).pop(true);
  }
}
