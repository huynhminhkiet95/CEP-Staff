import 'dart:async';
import 'dart:ui';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_widgets/bloc_state_builder.dart';
import 'package:qr_code_demo/blocs/survey/survey_state.dart';
import 'package:qr_code_demo/config/colors.dart';
import 'package:qr_code_demo/config/formatdate.dart';
import 'package:qr_code_demo/config/moneyformat.dart';
import 'package:qr_code_demo/models/community_development/comunity_development.dart';
import 'package:qr_code_demo/models/download_data/comboboxmodel.dart';
import 'package:qr_code_demo/services/helper.dart';
import 'package:qr_code_demo/ui/components/CardCustomWidget.dart';
import 'package:qr_code_demo/ui/components/CustomDialog.dart';
import 'package:qr_code_demo/ui/components/ModalProgressHUDCustomize.dart';
import 'package:qr_code_demo/ui/components/dropdown.dart';
import 'package:qr_code_demo/ui/screens/survey/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/config/CustomIcons/my_flutter_app_icons.dart';
import 'package:qr_code_demo/services/service.dart';
import 'package:qr_code_demo/blocs/survey/survey_bloc.dart';
import 'package:qr_code_demo/blocs/survey/survey_event.dart';
import 'package:qr_code_demo/models/download_data/survey_info.dart';
import 'package:qr_code_demo/models/download_data/survey_info_history.dart';
import 'package:qr_code_demo/resources/CurrencyInputFormatter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SurveyDetailFakeScreen extends StatefulWidget {
  const SurveyDetailFakeScreen({
    Key key,
  }) : super(key: key);

  @override
  _SurveyDetailFakeScreenState createState() => _SurveyDetailFakeScreenState();
}

class _SurveyDetailFakeScreenState extends State<SurveyDetailFakeScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> formkeySurveyDetail = GlobalKey<FormState>();
  TabController tabController;

  double screenWidth, screenHeight;
  SurveyBloc surVeyBloc;
  Services services;
  int selectedIndexKhuVuc;
  int selectedIndexTotalMonthly = 0;
  int selectedIndexTimeOfWithdrawal = 0;

  ///
  List<DropdownMenuItem<String>> _surveyRespondentsModelDropdownList;
  List<DropdownMenuItem<String>> _maritalStatusModelDropdownList;
  List<DropdownMenuItem<String>> _educationLevelModelDropdownList;
  List<DropdownMenuItem<String>> _ownershipModelDropdownList;
  List<DropdownMenuItem<String>> _roofModelDropdownList;
  List<DropdownMenuItem<String>> _wallModelDropdownList;
  List<DropdownMenuItem<String>> _floorModelDropdownList;
  List<DropdownMenuItem<String>> _powerModelDropdownList;
  List<DropdownMenuItem<String>> _waterModelDropdownList;
  List<DropdownMenuItem<String>> _capitalModelDropdownList;
  List<DropdownMenuItem<String>> _reasonLoanModelDropdownList;
  List<DropdownMenuItem<String>> _uniformMeasuresModelDropdownList;
  List<DropdownMenuItem<String>> _typeMemberModelDropdownList;
  List<DropdownMenuItem<String>> _additionalLoanPurposeModelDropdownList;
  List<DropdownMenuItem<String>> _loanPurposeModelDropdownList;

  String _surveyRespondentsValue;
  String _maritalStatusValue;
  String _educationLevelValue;
  String _ownershipValue;
  String _roofValue;
  String _wallValue;
  String _floorValue;
  String _powerValue;
  String _waterValue;
  String _capital1Value;
  String _capital2Value;
  String _reasonLoan1Value;
  String _reasonLoan2Value;
  String _uniformMeasure1Value;
  String _uniformMeasure2Value;
  String _typeMemberValue;
  String _additionalLoanPurposeValue;
  String _loanPurposeValue;

  DateTime selectedSurveyDate;
  DateTime selectedTimetoUseLoanDate;
  DateTime selectedTimeOfWithdrawalDate;
  DateTime selectedFinalSettlement1Date;
  DateTime selectedFinalSettlement2Date;
  DateTime selectedDateofAdditionalCapital;

  TextEditingController _controllerNumberPeopleInFamily =
      new TextEditingController(text: "");
  TextEditingController _controllerNumberPeopleWorked =
      new TextEditingController(text: "");
  TextEditingController _controllerAmountOfLaborTools =
      new TextEditingController(text: "");
  TextEditingController _controllerAmountOfVehiclesTransport =
      new TextEditingController(text: "");
  TextEditingController _controllerAmountLivingEquipment =
      new TextEditingController(text: "");
  TextEditingController _controllerNumberOfAlleyNearHome =
      new TextEditingController(text: "");
  TextEditingController _controllerAcreageOfHome =
      new TextEditingController(text: "");
  TextEditingController _controllerPurposeUseMoney =
      new TextEditingController(text: "");
  TextEditingController _controllerAmountRequiredForCapitalUsePurposes =
      new TextEditingController(text: "");
  TextEditingController _controllerAmountMemberHave =
      new TextEditingController(text: "");
  TextEditingController _controllerAmountMemberNeed =
      new TextEditingController(text: "");
  TextEditingController _controllerTotalAmountGetSeason =
      new TextEditingController(text: "");
  TextEditingController _controllerTotalAmountMonthlyforActivityIncomeIncrease =
      new TextEditingController(text: "");
  TextEditingController _controllerIncomeOfWifeHusband =
      new TextEditingController(text: "");
  TextEditingController _controllerIncomeOfChild =
      new TextEditingController(text: "");
  TextEditingController _controllerIncomeOther =
      new TextEditingController(text: "");
  // TextEditingController _controllerMonthlyExpenses = new TextEditingController(text: "");
  TextEditingController _controllerTotalMonthlyExpenses =
      new TextEditingController(text: "");
  TextEditingController _controllerTotalPowerAndWater =
      new TextEditingController(text: "");
  TextEditingController _controllerTotalCharge =
      new TextEditingController(text: ""); // phi an uong
  TextEditingController _controllerTotalFee =
      new TextEditingController(text: ""); // phi hoc tap
  TextEditingController _controllerTotalOtherCost =
      new TextEditingController(text: ""); // phi khac
  TextEditingController _controllerCostofLoanRepaymentToCEPMonthly =
      new TextEditingController(text: "");
  TextEditingController _controllerMonthlyBalanceUseCapital =
      new TextEditingController(text: "");
  TextEditingController _controllerTotalAmountCapital1 =
      new TextEditingController(text: "");
  TextEditingController _controllerTotalAmountCapital2 =
      new TextEditingController(text: "");
  TextEditingController _controllerPoorHouseholdsCode =
      new TextEditingController(text: "");
  TextEditingController _controllerNameofHouseholdHead =
      new TextEditingController(text: "");
  TextEditingController _controllerSavingsDepositAmountEverytime =
      new TextEditingController(text: "");
  TextEditingController _controllerRequiredDeposit =
      new TextEditingController(text: "");
  TextEditingController _controllerOrientationDeposit =
      new TextEditingController(text: "");
  TextEditingController _controllerFlexibleDeposit =
      new TextEditingController(text: "");
  TextEditingController _controllerAmountAdditionalLoan =
      new TextEditingController(text: "");
  TextEditingController _controllerCreditOfficerNotes =
      new TextEditingController(text: "");
  TextEditingController _controllerDisbursementAmount =
      new TextEditingController(text: "");
  TextEditingController _controllerDisbursementAmountOrientationDeposit =
      new TextEditingController(text: "");

  TextEditingController _textDateEditingController = TextEditingController(
      text: FormatDateConstants.convertDateTimeToString(DateTime.now()));
  List<ComboboxModel> listCombobox;
  double _animatedHeight1 = 0.0;
  double _animatedHeight2 = 0.0;
  double _animatedHeightCapital1 = 0.0;
  double _animatedHeightCapital2 = 0.0;
  double _animatedHeightTimeOfWithdrawal = 0.0;
  bool isDataHistory = false;
  SurveyInfoHistory surveyInfoHistory;
  // DateTime _selectDate(BuildContext context, DateTime selectedDate) {
  //   final ThemeData theme = Theme.of(context);
  //   assert(theme.platform != null);
  //   switch (theme.platform) {
  //     case TargetPlatform.android:
  //     case TargetPlatform.fuchsia:
  //     case TargetPlatform.linux:
  //     case TargetPlatform.windows:
  //       return buildMaterialDatePicker(context, selectedDate);
  //     //return buildCupertinoDatePicker(context);
  //     case TargetPlatform.iOS:
  //     case TargetPlatform.macOS:
  //       return buildCupertinoDatePicker(context);
  //   }
  // }
  selectedChangeNguonVay1(String value) {
    setState(() {
      _capital1Value = value;
      if (value != "0" && value != "00")
        _animatedHeightCapital1 = 280;
      else
        _animatedHeightCapital1 = 0;
    });
  }

  selectedChangeNguonVay2(String value) {
    setState(() {
      _capital2Value = value;
      if (value != "0" && value != "00")
        _animatedHeightCapital2 = 280;
      else
        _animatedHeightCapital2 = 0;
    });
  }

  Future<DateTime> showDateTime(DateTime selectedDate) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      //selectableDayPredicate: _decideWhichDayToEnable,
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

  buildSurveyDatePicker(BuildContext context, DateTime selectedDateTime) async {
    DateTime picked = await showDateTime(selectedDateTime);
    if (picked != null) {
      setState(() {
        selectedSurveyDate = picked;
      });
    }
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

  buildTimeOfWithdrawalPicker(
      BuildContext context, DateTime selectedDateTime) async {
    DateTime picked = await showDateTime(selectedDateTime);
    if (picked != null) {
      setState(() {
        selectedTimeOfWithdrawalDate = picked;
      });
    }
  }

  buildFinalSettlement1Picker(
      BuildContext context, DateTime selectedDateTime) async {
    DateTime picked = await showDateTime(selectedDateTime);
    if (picked != null) {
      setState(() {
        selectedFinalSettlement1Date = picked;
      });
    }
  }

  buildFinalSettlement2Picker(
      BuildContext context, DateTime selectedDateTime) async {
    DateTime picked = await showDateTime(selectedDateTime);
    if (picked != null) {
      setState(() {
        selectedFinalSettlement2Date = picked;
      });
    }
  }

  buildDateofAdditionalCapitalPicker(
      BuildContext context, DateTime selectedDateTime) async {
    DateTime picked = await showDateTime(selectedDateTime);
    if (picked != null) {
      setState(() {
        selectedDateofAdditionalCapital = picked;
      });
    }
  }

  // buildCupertinoDatePicker(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext builder) {
  //         return Container(
  //           height: MediaQuery.of(context).copyWith().size.height / 3,
  //           color: Colors.blue,
  //           child: CupertinoDatePicker(
  //             backgroundColor: Colors.white,
  //             use24hFormat: true,
  //             mode: CupertinoDatePickerMode.date,
  //             onDateTimeChanged: (picked) {
  //               if (picked != null && picked != selectedDate)
  //                 setState(() {
  //                   selectedDate = picked;
  //                 });
  //             },
  //             initialDateTime: selectedDate,
  //             minimumYear: 2000,
  //             maximumYear: 2025,
  //           ),
  //         );
  //       });
  // }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    listCombobox = globalUser.getListComboboxModel;
    tabController = new TabController(length: 5, vsync: this);
    tabController.addListener(() {
      if (_controllerDisbursementAmountOrientationDeposit.text.isEmpty) {
        _controllerDisbursementAmountOrientationDeposit.text =
            _controllerSavingsDepositAmountEverytime.text;
      }
    });

    if (surveyInfoHistory != null) {
      this.isDataHistory = true;
    }
    loadInitData();
    services = Services.of(context);
    surVeyBloc =
        new SurveyBloc(services.sharePreferenceService, services.commonService);
    //surVeyBloc.emitEvent(LoadSurveyEvent());
    super.initState();
  }

  void _onSubmit() {
    //surVeyBloc.emitEvent(UpdateSurveyEvent(model, context));
  }

  void loadInitData() {
    SurveyInfo surveyInfo = new SurveyInfo();
    List<SurveyInfoHistory> listSurveyHistory;
    // khu vuc
    selectedIndexKhuVuc = surveyInfo.khuVuc;

    /// nguoi tra loi khao sat
    _surveyRespondentsModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'NguoiTraloiKhaosat').toList());
    _surveyRespondentsValue = surveyInfo.nguoiTraloiKhaoSat == null
        ? "0"
        : surveyInfo.nguoiTraloiKhaoSat;

    /// tinh trang hon nhan
    _maritalStatusModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'TinhTrangHonNhan').toList());
    _maritalStatusValue =
        surveyInfo.tinhTrangHonNhan == null ? "0" : surveyInfo.tinhTrangHonNhan;

    ///trinh do hoc van
    _educationLevelModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'TrinhDoHocVan').toList());
    _educationLevelValue = surveyInfo.trinhDoHocVan == null
        ? "0"
        : surveyInfo.trinhDoHocVan.trim();

    /// quyen so huu
    _ownershipModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'SoHuuNha').toList());
    _ownershipValue = surveyInfo.quyenSoHuuNha == null
        ? "0"
        : surveyInfo.quyenSoHuuNha.trim();

    ///mai nha
    _roofModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'MaiNha').toList());
    _roofValue = surveyInfo.maiNha == null ? "0" : surveyInfo.maiNha.trim();

    ///tuong nha
    _wallModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'TuongNha').toList());
    _wallValue = surveyInfo.tuongNha == null ? "0" : surveyInfo.tuongNha.trim();

    ///nen nha
    _floorModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'NenNha').toList());
    _floorValue = surveyInfo.nenNha == null ? "0" : surveyInfo.nenNha.trim();

    ///dien
    _powerModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'Dien').toList());
    _powerValue = surveyInfo.dien == null ? "0" : surveyInfo.dien.trim();

    ///nuoc
    _waterModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'Nuoc').toList());
    _waterValue = surveyInfo.nuoc == null ? "0" : surveyInfo.nuoc.trim();

    ///nguon vay 1
    _capitalModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'NguonVay').toList());
    _capital1Value =
        surveyInfo.nguonVay1 == null ? "0" : surveyInfo.nguonVay1.trim();
    _capital2Value =
        surveyInfo.nguonVay2 == null ? "0" : surveyInfo.nguonVay2.trim();

    ///ly do vay
    _reasonLoanModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'LyDoVay').toList());
    _reasonLoan1Value =
        surveyInfo.lyDoVay1 == null ? "0" : surveyInfo.lyDoVay1.trim();
    _reasonLoan2Value =
        surveyInfo.lyDoVay2 == null ? "0" : surveyInfo.lyDoVay2.trim();

    ///bien phap thong nhat
    _uniformMeasuresModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'BienPhapThongNhat').toList());
    _uniformMeasure1Value = surveyInfo.bienPhapThongNhat1 == null
        ? "0"
        : surveyInfo.bienPhapThongNhat1.trim();
    _uniformMeasure2Value = surveyInfo.bienPhapThongNhat2 == null
        ? "0"
        : surveyInfo.bienPhapThongNhat2.trim();

    //thanh vien thuoc dien
    _typeMemberModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'ThanhVienThuocDien').toList());
    _typeMemberValue = surveyInfo.thanhVienThuocDien == null
        ? "0"
        : surveyInfo.thanhVienThuocDien.trim();

    ///muc dich vay von bo sung
    _additionalLoanPurposeModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'MucDich').toList());
    _additionalLoanPurposeValue = surveyInfo.mucDichVayBoSung == null
        ? "0"
        : surveyInfo.mucDichVayBoSung.trim();

    ///muc dich vay von
    _loanPurposeModelDropdownList = Helper.buildDropdownFromMetaData(
        listCombobox.where((e) => e.groupId == 'MucDich').toList());
    _loanPurposeValue = "0";

    selectedSurveyDate = null;

    selectedTimetoUseLoanDate = null;

    selectedFinalSettlement1Date = null;

    selectedFinalSettlement2Date = null;

    selectedTimeOfWithdrawalDate = null;

    selectedDateofAdditionalCapital = null;

    _controllerNumberPeopleInFamily = new TextEditingController(text: '0');

    _controllerNumberPeopleWorked = new TextEditingController(text: '0');

    _controllerAmountOfLaborTools.text = null;

    _controllerAmountOfVehiclesTransport.text = null;

    _controllerAmountLivingEquipment.text = null;

    _controllerNumberOfAlleyNearHome = null;

    _controllerAcreageOfHome = new TextEditingController(text: '0');

    _controllerPurposeUseMoney = new TextEditingController(text: '0');

    _controllerAmountRequiredForCapitalUsePurposes.text =
        MoneyFormat.moneyFormat(surveyInfo.soTienCanThiet
            .toString()); // maybe so tien can cho muc dich su dung von

    _controllerAmountMemberHave = new TextEditingController(
        text:
            MoneyFormat.moneyFormat(surveyInfo.soTienThanhVienDaCo.toString()));

    _controllerAmountMemberNeed = new TextEditingController(
        text: MoneyFormat.moneyFormat(surveyInfo.soTienCanVay.toString()));

    _controllerTotalAmountGetSeason = new TextEditingController(
        text: MoneyFormat.moneyFormat(surveyInfo.tongVonDauTu.toString()));

    _controllerTotalAmountMonthlyforActivityIncomeIncrease =
        new TextEditingController(
            text: MoneyFormat.moneyFormat(
                surveyInfo.thuNhapRongHangThang.toString()));

    _controllerIncomeOfWifeHusband = new TextEditingController(
        text: MoneyFormat.moneyFormat(surveyInfo.thuNhapCuaVoChong.toString()));

    _controllerIncomeOfChild = new TextEditingController(
        text: MoneyFormat.moneyFormat(surveyInfo.thuNhapCuaCacCon.toString()));

    _controllerIncomeOther = new TextEditingController(
        text: MoneyFormat.moneyFormat(surveyInfo.thuNhapKhac.toString()));

    _controllerTotalMonthlyExpenses = new TextEditingController(
        text: MoneyFormat.moneyFormat(
            surveyInfo.tongChiPhiCuaThanhvien.toString()));
    _controllerTotalPowerAndWater = new TextEditingController(
        text: MoneyFormat.moneyFormat(surveyInfo.chiPhiDienNuoc.toString()));
    _controllerTotalCharge = new TextEditingController(
        text: MoneyFormat.moneyFormat(surveyInfo.chiPhiAnUong.toString()));
    _controllerTotalFee = new TextEditingController(
        text: MoneyFormat.moneyFormat(surveyInfo.chiPhiHocTap.toString()));
    _controllerTotalOtherCost = new TextEditingController(
        text: MoneyFormat.moneyFormat(surveyInfo.chiPhiKhac.toString()));
    _controllerCostofLoanRepaymentToCEPMonthly = new TextEditingController(
        text: MoneyFormat.moneyFormat(
            surveyInfo.chiTraTienVayHangThang.toString()));
    _controllerMonthlyBalanceUseCapital = new TextEditingController(
        text: MoneyFormat.moneyFormat(
            surveyInfo.tichLuyTangThemHangThang.toString()));
    _controllerTotalAmountCapital1.text =
        MoneyFormat.moneyFormat(surveyInfo.sotienVay1.toString());

    // = new TextEditingController(text: surveyInfo.sotienVay1 == null? "": surveyInfo.sotienVay1.toString());
    _controllerTotalAmountCapital2 = new TextEditingController(
        text: surveyInfo.sotienVay2 == null
            ? ""
            : MoneyFormat.moneyFormat(surveyInfo.sotienVay2.toString()));
    _controllerPoorHouseholdsCode = new TextEditingController(
        text: surveyInfo.maSoHoNgheo == null
            ? ""
            : surveyInfo.maSoHoNgheo.toString());
    _controllerNameofHouseholdHead = new TextEditingController(
        text: surveyInfo.hoTenChuHo == null
            ? ""
            : surveyInfo.hoTenChuHo.toString());
    _controllerSavingsDepositAmountEverytime = new TextEditingController(
        text: surveyInfo.soTienGuiTietKiemMoiKy == null
            ? ""
            : MoneyFormat.moneyFormat(
                surveyInfo.soTienGuiTietKiemMoiKy.toString()));
    _controllerRequiredDeposit = new TextEditingController(
        text: surveyInfo.tietKiemBatBuocXinRut == null
            ? ""
            : MoneyFormat.moneyFormat(
                surveyInfo.tietKiemBatBuocXinRut.toString()));
    _controllerOrientationDeposit = new TextEditingController(
        text: surveyInfo.tietKiemTuNguyenXinRut == null
            ? ""
            : MoneyFormat.moneyFormat(
                surveyInfo.tietKiemTuNguyenXinRut.toString()));

    _controllerFlexibleDeposit = new TextEditingController(
        text: surveyInfo.tietKiemLinhHoatXinRut == null
            ? ""
            : MoneyFormat.moneyFormat(
                surveyInfo.tietKiemLinhHoatXinRut.toString()));

    _controllerAmountAdditionalLoan = new TextEditingController(
        text: surveyInfo.mucVayBoSung == null
            ? ""
            : MoneyFormat.moneyFormat(surveyInfo.mucVayBoSung.toString()));

    _controllerCreditOfficerNotes = new TextEditingController(
        text: surveyInfo.ghiChu == null ? "" : surveyInfo.ghiChu.toString());

    _controllerDisbursementAmount = new TextEditingController(
        text: surveyInfo.soTienDuyetChovay == null
            ? ""
            : MoneyFormat.moneyFormat(surveyInfo.soTienDuyetChovay.toString()));

    _controllerDisbursementAmountOrientationDeposit = new TextEditingController(
        text: surveyInfo.tietKiemDinhHuong == null
            ? ""
            : MoneyFormat.moneyFormat(surveyInfo.tietKiemDinhHuong.toString()));

    if (surveyInfo.tongChiPhiCuaThanhvien == 0)
      selectedIndexTotalMonthly = 1;
    else
      selectedIndexTotalMonthly = 0;

    if (surveyInfo.thoiDiemRut == "") {
      selectedIndexTimeOfWithdrawal = 0;
    } else {
      selectedIndexTimeOfWithdrawal = 1;
    }
    selectedChangeNguonVay1(_capital1Value);
    selectedChangeNguonVay2(_capital2Value);
    changeIndexTotalMonthlyRadioButton(selectedIndexTotalMonthly);
    changeIndexTimeOfWithdrawalRadioButton(selectedIndexTimeOfWithdrawal);
  }

  _onChangeSurveyRespondentsModelDropdown(String surveyRespondentsModel) {
    setState(() {
      _surveyRespondentsValue = surveyRespondentsModel;
    });
  }

  _onChangeMaritalStatusModelDropdown(String maritalStatusModel) {
    setState(() {
      _maritalStatusValue = maritalStatusModel;
    });
  }

  _onChangeEducationLevelModelDropdown(String educationLevelModel) {
    setState(() {
      _educationLevelValue = educationLevelModel;
    });
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndexKhuVuc = index;
    });
  }

  void changeIndexTotalMonthlyRadioButton(int index) {
    setState(() {
      selectedIndexTotalMonthly = index;
      if (index == 1) {
        _animatedHeight1 = 0;
        _animatedHeight2 = 270;
      } else {
        _animatedHeight1 = 60;
        _animatedHeight2 = 0;
      }
    });
  }

  void changeIndexTimeOfWithdrawalRadioButton(int index) {
    setState(() {
      selectedIndexTimeOfWithdrawal = index;
      if (index == 1) {
        _animatedHeightTimeOfWithdrawal = 60;
      } else {
        _animatedHeightTimeOfWithdrawal = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    List<String> listTypeArea = [
      'Thành thị',
      'Nông thôn',
    ];

    List<String> listTypeOfTotalMonth = [
      'Người trả lời biết tổng chi phí',
      'Người trả lời không biết tổng chi phí',
    ];

    List<String> listTimeOfWithdrawal = [
      'Cuối kỳ',
      'Khác, cụ thể',
    ];
    return DefaultTabController(
        length: 5,
        child: BlocEventStateBuilder<SurveyState>(
            bloc: surVeyBloc,
            builder: (BuildContext context, SurveyState state) {
              return new Scaffold(
                appBar: new AppBar(
                  centerTitle: true,
                  leading: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context, false);
                      }),
                  actions: [
                    IconButton(
                        icon: Icon(
                          Icons.save_alt_sharp,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () {
                          validationForm();
                        })
                  ],
                  backgroundColor: ColorConstants.cepColorBackground,
                  title: new Text("Cập Nhật Thông Tin Khảo Sát",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  bottom: PreferredSize(
                      child: TabBar(
                          controller: tabController,
                          isScrollable: true,
                          unselectedLabelColor: Colors.indigo.shade200,
                          indicatorColor: Colors.red,
                          labelColor: Colors.white,
                          tabs: [
                            Tab(
                              child: Column(
                                children: [
                                  Center(
                                    child: Icon(Icons.info),
                                  ),
                                  Center(
                                      child: Text(
                                    'Thông Tin',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                            ),
                            Tab(
                              child: Column(
                                children: [
                                  Center(
                                    child: Icon(IconsCustomize.loan),
                                  ),
                                  Center(
                                      child: Text(
                                    'Vay Lần 1',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                            ),
                            Tab(
                              child: Column(
                                children: [
                                  Center(
                                    child: Icon(Icons.money),
                                  ),
                                  Center(
                                      child: Text(
                                    'Nhu Cầu Vốn',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                            ),
                            Tab(
                              child: Column(
                                children: [
                                  Center(
                                    child: Icon(IconsCustomize.networking),
                                  ),
                                  Center(
                                      child: Text(
                                    'Vay Nguồn Khác',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                            ),
                            Tab(
                              child: Column(
                                children: [
                                  Center(
                                    child: Icon(IconsCustomize.survey_icon),
                                  ),
                                  Center(
                                      child: Text(
                                    'Đánh Giá',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                            ),
                          ]),
                      preferredSize: Size.fromHeight(30.0)),
                ),
                body: Form(
                  key: formkeySurveyDetail,
                  child: ModalProgressHUDCustomize(
                    inAsyncCall: state.isLoading,
                    child: new TabBarView(
                      controller: tabController,
                      children: <Widget>[
                        /// THÔNG TIN PAGE ///
                        new Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                new Center(
                                  child: Text(
                                    "Thông Tin Thành Viên",
                                    style: TextStyle(
                                        color: Color(0xff003399),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: new Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Thành Viên:",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                            VerticalDivider(
                                              width: 10,
                                            ),
                                            Text(
                                              globalUser.getUserInfo.hoTen,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Giới Tính:",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "Nam",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "- Năm Sinh:",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "- CMND:",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Địa chỉ:",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                            VerticalDivider(
                                              width: 10,
                                            ),
                                            Text(
                                              '',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Tham gia từ:",
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            VerticalDivider(
                                              width: 100,
                                            ),
                                            Text(
                                              "Vay lần 1",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.42,
                                              child: Text(
                                                "Khu vực",
                                                style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            customRadio(listTypeArea[0], 1),
                                            VerticalDivider(
                                              width: 10,
                                            ),
                                            customRadio(listTypeArea[1], 0),
                                          ],
                                        ),
                                        Divider(
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.42,
                                              child: Text(
                                                "Người trả lời khảo sát",
                                                style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            CustomDropdown(
                                              dropdownMenuItemList:
                                                  _surveyRespondentsModelDropdownList,
                                              onChanged:
                                                  _onChangeSurveyRespondentsModelDropdown,
                                              value: _surveyRespondentsValue,
                                              width: screenWidth * 0.5,
                                              isEnabled: true,
                                              isUnderline: false,
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.42,
                                              child: Text(
                                                "Tình trạng hôn nhân",
                                                style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            CustomDropdown(
                                              dropdownMenuItemList:
                                                  _maritalStatusModelDropdownList,
                                              onChanged:
                                                  _onChangeMaritalStatusModelDropdown,
                                              value: _maritalStatusValue,
                                              width: screenWidth * 0.5,
                                              isEnabled: true,
                                              isUnderline: false,
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.42,
                                              child: Text(
                                                "Trình độ học vấn",
                                                style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            CustomDropdown(
                                              dropdownMenuItemList:
                                                  _educationLevelModelDropdownList,
                                              onChanged:
                                                  _onChangeEducationLevelModelDropdown,
                                              value: _educationLevelValue,
                                              width: screenWidth * 0.5,
                                              isEnabled: true,
                                              isUnderline: false,
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.42,
                                              child: Text(
                                                "Ngày khảo sát",
                                                style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),

                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    width: screenWidth * 0.5,
                                                    height: 40,
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 10,
                                                        left: 10,
                                                        right: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorConstants
                                                              .cepColorBackground, // set border color
                                                          width:
                                                              1.0), // set border width
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              10.0)), // set rounded corner radius
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          selectedSurveyDate !=
                                                                  null
                                                              ? "${selectedSurveyDate.toLocal()}"
                                                                  .split(' ')[0]
                                                              : "",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: ColorConstants
                                                                  .cepColorBackground),
                                                        ),
                                                        SizedBox(
                                                          width: 20.0,
                                                        ),
                                                        Icon(
                                                          Icons.calendar_today,
                                                          size: 17,
                                                          color: ColorConstants
                                                              .cepColorBackground,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    buildSurveyDatePicker(
                                                        context,
                                                        selectedSurveyDate);
                                                  },
                                                ),
                                                Builder(builder: (context) {
                                                  if (selectedSurveyDate !=
                                                      null) {
                                                    return Container();
                                                  }
                                                  return Text(
                                                      "* Trường này bắt buộc nhập !",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12));
                                                }),
                                              ],
                                            )
                                            // Text(
                                            //   "${selectedDate.toLocal()}".split(' ')[0],
                                            //   style: TextStyle(
                                            //       fontSize: 13,
                                            //       fontWeight: FontWeight.bold),
                                            // ),
                                            // SizedBox(
                                            //   height: 20.0,
                                            // ),
                                            // RaisedButton(
                                            //   onPressed: () => _selectDate(context),
                                            //   child: Icon(Icons.calendar_today),
                                            //   color: Colors.white,
                                            // ),
                                          ],
                                        ),
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: RawMaterialButton(
                                            splashColor: Colors.green,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 15,
                                                  top: 10,
                                                  left: 10,
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.qr_code,
                                                    color: Colors.white,
                                                    size: 19,
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Text(
                                                    'Cập nhật CCCD',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {},
                                            shape: const StadiumBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// /////////////////

                        /// VAY LẦN 1 PAGE ///
                        new Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                new Center(
                                  child: Text(
                                    "Thông Tin Thành Viên Vay Lần 1 Hoặc Đánh Giá Tác Động",
                                    style: TextStyle(
                                      color: Color(0xff003399),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: new Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: screenWidth * 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CardCustomizeWidget(
                                                width: screenWidth * 1,
                                                title:
                                                    "1. Thông tin về tỷ lệ phụ thuộc",
                                                children: [
                                                  Text(
                                                    "Số người trong hộ gia đình",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints(
                                                      maxHeight:
                                                          double.infinity,
                                                    ),
                                                    child: TextFormField(
                                                      controller:
                                                          _controllerNumberPeopleInFamily,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số (Người)"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return "* Bạn phải nhập trường này !";
                                                        } else
                                                          return null;
                                                      },
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Số người có việc làm",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints(
                                                      maxHeight:
                                                          double.infinity,
                                                    ),
                                                    child: TextFormField(
                                                      controller:
                                                          _controllerNumberPeopleWorked,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số (Người)"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return "* Bạn phải nhập trường này !";
                                                        } else if (int.parse(
                                                                value) >
                                                            int.parse(
                                                                _controllerNumberPeopleInFamily
                                                                    .text)) {
                                                          return "* Số người có việc làm không được lớn hơn số người trong hộ !";
                                                        } else
                                                          return null;
                                                      },
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              /// 2. Thông tin về tài sản hộ gia đình
                                              CardCustomizeWidget(
                                                title:
                                                    "2. Thông tin về tài sản hộ gia đình",
                                                width: screenWidth * 1,
                                                children: [
                                                  Text(
                                                    "Dụng cụ lao động",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      controller:
                                                          _controllerAmountOfLaborTools,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter(),
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Phương tiện đi lại",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerAmountOfVehiclesTransport,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Tài sản sinh hoạt (tivi, đầu đĩa, bàn ghế, tủ lạnh, máy giặt, bếp gas)",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerAmountLivingEquipment,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              ///3. Thông tin về điều kiện nhà ở
                                              ///
                                              CardCustomizeWidget(
                                                title:
                                                    "3. Thông tin về điều kiện nhà ở",
                                                width: screenWidth * 1,
                                                children: [
                                                  Text(
                                                    "Quyền sở hữu",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: CustomDropdown(
                                                      dropdownMenuItemList:
                                                          _ownershipModelDropdownList,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _ownershipValue =
                                                              value;
                                                        });
                                                      },
                                                      value: _ownershipValue,
                                                      width: screenWidth * 1,
                                                      isEnabled: true,
                                                      isUnderline: true,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Đường/ hẻm trước nhà",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerNumberOfAlleyNearHome,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập...",
                                                              suffixText:
                                                                  "(m2)"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Chất lượng nhà",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "- Mái nhà",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: CustomDropdown(
                                                      dropdownMenuItemList:
                                                          _roofModelDropdownList,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _roofValue = value;
                                                        });
                                                      },
                                                      value: _roofValue,
                                                      width: screenWidth * 1,
                                                      isEnabled: true,
                                                      isUnderline: true,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "- Tường",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: CustomDropdown(
                                                      dropdownMenuItemList:
                                                          _wallModelDropdownList,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _wallValue = value;
                                                        });
                                                      },
                                                      value: _wallValue,
                                                      width: screenWidth * 1,
                                                      isEnabled: true,
                                                      isUnderline: true,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "- Nền",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: CustomDropdown(
                                                      dropdownMenuItemList:
                                                          _floorModelDropdownList,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _floorValue = value;
                                                        });
                                                      },
                                                      value: _floorValue,
                                                      width: screenWidth * 1,
                                                      isEnabled: true,
                                                      isUnderline: true,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Diện tích sử dụng",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerAcreageOfHome,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số",
                                                              suffixText:
                                                                  "(m2/người)"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Điện",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: CustomDropdown(
                                                      dropdownMenuItemList:
                                                          _powerModelDropdownList,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _powerValue = value;
                                                        });
                                                      },
                                                      value: _powerValue,
                                                      width: screenWidth * 1,
                                                      isEnabled: true,
                                                      isUnderline: true,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Nước",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: CustomDropdown(
                                                      dropdownMenuItemList:
                                                          _waterModelDropdownList,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _waterValue = value;
                                                        });
                                                      },
                                                      value: _waterValue,
                                                      width: screenWidth * 1,
                                                      isEnabled: true,
                                                      isUnderline: true,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// /////////////////
                        /// NHU CẦU VỐN PAGE ///
                        new Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                new Center(
                                  child: Text(
                                    "Thông Tin Nhu Cầu Vốn Thu Nhập, Chi Phí, Tích Lũy",
                                    style: TextStyle(
                                      color: Color(0xff003399),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: new Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: screenWidth * 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CardCustomizeWidget(
                                                isShowCopyIcon: isDataHistory,
                                                children: [
                                                  Text(
                                                    "4.1 Mụch đích sử dụng vốn",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints(
                                                      maxHeight:
                                                          double.infinity,
                                                    ),
                                                    child: TextField(
                                                      maxLength: 40,
                                                      controller:
                                                          _controllerPurposeUseMoney,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập tối đa 40 ký tự",
                                                              isCounterText:
                                                                  true),
                                                      keyboardType:
                                                          TextInputType.text,
                                                      // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "4.2 Số tiền cần cho mục đích sử dụng vốn",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerAmountRequiredForCapitalUsePurposes,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "4.3 Số tiền thành viên đã có",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerAmountMemberHave,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "4.4 Số tiền thành viên cần vay",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerAmountMemberNeed,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "4.5 Thời điểm sử dụng vốn vay",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: InkWell(
                                                      child: Container(
                                                        width: screenWidth * 1,
                                                        height: 40,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 10,
                                                                left: 10,
                                                                right: 10),
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: ColorConstants
                                                                        .cepColorBackground)),
                                                            color:
                                                                Colors.white),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              selectedTimetoUseLoanDate !=
                                                                      null
                                                                  ? "${selectedTimetoUseLoanDate.toLocal()}"
                                                                      .split(
                                                                          ' ')[0]
                                                                  : "",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: ColorConstants
                                                                      .cepColorBackground),
                                                            ),
                                                            SizedBox(
                                                              width: 20.0,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .calendar_today,
                                                              size: 17,
                                                              color: ColorConstants
                                                                  .cepColorBackground,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () =>
                                                          buildTimetoUseLoanPicker(
                                                              context,
                                                              selectedTimetoUseLoanDate),
                                                    ),
                                                  ),
                                                ],
                                                title:
                                                    "4. Thông tin về nhu cầu vốn",
                                                width: screenWidth * 1,
                                                onTap: () {
                                                  dialogCustomForCEP(
                                                      context,
                                                      "Thông tin về nhu cầu vốn",
                                                      _copyInfoLoanDemand,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Ngày khảo sát: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              selectedSurveyDate !=
                                                                      null
                                                                  ? "${selectedSurveyDate.toLocal()}"
                                                                      .split(
                                                                          ' ')[0]
                                                                  : "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                        Divider(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                "* Mục đích sử dụng vốn: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.4,
                                                              child: Text(
                                                                surveyInfoHistory
                                                                    .mucDichSudungVon
                                                                    .trimRight()
                                                                    .trimLeft(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                "* Số tiền cần cho mục đích: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                MoneyFormat.moneyFormat(
                                                                    surveyInfoHistory
                                                                        .soTienCanThiet
                                                                        .toString()),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                "* Số tiền thành viên đã có: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                MoneyFormat.moneyFormat(
                                                                    surveyInfoHistory
                                                                        .soTienThanhVienDaCo
                                                                        .toString()),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                "* Số tiền thành viên cần vay: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                MoneyFormat.moneyFormat(
                                                                    surveyInfoHistory
                                                                        .soTienCanVay
                                                                        .toString()),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                "* Thời điểm sử dụng vốn vay: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                surveyInfoHistory
                                                                    .thoiDiemSuDungVonvay,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                      width: screenWidth * 0.9);
                                                },
                                              ),

                                              /// 4. Thông tin về thu nhập, chi phí, tích lũy hộ gia đình thành viên

                                              CardCustomizeWidget(
                                                isShowCopyIcon: isDataHistory,
                                                children: [
                                                  Text(
                                                    "5.1 Tổng số vốn đầu tư cho hoạt động tăng thu nhập/ mùa vụ",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerTotalAmountGetSeason,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "5.2 Tổng thu nhập hộ gia đình hàng tháng",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "* Thu nhập ròng háng tháng từ hoạt động tăng thu nhập/ mùa vụ",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerTotalAmountMonthlyforActivityIncomeIncrease,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "* Thu nhập chồng/vợ",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerIncomeOfWifeHusband,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "* Thu nhập con",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerIncomeOfChild,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "* Thu nhập từ nguồn khác",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerIncomeOther,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "5.3 Nhu nhập bình quân đầu người hàng tháng",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "5.4 Tổng chi phí hộ gia đình hàng tháng",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child:
                                                        customRadioTotalMonthly(
                                                            listTypeOfTotalMonth[
                                                                0],
                                                            0),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20, right: 0),
                                                    width: screenWidth * 1,
                                                    child:
                                                        new AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 320),
                                                      child: Container(
                                                        child: ListView(
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          children: [
                                                            Text(
                                                              "Người trả lời biết tổng chi phí cụ thể",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child: TextField(
                                                                controller:
                                                                    _controllerTotalMonthlyExpenses,
                                                                style:
                                                                    textStyleTextFieldCEP,
                                                                decoration: inputDecorationTextFieldCEP(
                                                                    "Nhập số tiền...",
                                                                    suffixText:
                                                                        "VNĐ"),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: [
                                                                  CurrencyInputFormatter()
                                                                ], // Only numbers can be entered
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      height: _animatedHeight1,
                                                      color: Colors.white,
                                                      width: 100.0,
                                                    ),
                                                  ),
                                                  Container(
                                                    // margin: EdgeInsets.only(top: -20),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child:
                                                        customRadioTotalMonthly(
                                                            listTypeOfTotalMonth[
                                                                1],
                                                            1),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20, right: 0),
                                                    width: screenWidth * 1,
                                                    child:
                                                        new AnimatedContainer(
                                                      //transform: ,
                                                      duration: const Duration(
                                                          milliseconds: 320),

                                                      child: ListView(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        children: [
                                                          Text(
                                                            "* Chi phí điện, nước",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            child: TextField(
                                                              controller:
                                                                  _controllerTotalPowerAndWater,
                                                              style:
                                                                  textStyleTextFieldCEP,
                                                              decoration:
                                                                  inputDecorationTextFieldCEP(
                                                                      "Nhập số tiền...",
                                                                      suffixText:
                                                                          "VNĐ"),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                CurrencyInputFormatter()
                                                              ], // Only numbers can be entered
                                                            ),
                                                          ),
                                                          Divider(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "* Chi phí ăn uống",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            child: TextField(
                                                              controller:
                                                                  _controllerTotalCharge,
                                                              style:
                                                                  textStyleTextFieldCEP,
                                                              decoration:
                                                                  inputDecorationTextFieldCEP(
                                                                      "Nhập số tiền...",
                                                                      suffixText:
                                                                          "VNĐ"),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                CurrencyInputFormatter()
                                                              ], // Only numbers can be entered
                                                            ),
                                                          ),
                                                          Divider(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "* Chi phí học tập",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            child: TextField(
                                                              controller:
                                                                  _controllerTotalFee,
                                                              style:
                                                                  textStyleTextFieldCEP,
                                                              decoration:
                                                                  inputDecorationTextFieldCEP(
                                                                      "Nhập số tiền...",
                                                                      suffixText:
                                                                          "VNĐ"),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                CurrencyInputFormatter()
                                                              ], // Only numbers can be entered
                                                            ),
                                                          ),
                                                          Divider(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "* Chi phí khác",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 40,
                                                            child: TextField(
                                                              controller:
                                                                  _controllerTotalOtherCost,
                                                              style:
                                                                  textStyleTextFieldCEP,
                                                              decoration:
                                                                  inputDecorationTextFieldCEP(
                                                                      "Nhập số tiền...",
                                                                      suffixText:
                                                                          "VNĐ"),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                CurrencyInputFormatter()
                                                              ], // Only numbers can be entered
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      height: _animatedHeight2,
                                                      color: Colors.white,

                                                      width: 100.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    "5.5 Chi phí đang trả tiền vay CEP hàng tháng (nếu có) (Khi khảo sát thành viên vay vốn bổ sung hoặc khẩn cấp)",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerCostofLoanRepaymentToCEPMonthly,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "5.6 Tích lũy hộ gia đình hàng tháng",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "5.7 Tích lũy hàng tháng dự kiến tăng thêm khi sử dụng khoản vay",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerMonthlyBalanceUseCapital,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                ],
                                                width: screenWidth * 1,
                                                onTap: () {
                                                  dialogCustomForCEP(
                                                      context,
                                                      "Thông tin về thu nhập, chi phí, tích lũy",
                                                      _copyInfoIcome,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Ngày khảo sát: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              selectedSurveyDate !=
                                                                      null
                                                                  ? "${selectedSurveyDate.toLocal()}"
                                                                      .split(
                                                                          ' ')[0]
                                                                  : "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                        Divider(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.5,
                                                              child: Text(
                                                                "* Tổng vốn đầu tư hoạt động tăng thu nhập/mùa vụ: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.2,
                                                              child: Text(
                                                                MoneyFormat.moneyFormat(
                                                                    surveyInfoHistory
                                                                        .tongVonDauTu
                                                                        .toString()),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.5,
                                                              child: Text(
                                                                "* Tổng thu nhập hàng tháng: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.2,
                                                              child: Text(
                                                                MoneyFormat.moneyFormat((surveyInfoHistory.thuNhapRongHangThang +
                                                                        surveyInfoHistory
                                                                            .thuNhapCuaVoChong +
                                                                        surveyInfoHistory
                                                                            .thuNhapCuaCacCon +
                                                                        surveyInfoHistory
                                                                            .thuNhapKhac)
                                                                    .toString()),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.5,
                                                              child: Text(
                                                                "* GDP bình quân đầu người háng tháng: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.2,
                                                              child: Text(
                                                                "0",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.5,
                                                              child: Text(
                                                                "* Tổng chi phí hàng tháng: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.2,
                                                              child: Text(
                                                                MoneyFormat.moneyFormat((surveyInfoHistory.tongChiPhiCuaThanhvien +
                                                                        surveyInfoHistory
                                                                            .chiPhiAnUong +
                                                                        surveyInfoHistory
                                                                            .chiPhiDienNuoc +
                                                                        surveyInfoHistory
                                                                            .chiPhiHocTap +
                                                                        surveyInfoHistory
                                                                            .chiPhiKhac)
                                                                    .toString()),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.5,
                                                              child: Text(
                                                                "* Chi phí trả góp hàng tháng: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.2,
                                                              child: Text(
                                                                MoneyFormat.moneyFormat(
                                                                    surveyInfoHistory
                                                                        .chiTraTienVayHangThang
                                                                        .toString()),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.5,
                                                              child: Text(
                                                                "* Tích lũy hàng tháng: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.2,
                                                              child: Text(
                                                                MoneyFormat.moneyFormat(((surveyInfoHistory.thuNhapRongHangThang +
                                                                            surveyInfoHistory
                                                                                .thuNhapCuaVoChong +
                                                                            surveyInfoHistory
                                                                                .thuNhapCuaCacCon +
                                                                            surveyInfoHistory
                                                                                .thuNhapKhac) -
                                                                        (surveyInfoHistory.tongChiPhiCuaThanhvien +
                                                                            surveyInfoHistory.chiPhiAnUong +
                                                                            surveyInfoHistory.chiPhiDienNuoc +
                                                                            surveyInfoHistory.chiPhiHocTap +
                                                                            surveyInfoHistory.chiPhiKhac))
                                                                    .toString()),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.5,
                                                              child: Text(
                                                                "* Tích lũy hàng tháng tăng thêm khi sử dụng khoản vay: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.2,
                                                              child: Text(
                                                                "0",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                      width: screenWidth * 0.9);
                                                },
                                                title:
                                                    "5. Thông tin về thu nhập, chi phí, tích lũy hộ gia đình thành viên",
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// /////////////////
                        /// /////////////////
                        /// VAY NGUỒN KHÁC PAGE ///
                        new Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                new Center(
                                  child: Text(
                                    "Thông Tin Khác",
                                    style: TextStyle(
                                      color: Color(0xff003399),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: new Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: screenWidth * 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CardCustomizeWidget(
                                                children: [
                                                  Text(
                                                    "6.1 Nguồn vay 1",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: CustomDropdown(
                                                      dropdownMenuItemList:
                                                          _capitalModelDropdownList,
                                                      onChanged: (value) {
                                                        selectedChangeNguonVay1(
                                                            value);
                                                      },
                                                      value: _capital1Value,
                                                      width: screenWidth * 1,
                                                      isEnabled: true,
                                                      isUnderline: true,
                                                    ),
                                                  ),
                                                  // Divider(
                                                  //   height: 10,
                                                  // ),
                                                  Container(
                                                    width: screenWidth * 1,
                                                    child:
                                                        new AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 320),
                                                      child: Container(
                                                        child: ListView(
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          children: [
                                                            Text(
                                                              "Số tiền",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child: TextField(
                                                                controller:
                                                                    _controllerTotalAmountCapital1,
                                                                style:
                                                                    textStyleTextFieldCEP,
                                                                decoration: inputDecorationTextFieldCEP(
                                                                    "Nhập số tiền...",
                                                                    suffixText:
                                                                        "VNĐ"),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: [
                                                                  CurrencyInputFormatter()
                                                                ], // Only numbers can be entered
                                                              ),
                                                            ),
                                                            Divider(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Lý do vay",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child:
                                                                  CustomDropdown(
                                                                dropdownMenuItemList:
                                                                    _reasonLoanModelDropdownList,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _reasonLoan1Value =
                                                                        value;
                                                                  });
                                                                },
                                                                value:
                                                                    _reasonLoan1Value,
                                                                width:
                                                                    screenWidth *
                                                                        1,
                                                                isEnabled: true,
                                                                isUnderline:
                                                                    true,
                                                              ),
                                                            ),
                                                            Divider(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Thời điểm tất toán",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child: InkWell(
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      screenWidth *
                                                                          1,
                                                                  height: 40,
                                                                  padding: EdgeInsets.only(
                                                                      top: 10,
                                                                      bottom:
                                                                          10,
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                                  decoration: BoxDecoration(
                                                                      border: Border(
                                                                          bottom: BorderSide(
                                                                              color: ColorConstants
                                                                                  .cepColorBackground)),
                                                                      color: Colors
                                                                          .white),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        selectedFinalSettlement1Date !=
                                                                                null
                                                                            ? "${selectedFinalSettlement1Date.toLocal()}".split(' ')[0]
                                                                            : "",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                ColorConstants.cepColorBackground),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            20.0,
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .calendar_today,
                                                                        size:
                                                                            17,
                                                                        color: ColorConstants
                                                                            .cepColorBackground,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                onTap: () =>
                                                                    buildFinalSettlement1Picker(
                                                                        context,
                                                                        selectedFinalSettlement1Date),
                                                              ),
                                                            ),
                                                            Divider(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Biện pháp thống nhất",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child:
                                                                  CustomDropdown(
                                                                dropdownMenuItemList:
                                                                    _uniformMeasuresModelDropdownList,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _uniformMeasure1Value =
                                                                        value;
                                                                  });
                                                                },
                                                                value:
                                                                    _uniformMeasure1Value,
                                                                width:
                                                                    screenWidth *
                                                                        1,
                                                                isEnabled: true,
                                                                isUnderline:
                                                                    true,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      height:
                                                          _animatedHeightCapital1,
                                                      color: Colors.white,
                                                      width: 100.0,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "6.2 Nguồn vay 2",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: CustomDropdown(
                                                      dropdownMenuItemList:
                                                          _capitalModelDropdownList,
                                                      onChanged: (value) {
                                                        selectedChangeNguonVay2(
                                                            value);
                                                      },
                                                      value: _capital2Value,
                                                      width: screenWidth * 1,
                                                      isEnabled: true,
                                                      isUnderline: true,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: screenWidth * 1,
                                                    child:
                                                        new AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 320),
                                                      child: Container(
                                                          child: ListView(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              children: [
                                                            Text(
                                                              "Số tiền",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child: TextField(
                                                                controller:
                                                                    _controllerTotalAmountCapital2,
                                                                style:
                                                                    textStyleTextFieldCEP,
                                                                decoration: inputDecorationTextFieldCEP(
                                                                    "Nhập số tiền...",
                                                                    suffixText:
                                                                        "VNĐ"),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: [
                                                                  CurrencyInputFormatter()
                                                                ], // Only numbers can be entered
                                                              ),
                                                            ),
                                                            Divider(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Lý do vay",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child:
                                                                  CustomDropdown(
                                                                dropdownMenuItemList:
                                                                    _reasonLoanModelDropdownList,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _reasonLoan2Value =
                                                                        value;
                                                                  });
                                                                },
                                                                value:
                                                                    _reasonLoan2Value,
                                                                width:
                                                                    screenWidth *
                                                                        1,
                                                                isEnabled: true,
                                                                isUnderline:
                                                                    true,
                                                              ),
                                                            ),
                                                            Divider(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Thời điểm tất toán",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child: InkWell(
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      screenWidth *
                                                                          1,
                                                                  height: 40,
                                                                  padding: EdgeInsets.only(
                                                                      top: 10,
                                                                      bottom:
                                                                          10,
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                                  decoration: BoxDecoration(
                                                                      border: Border(
                                                                          bottom: BorderSide(
                                                                              color: ColorConstants
                                                                                  .cepColorBackground)),
                                                                      color: Colors
                                                                          .white),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        selectedFinalSettlement2Date !=
                                                                                null
                                                                            ? "${selectedFinalSettlement2Date.toLocal()}".split(' ')[0]
                                                                            : "",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                ColorConstants.cepColorBackground),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            20.0,
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .calendar_today,
                                                                        size:
                                                                            17,
                                                                        color: ColorConstants
                                                                            .cepColorBackground,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                onTap: () =>
                                                                    buildFinalSettlement2Picker(
                                                                        context,
                                                                        selectedFinalSettlement2Date),
                                                              ),
                                                            ),
                                                            Divider(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Biện pháp thống nhất",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              child:
                                                                  CustomDropdown(
                                                                dropdownMenuItemList:
                                                                    _uniformMeasuresModelDropdownList,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    _uniformMeasure2Value =
                                                                        value;
                                                                  });
                                                                },
                                                                value:
                                                                    _uniformMeasure2Value,
                                                                width:
                                                                    screenWidth *
                                                                        1,
                                                                isEnabled: true,
                                                                isUnderline:
                                                                    true,
                                                              ),
                                                            ),
                                                          ])),
                                                      height:
                                                          _animatedHeightCapital2,
                                                      color: Colors.white,
                                                      width: 100.0,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                ],
                                                onTap:
                                                    _copyMemberLoanOtherCapital,
                                                title:
                                                    "6. Thành viên có đang vay nguồn vốn khác",
                                                width: screenWidth * 1,
                                              ),
                                              CardCustomizeWidget(
                                                isShowCopyIcon: isDataHistory,
                                                children: [
                                                  Text(
                                                    "Thành viên thuộc diện",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: CustomDropdown(
                                                      dropdownMenuItemList:
                                                          _typeMemberModelDropdownList,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _typeMemberValue =
                                                              value;
                                                        });
                                                      },
                                                      value: _typeMemberValue,
                                                      width: screenWidth * 1,
                                                      isEnabled: true,
                                                      isUnderline: true,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Mã số hộ nghèo, hộ cận nghèo",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerPoorHouseholdsCode,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập chữ và số"),
                                                      keyboardType:
                                                          TextInputType.text,
                                                      // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Tên chủ hộ",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerNameofHouseholdHead,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập chữ có dấu hoặc không dấu"),
                                                      keyboardType:
                                                          TextInputType.text,
                                                      // Only numbers can be entered
                                                    ),
                                                  ),
                                                ],
                                                onTap: () {
                                                  dialogCustomForCEP(
                                                      context,
                                                      "Thành viên thuộc diện",
                                                      _copyTypeMember,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Ngày khảo sát: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              selectedSurveyDate !=
                                                                      null
                                                                  ? "${selectedSurveyDate.toLocal()}"
                                                                      .split(
                                                                          ' ')[0]
                                                                  : "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                        Divider(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                "* Thành viên thuộc diện: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                listCombobox
                                                                    .where((e) =>
                                                                        e.groupId ==
                                                                            'ThanhVienThuocDien' &&
                                                                        e.itemId ==
                                                                            surveyInfoHistory.thanhVienThuocDien)
                                                                    .first
                                                                    .itemText,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                "* Mã số hộ nghèo: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                surveyInfoHistory
                                                                    .maSoHoNgheo
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                "* Họ tên chủ hộ: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                surveyInfoHistory
                                                                    .hoTenChuHo,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Colors
                                                                      .red,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                      width: screenWidth * 0.9);
                                                },
                                                title:
                                                    "7. Thành viên thuộc diện",
                                                width: screenWidth * 1,
                                              ),
                                              CardCustomizeWidget(
                                                //isShowCopyIcon: isDataHistory,
                                                children: [
                                                  Text(
                                                    "Số tiền gửi mỗi kỳ",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      onEditingComplete: () {
                                                        if (_controllerDisbursementAmountOrientationDeposit
                                                            .text.isEmpty) {
                                                          _controllerDisbursementAmountOrientationDeposit
                                                                  .text =
                                                              _controllerSavingsDepositAmountEverytime
                                                                  .text;
                                                        }
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                new FocusNode());
                                                      },
                                                      controller:
                                                          _controllerSavingsDepositAmountEverytime,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                ],
                                                onTap:
                                                    _copyAmountSavingsDepositAmountEverytime,
                                                title:
                                                    "8. Thành viên có tham gia gửi tiết kiệm định hướng?",
                                                width: screenWidth * 1,
                                              ),
                                              CardCustomizeWidget(
                                                children: [
                                                  Text(
                                                    "Tiết kiệm bắt buộc",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerRequiredDeposit,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Tiết kiệm định hướng",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerOrientationDeposit,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Tiết kiệm linh hoạt",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerFlexibleDeposit,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Thời điểm rút",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      customRadioTimeOfWithdrawal(
                                                          listTimeOfWithdrawal[
                                                              0],
                                                          0),
                                                      VerticalDivider(
                                                        width: 10,
                                                      ),
                                                      customRadioTimeOfWithdrawal(
                                                          listTimeOfWithdrawal[
                                                              1],
                                                          1),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: screenWidth * 1,
                                                    child:
                                                        new AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 320),
                                                      child: ListView(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        children: [
                                                          Container(
                                                            height: 40,
                                                            child: InkWell(
                                                              child: Container(
                                                                width:
                                                                    screenWidth *
                                                                        1,
                                                                height: 40,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 10,
                                                                        bottom:
                                                                            10,
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    border: Border(
                                                                        bottom: BorderSide(
                                                                            color: ColorConstants
                                                                                .cepColorBackground)),
                                                                    color: Colors
                                                                        .white),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      selectedTimeOfWithdrawalDate !=
                                                                              null
                                                                          ? "${selectedTimeOfWithdrawalDate.toLocal()}"
                                                                              .split(' ')[0]
                                                                          : "",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              ColorConstants.cepColorBackground),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          20.0,
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .calendar_today,
                                                                      size: 17,
                                                                      color: ColorConstants
                                                                          .cepColorBackground,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              onTap: () =>
                                                                  buildTimeOfWithdrawalPicker(
                                                                      context,
                                                                      selectedTimeOfWithdrawalDate),
                                                              //  onTap: () => _selectDate(context),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      height:
                                                          _animatedHeightTimeOfWithdrawal,
                                                      color: Colors.white,
                                                      width: 100.0,
                                                    ),
                                                  ),
                                                ],
                                                onTap: _copyMemberJoinSaving,
                                                title:
                                                    "9. Thành viên có tham gia gửi tiết kiệm định hướng?",
                                                width: screenWidth * 1,
                                              ),
                                              CardCustomizeWidget(
                                                children: [
                                                  Text(
                                                    "Mức vay bổ sung",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: TextField(
                                                      controller:
                                                          _controllerAmountAdditionalLoan,
                                                      style:
                                                          textStyleTextFieldCEP,
                                                      decoration:
                                                          inputDecorationTextFieldCEP(
                                                              "Nhập số tiền...",
                                                              suffixText:
                                                                  "VNĐ"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Mục đích vay vốn bổ sung",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: CustomDropdown(
                                                      dropdownMenuItemList:
                                                          _additionalLoanPurposeModelDropdownList,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _additionalLoanPurposeValue =
                                                              value;
                                                        });
                                                      },
                                                      value:
                                                          _additionalLoanPurposeValue,
                                                      width: screenWidth * 1,
                                                      isEnabled: true,
                                                      isUnderline: true,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Ngày nhận vốn bổ sung",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: InkWell(
                                                      child: Container(
                                                        width: screenWidth * 1,
                                                        height: 40,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 10,
                                                                left: 10,
                                                                right: 10),
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: ColorConstants
                                                                        .cepColorBackground)),
                                                            color:
                                                                Colors.white),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              selectedDateofAdditionalCapital !=
                                                                      null
                                                                  ? "${selectedDateofAdditionalCapital.toLocal()}"
                                                                      .split(
                                                                          ' ')[0]
                                                                  : "",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: ColorConstants
                                                                      .cepColorBackground),
                                                            ),
                                                            SizedBox(
                                                              width: 20.0,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .calendar_today,
                                                              size: 17,
                                                              color: ColorConstants
                                                                  .cepColorBackground,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () =>
                                                          buildDateofAdditionalCapitalPicker(
                                                              context,
                                                              selectedDateofAdditionalCapital),
                                                    ),
                                                  ),
                                                ],
                                                onTap:
                                                    _copyMemberRegisterAdditionalLoan,
                                                width: screenWidth * 1,
                                                title:
                                                    "10. Thành viên có đăng ký vay bổ sung",
                                              )

                                              /// 4. Thông tin về thu nhập, chi phí, tích lũy hộ gia đình thành viên
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// /////////////////
                        /// ĐÁNH GIÁ PAGE ///
                        GestureDetector(
                          onTap: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          child: new Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                children: [
                                  new Center(
                                    child: Text(
                                      "Đánh Giá Và Đề Xuất Duyệt Vay Của Nhân Viên Tín Dụng",
                                      style: TextStyle(
                                        color: Color(0xff003399),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: new Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: screenWidth * 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CardCustomizeWidget(
                                                  children: [],
                                                  title:
                                                      "11. Loại hộ nghèo của thành viên vay lần 1",
                                                  width: screenWidth * 1,
                                                ),
                                                CardCustomizeWidget(
                                                  isShowCopyIcon: isDataHistory,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      child: TextField(
                                                        controller:
                                                            _controllerCreditOfficerNotes,
                                                        textInputAction:
                                                            TextInputAction
                                                                .newline,
                                                        maxLength: 400,
                                                        //keyboardType: TextInputType.text,
                                                        maxLines: 8,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        style:
                                                            textStyleTextFieldCEP,
                                                        decoration:
                                                            inputDecorationTextFieldCEP(
                                                                "Nhập chữ có dấu hoặc không dấu"),
                                                        //keyboardType: TextInputType.text,
                                                        // Only numbers can be entered
                                                      ),
                                                    ),
                                                  ],
                                                  onTap: () {
                                                    dialogCustomForCEP(
                                                        context,
                                                        "Ghi chú của CBQL",
                                                        _copyNoted,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Ngày khảo sát: ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Lato',
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                selectedSurveyDate !=
                                                                        null
                                                                    ? "${selectedSurveyDate.toLocal()}"
                                                                        .split(
                                                                            ' ')[0]
                                                                    : "",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'Lato',
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    screenWidth *
                                                                        0.84,
                                                                child: Text(
                                                                  surveyInfoHistory
                                                                      .ghiChu,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .justify,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                        width: screenWidth * 1);
                                                  },
                                                  title:
                                                      "12. Ghi chú của nhân viên tín dụng",
                                                  width: screenWidth * 1,
                                                ),
                                                CardCustomizeWidget(
                                                  children: [
                                                    Text(
                                                      "Số tiền",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      child: TextField(
                                                        controller:
                                                            _controllerDisbursementAmount,
                                                        style:
                                                            textStyleTextFieldCEP,
                                                        decoration:
                                                            inputDecorationTextFieldCEP(
                                                                "Nhập số tiền...",
                                                                suffixText:
                                                                    "VNĐ"),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          CurrencyInputFormatter()
                                                        ], // Only numbers can be entered
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Tiết kiệm định hướng",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      child: TextField(
                                                        controller:
                                                            _controllerDisbursementAmountOrientationDeposit,
                                                        style:
                                                            textStyleTextFieldCEP,
                                                        decoration:
                                                            inputDecorationTextFieldCEP(
                                                                "Nhập số tiền...",
                                                                suffixText:
                                                                    "VNĐ"),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          CurrencyInputFormatter()
                                                        ], // Only numbers can be entered
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Mục đích",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      child: CustomDropdown(
                                                        dropdownMenuItemList:
                                                            _loanPurposeModelDropdownList,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _loanPurposeValue =
                                                                value;
                                                          });
                                                        },
                                                        value:
                                                            _loanPurposeValue,
                                                        width: screenWidth * 1,
                                                        isEnabled: true,
                                                        isUnderline: true,
                                                      ),
                                                    ),
                                                  ],
                                                  title: "13. Đề xuất",
                                                  width: screenWidth * 1,
                                                ),

                                                /// 4. Thông tin về thu nhập, chi phí, tích lũy hộ gia đình thành viên
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// /////////////////
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  Widget customRadio(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color: selectedIndexKhuVuc == index
              ? ColorConstants.cepColorBackground
              : Colors.grey),
      child: Text(
        txt,
        style: TextStyle(
            color: selectedIndexKhuVuc == index
                ? ColorConstants.cepColorBackground
                : Colors.grey),
      ),
    );
  }

  Widget customRadioTotalMonthly(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndexTotalMonthlyRadioButton(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color: selectedIndexTotalMonthly == index
              ? ColorConstants.cepColorBackground
              : Colors.grey),
      child: Text(
        txt,
        style: TextStyle(
            color: selectedIndexTotalMonthly == index
                ? ColorConstants.cepColorBackground
                : Colors.grey),
      ),
    );
  }

  Widget customRadioTimeOfWithdrawal(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndexTimeOfWithdrawalRadioButton(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color: selectedIndexTimeOfWithdrawal == index
              ? ColorConstants.cepColorBackground
              : Colors.grey),
      child: Text(
        txt,
        style: TextStyle(
            color: selectedIndexTimeOfWithdrawal == index
                ? ColorConstants.cepColorBackground
                : Colors.grey),
      ),
    );
  }

  void _copyInfoLoanDemand() {
    _controllerPurposeUseMoney.text = surveyInfoHistory.mucDichSudungVon;
    _controllerAmountRequiredForCapitalUsePurposes.text =
        MoneyFormat.moneyFormat(surveyInfoHistory.soTienCanThiet.toString());
    _controllerAmountMemberHave.text = MoneyFormat.moneyFormat(
        surveyInfoHistory.soTienThanhVienDaCo.toString());
    _controllerAmountMemberNeed.text =
        MoneyFormat.moneyFormat(surveyInfoHistory.soTienCanVay.toString());
    if (surveyInfoHistory.thoiDiemSuDungVonvay.length > 1) {
      setState(() {
        selectedTimetoUseLoanDate = DateFormat('MM/dd/yyyy').parse(
            surveyInfoHistory.thoiDiemSuDungVonvay +
                '/' +
                DateTime.now().year.toString());
      });
    }
  }

  void _copyInfoIcome() {
    _controllerTotalAmountGetSeason.text =
        MoneyFormat.moneyFormat(surveyInfoHistory.tongVonDauTu.toString());
    _controllerTotalAmountMonthlyforActivityIncomeIncrease.text =
        MoneyFormat.moneyFormat(
            surveyInfoHistory.thuNhapRongHangThang.toString());
    _controllerIncomeOfWifeHusband.text =
        MoneyFormat.moneyFormat(surveyInfoHistory.thuNhapCuaVoChong.toString());
    _controllerIncomeOfChild = new TextEditingController(
        text: MoneyFormat.moneyFormat(
            surveyInfoHistory.thuNhapCuaCacCon.toString()));
    _controllerIncomeOther.text =
        MoneyFormat.moneyFormat(surveyInfoHistory.thuNhapKhac.toString());
    _controllerTotalMonthlyExpenses.text = MoneyFormat.moneyFormat(
        surveyInfoHistory.tongChiPhiCuaThanhvien.toString());
    _controllerTotalPowerAndWater.text =
        MoneyFormat.moneyFormat(surveyInfoHistory.chiPhiDienNuoc.toString());
    _controllerTotalCharge.text =
        MoneyFormat.moneyFormat(surveyInfoHistory.chiPhiAnUong.toString());
    _controllerTotalFee.text =
        MoneyFormat.moneyFormat(surveyInfoHistory.chiPhiHocTap.toString());
    _controllerTotalOtherCost.text =
        MoneyFormat.moneyFormat(surveyInfoHistory.chiPhiKhac.toString());
    _controllerCostofLoanRepaymentToCEPMonthly.text = MoneyFormat.moneyFormat(
        surveyInfoHistory.chiTraTienVayHangThang.toString());
    _controllerMonthlyBalanceUseCapital.text = MoneyFormat.moneyFormat(
        surveyInfoHistory.tichLuyTangThemHangThang.toString());
  }

  void _copyMemberLoanOtherCapital() {
    setState(() {
      _capital1Value = surveyInfoHistory.nguonVay1;
      _capital2Value = surveyInfoHistory.nguonVay2;
      _reasonLoan1Value = surveyInfoHistory.lyDoVay1;
      _reasonLoan2Value = surveyInfoHistory.lyDoVay2;
      _uniformMeasure1Value = surveyInfoHistory.bienPhapThongNhat1;
      _uniformMeasure2Value = surveyInfoHistory.bienPhapThongNhat2;
      _controllerTotalAmountCapital1.text =
          MoneyFormat.moneyFormat(surveyInfoHistory.sotienVay1.toString());
      _controllerTotalAmountCapital2.text =
          MoneyFormat.moneyFormat(surveyInfoHistory.sotienVay2.toString());

      if (surveyInfoHistory.thoiDiemTatToan1.length > 1) {
        selectedFinalSettlement1Date = DateFormat('MM/dd/yyyy').parse(
            surveyInfoHistory.thoiDiemTatToan1 +
                '/' +
                DateTime.now().year.toString());
      }

      if (surveyInfoHistory.thoiDiemTatToan2.length > 1) {
        selectedFinalSettlement2Date = DateFormat('MM/dd/yyyy').parse(
            surveyInfoHistory.thoiDiemTatToan2 +
                '/' +
                DateTime.now().year.toString());
      }
    });
  }

  void _copyTypeMember() {
    setState(() {
      _typeMemberValue = surveyInfoHistory.thanhVienThuocDien;
      _controllerPoorHouseholdsCode.text = surveyInfoHistory.maSoHoNgheo == null
          ? ""
          : surveyInfoHistory.maSoHoNgheo.toString();
      _controllerNameofHouseholdHead.text = surveyInfoHistory.hoTenChuHo == null
          ? ""
          : surveyInfoHistory.hoTenChuHo.toString();
    });
  }

  void _copyAmountSavingsDepositAmountEverytime() {
    _controllerSavingsDepositAmountEverytime.text =
        surveyInfoHistory.soTienGuiTietKiemMoiKy == null
            ? ""
            : MoneyFormat.moneyFormat(
                surveyInfoHistory.soTienGuiTietKiemMoiKy.toString());
  }

  void _copyMemberJoinSaving() {
    _controllerRequiredDeposit.text =
        surveyInfoHistory.tietKiemBatBuocXinRut == null
            ? ""
            : MoneyFormat.moneyFormat(
                surveyInfoHistory.tietKiemBatBuocXinRut.toString());
    _controllerOrientationDeposit.text =
        surveyInfoHistory.tietKiemTuNguyenXinRut == null
            ? ""
            : MoneyFormat.moneyFormat(
                surveyInfoHistory.tietKiemTuNguyenXinRut.toString());

    _controllerFlexibleDeposit.text =
        surveyInfoHistory.tietKiemLinhHoatXinRut == null
            ? ""
            : MoneyFormat.moneyFormat(
                surveyInfoHistory.tietKiemLinhHoatXinRut.toString());

    if (surveyInfoHistory.thoiDiemRut.length > 1) {
      selectedTimeOfWithdrawalDate = DateFormat('MM/dd/yyyy').parse(
          surveyInfoHistory.thoiDiemRut + '/' + DateTime.now().year.toString());
    }
  }

  void _copyMemberRegisterAdditionalLoan() {
    setState(() {
      _controllerAmountAdditionalLoan.text = surveyInfoHistory.mucVayBoSung ==
              null
          ? ""
          : MoneyFormat.moneyFormat(surveyInfoHistory.mucVayBoSung.toString());
      _additionalLoanPurposeValue = surveyInfoHistory.mucDichVayBoSung;

      selectedDateofAdditionalCapital =
          FormatDateConstants.convertJsonDateToDateTime(
              surveyInfoHistory.ngayVayBoSung);
      _additionalLoanPurposeValue = surveyInfoHistory.mucDichVayBoSung;
    });
  }

  void _copyNoted() {
    _controllerCreditOfficerNotes.text = surveyInfoHistory.ghiChu == null
        ? ""
        : surveyInfoHistory.ghiChu.toString();
  }

  void validationForm() {
    // dialogCustomForCEP(context, "Bạn có muốn lưu dữ liệu khảo sát ?", _onSubmit,
    //     children: [], width: screenWidth * 0.7);

    //tabController.animateTo(2);

    formkeySurveyDetail.currentState.validate();
    if (selectedSurveyDate == null) {
      tabController.animateTo(0);
    } else if (_controllerNumberPeopleWorked.text.isEmpty ||
        _controllerNumberPeopleInFamily.text.isEmpty) {
      tabController.animateTo(1);
      new Timer(Duration(milliseconds: 200), () {
        formkeySurveyDetail.currentState.validate();
      });

      return;
    } else if (int.parse(_controllerNumberPeopleWorked.text) >
        int.parse(_controllerNumberPeopleInFamily.text)) {
      tabController.animateTo(1);
      new Timer(Duration(milliseconds: 200), () {
        formkeySurveyDetail.currentState.validate();
      });
      return;
    } else {
      dialogCustomForCEP(
          context, "Bạn có muốn lưu dữ liệu khảo sát ?", _onSubmit,
          children: [], width: screenWidth * 0.7);
    }
  }

  @override
  bool get wantKeepAlive => true;

  onSaveDataToCommunityDevelopment() {}
}
