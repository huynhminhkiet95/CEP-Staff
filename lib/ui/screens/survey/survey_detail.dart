import 'dart:async';
import 'dart:ui';
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

class SurveyDetailScreen extends StatefulWidget {
  final int id;
  final List<ComboboxModel> listCombobox;
  final SurveyInfo surveyInfo;
  final List<SurveyInfoHistory> listSurveyHistory;
  const SurveyDetailScreen(
      {Key key,
      this.id,
      this.listCombobox,
      this.surveyInfo,
      this.listSurveyHistory})
      : super(key: key);

  @override
  _SurveyDetailScreenState createState() => _SurveyDetailScreenState();
}

class _SurveyDetailScreenState extends State<SurveyDetailScreen>
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
      helpText: 'Ch???n ng??y',
      cancelText: 'H???y',
      confirmText: 'Ch???n',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Ch???n ng??y',
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
    tabController = new TabController(length: 5, vsync: this);
    tabController.addListener(() {
      if (_controllerDisbursementAmountOrientationDeposit.text.isEmpty) {
        _controllerDisbursementAmountOrientationDeposit.text =
            _controllerSavingsDepositAmountEverytime.text;
      }
    });
    surveyInfoHistory = widget.listSurveyHistory
                .where((e) => e.thanhvienId == widget.surveyInfo.thanhvienId)
                .length >
            0
        ? widget.listSurveyHistory
            .where((e) => e.thanhvienId == widget.surveyInfo.thanhvienId)
            .first
        : null;
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
    SurveyInfo model = new SurveyInfo();
    model.id = widget.id;
    model.ngayXuatDanhSach = widget.surveyInfo.ngayXuatDanhSach;
    model.ngayKhaoSat =
        FormatDateConstants.convertDateTimeToStringT(selectedSurveyDate);
    model.masoCanBoKhaoSat = widget.surveyInfo.masoCanBoKhaoSat;
    model.chinhanhId = widget.surveyInfo.chinhanhId;
    model.duanId = widget.surveyInfo.duanId;
    model.cumId = widget.surveyInfo.cumId;
    model.thanhvienId = widget.surveyInfo.thanhvienId;
    model.tinhTrangHonNhan = _maritalStatusValue;
    model.trinhDoHocVan = _educationLevelValue;
    model.khuVuc = selectedIndexKhuVuc;
    model.lanvay = widget.surveyInfo.lanvay;
    model.nguoiTraloiKhaoSat = _surveyRespondentsValue;
    model.songuoiTrongHo = int.parse(
        _controllerNumberPeopleInFamily.text.isEmpty
            ? "0"
            : _controllerNumberPeopleInFamily.text);
    model.songuoiCoviecLam = int.parse(
        _controllerNumberPeopleWorked.text.isEmpty
            ? "0"
            : _controllerNumberPeopleWorked.text);
    model.dientichDatTrong = widget.surveyInfo.dientichDatTrong;
    model.giaTriVatNuoi = widget.surveyInfo.giaTriVatNuoi;
    model.dungCuLaoDong =
        MoneyFormat.convertCurrencyToInt(_controllerAmountOfLaborTools.text);
    model.phuongTienDiLai = MoneyFormat.convertCurrencyToInt(
        _controllerAmountOfVehiclesTransport.text);
    model.taiSanSinhHoat =
        MoneyFormat.convertCurrencyToInt(_controllerAmountLivingEquipment.text);
    model.quyenSoHuuNha = _ownershipValue;
    model.hemTruocNha = int.parse(_controllerNumberOfAlleyNearHome.text.isEmpty
        ? "0"
        : _controllerNumberOfAlleyNearHome.text);
    model.maiNha = _roofValue;
    model.tuongNha = _wallValue;
    model.nenNha = _floorValue;
    model.dienTichNhaTinhTren1Nguoi = int.parse(
        _controllerAcreageOfHome.text.isEmpty
            ? "0"
            : _controllerAcreageOfHome.text);
    model.dien = _powerValue;
    model.nuoc = _waterValue;
    model.mucDichSudungVon = _controllerPurposeUseMoney.text;
    model.soTienCanThiet = MoneyFormat.convertCurrencyToInt(
        _controllerAmountRequiredForCapitalUsePurposes.text);

    model.soTienThanhVienDaCo =
        MoneyFormat.convertCurrencyToInt(_controllerAmountMemberHave.text);

    model.soTienCanVay =
        MoneyFormat.convertCurrencyToInt(_controllerAmountMemberNeed.text);

    model.thoiDiemSuDungVonvay = selectedTimetoUseLoanDate != null
        ? DateFormat('MM/dd').format(selectedTimetoUseLoanDate)
        : "";
    model.tongVonDauTu =
        MoneyFormat.convertCurrencyToInt(_controllerTotalAmountGetSeason.text);
    model.thuNhapRongHangThang = MoneyFormat.convertCurrencyToInt(
        _controllerTotalAmountMonthlyforActivityIncomeIncrease.text);
    model.thuNhapCuaVoChong =
        MoneyFormat.convertCurrencyToInt(_controllerIncomeOfWifeHusband.text);
    model.thuNhapCuaCacCon =
        MoneyFormat.convertCurrencyToInt(_controllerIncomeOfChild.text);

    model.thuNhapKhac =
        MoneyFormat.convertCurrencyToInt(_controllerIncomeOther.text);

    if (selectedIndexTotalMonthly == 0) {
      model.tongChiPhiCuaThanhvien = MoneyFormat.convertCurrencyToInt(
          _controllerTotalMonthlyExpenses.text);
      model.chiPhiDienNuoc = 0;
      model.chiPhiAnUong = 0;
      model.chiPhiHocTap = 0;
      model.chiPhiKhac = 0;
    } else {
      model.tongChiPhiCuaThanhvien = 0;
      model.chiPhiDienNuoc =
          MoneyFormat.convertCurrencyToInt(_controllerTotalPowerAndWater.text);
      model.chiPhiAnUong =
          MoneyFormat.convertCurrencyToInt(_controllerTotalCharge.text);
      model.chiPhiHocTap =
          MoneyFormat.convertCurrencyToInt(_controllerTotalFee.text);
      model.chiPhiKhac =
          MoneyFormat.convertCurrencyToInt(_controllerTotalOtherCost.text);
    }

    model.chiTraTienVayHangThang = MoneyFormat.convertCurrencyToInt(
        _controllerCostofLoanRepaymentToCEPMonthly.text);
    model.tichLuyTangThemHangThang = MoneyFormat.convertCurrencyToInt(
        _controllerMonthlyBalanceUseCapital.text);
    model.nguonVay1 = _capital1Value;
    model.sotienVay1 =
        MoneyFormat.convertCurrencyToInt(_controllerTotalAmountCapital1.text);

    model.lyDoVay1 = _reasonLoan1Value;
    model.thoiDiemTatToan1 = selectedFinalSettlement1Date != null
        ? DateFormat('MM/dd').format(selectedFinalSettlement1Date)
        : "";
    model.bienPhapThongNhat1 = _uniformMeasure1Value;
    model.nguonVay2 = _capital2Value;
    model.sotienVay2 =
        MoneyFormat.convertCurrencyToInt(_controllerTotalAmountCapital2.text);
    model.lyDoVay2 = _reasonLoan2Value;
    model.thoiDiemTatToan2 = selectedFinalSettlement2Date != null
        ? DateFormat('MM/dd').format(selectedFinalSettlement2Date)
        : "";
    model.bienPhapThongNhat2 = _uniformMeasure2Value;
    model.thanhVienThuocDien = _typeMemberValue;
    model.maSoHoNgheo = _controllerPoorHouseholdsCode.text;
    model.hoTenChuHo = _controllerNameofHouseholdHead.text;
    model.soTienGuiTietKiemMoiKy = MoneyFormat.convertCurrencyToInt(
        _controllerSavingsDepositAmountEverytime.text);
    model.tietKiemBatBuocXinRut =
        MoneyFormat.convertCurrencyToInt(_controllerRequiredDeposit.text);
    model.tietKiemTuNguyenXinRut =
        MoneyFormat.convertCurrencyToInt(_controllerOrientationDeposit.text);
    model.tietKiemLinhHoatXinRut =
        MoneyFormat.convertCurrencyToInt(_controllerFlexibleDeposit.text);
    if (selectedIndexTimeOfWithdrawal == 0) {
      model.thoiDiemRut = "";
    } else {
      model.thoiDiemRut = selectedTimeOfWithdrawalDate != null
          ? DateFormat('MM/dd').format(selectedTimeOfWithdrawalDate)
          : "";
    }
    model.mucVayBoSung =
        MoneyFormat.convertCurrencyToInt(_controllerAmountAdditionalLoan.text);
    model.mucDichVayBoSung = _additionalLoanPurposeValue;
    model.ngayVayBoSung = FormatDateConstants.convertDateTimeToStringT(
        selectedDateofAdditionalCapital);
    model.ghiChu = _controllerCreditOfficerNotes.text;
    model.soTienDuyetChovay =
        MoneyFormat.convertCurrencyToInt(_controllerDisbursementAmount.text);
    model.tietKiemDinhHuong = MoneyFormat.convertCurrencyToInt(
        _controllerDisbursementAmountOrientationDeposit.text);
    model.mucDichVay = _loanPurposeValue;
    model.duyetChovayNgay = widget.surveyInfo.duyetChovayNgay; //??
    model.daCapNhatVaoHoSoChovay =
        widget.surveyInfo.daCapNhatVaoHoSoChovay; //??
    model.tinhTrangNgheo = widget.surveyInfo.tinhTrangNgheo; //??
    model.daDuocDuyet = widget.surveyInfo.daDuocDuyet; //??
    model.username = widget.surveyInfo.username; //??
    model.ngaycapnhat = widget.surveyInfo.ngaycapnhat; //??
    model.daDuocDuyet = widget.surveyInfo.daDuocDuyet; //??
    model.masoCanBoKhaoSatPss = widget.surveyInfo.masoCanBoKhaoSatPss; //??
    model.sotienVayLantruoc = widget.surveyInfo.sotienVayLantruoc; //??
    model.thoiGianTaivay = widget.surveyInfo.thoiGianTaivay; //??
    model.songayNoquahanCaonhat = widget.surveyInfo.songayNoquahanCaonhat; //??
    model.thoiGianKhaosatGannhat =
        widget.surveyInfo.thoiGianKhaosatGannhat; //??
    model.ngayTatToanDotvayTruoc =
        widget.surveyInfo.ngayTatToanDotvayTruoc; //??
    model.batBuocKhaosat = widget.surveyInfo.batBuocKhaosat; //??
    model.conNo = widget.surveyInfo.conNo; //??
    model.dichVuSgb = widget.surveyInfo.dichVuSgb; //??
    model.moTheMoi = widget.surveyInfo.moTheMoi; //??
    model.soTienDuyetChoVayCk = widget.surveyInfo.soTienDuyetChoVayCk; //??
    model.gioiTinh = widget.surveyInfo.gioiTinh; //??
    model.cmnd = widget.surveyInfo.cmnd; //??
    model.ngaySinh = widget.surveyInfo.ngaySinh; //??
    model.diaChi = widget.surveyInfo.diaChi; //??
    model.thoigianthamgia = widget.surveyInfo.thoigianthamgia; //??
    model.hoVaTen = widget.surveyInfo.hoVaTen; //??
    model.statusCheckBox = widget.surveyInfo.statusCheckBox; //??
    model.idHistoryKhaoSat = widget.surveyInfo.idHistoryKhaoSat; //??
    surVeyBloc.emitEvent(UpdateSurveyEvent(model, context));
  }

  void loadInitData() {
    // khu vuc
    selectedIndexKhuVuc = widget.surveyInfo.khuVuc;

    /// nguoi tra loi khao sat
    _surveyRespondentsModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox
            .where((e) => e.groupId == 'NguoiTraloiKhaosat')
            .toList());
    _surveyRespondentsValue =
        widget.surveyInfo.nguoiTraloiKhaoSat.trim().isEmpty
            ? "0"
            : widget.surveyInfo.nguoiTraloiKhaoSat.trim();

    /// tinh trang hon nhan
    _maritalStatusModelDropdownList = Helper.buildDropdownFromMetaData(widget
        .listCombobox
        .where((e) => e.groupId == 'TinhTrangHonNhan')
        .toList());
    _maritalStatusValue = widget.surveyInfo.tinhTrangHonNhan.trim().isEmpty
        ? "0"
        : widget.surveyInfo.tinhTrangHonNhan;

    ///trinh do hoc van
    _educationLevelModelDropdownList = Helper.buildDropdownFromMetaData(widget
        .listCombobox
        .where((e) => e.groupId == 'TrinhDoHocVan')
        .toList());
    _educationLevelValue = widget.surveyInfo.trinhDoHocVan.trim().isEmpty
        ? "0"
        : widget.surveyInfo.trinhDoHocVan.trim();

    /// quyen so huu
    _ownershipModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'SoHuuNha').toList());
    _ownershipValue = widget.surveyInfo.quyenSoHuuNha.trim().isEmpty
        ? "0"
        : widget.surveyInfo.quyenSoHuuNha.trim();

    ///mai nha
    _roofModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'MaiNha').toList());
    _roofValue = widget.surveyInfo.maiNha.trim().isEmpty
        ? "0"
        : widget.surveyInfo.maiNha.trim();

    ///tuong nha
    _wallModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'TuongNha').toList());
    _wallValue = widget.surveyInfo.tuongNha.trim().isEmpty
        ? "0"
        : widget.surveyInfo.tuongNha.trim();

    ///nen nha
    _floorModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'NenNha').toList());
    _floorValue = widget.surveyInfo.nenNha.trim().isEmpty
        ? "0"
        : widget.surveyInfo.nenNha.trim();

    ///dien
    _powerModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'Dien').toList());
    _powerValue = widget.surveyInfo.dien.trim().isEmpty
        ? "0"
        : widget.surveyInfo.dien.trim();

    ///nuoc
    _waterModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'Nuoc').toList());
    _waterValue = widget.surveyInfo.nuoc.trim().isEmpty
        ? "0"
        : widget.surveyInfo.nuoc.trim();

    ///nguon vay 1
    _capitalModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'NguonVay').toList());
    _capital1Value = widget.surveyInfo.nguonVay1.trim().isEmpty
        ? "0"
        : widget.surveyInfo.nguonVay1.trim();
    _capital2Value = widget.surveyInfo.nguonVay2.trim().isEmpty
        ? "0"
        : widget.surveyInfo.nguonVay2.trim();

    ///ly do vay
    _reasonLoanModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'LyDoVay').toList());
    _reasonLoan1Value = widget.surveyInfo.lyDoVay1.trim().isEmpty
        ? "0"
        : widget.surveyInfo.lyDoVay1.trim();
    _reasonLoan2Value = widget.surveyInfo.lyDoVay2.trim().isEmpty
        ? "0"
        : widget.surveyInfo.lyDoVay2.trim();

    ///bien phap thong nhat
    _uniformMeasuresModelDropdownList = Helper.buildDropdownFromMetaData(widget
        .listCombobox
        .where((e) => e.groupId == 'BienPhapThongNhat')
        .toList());
    _uniformMeasure1Value = widget.surveyInfo.bienPhapThongNhat1.trim().isEmpty
        ? "0"
        : widget.surveyInfo.bienPhapThongNhat1.trim();
    _uniformMeasure2Value = widget.surveyInfo.bienPhapThongNhat2.trim().isEmpty
        ? "0"
        : widget.surveyInfo.bienPhapThongNhat2.trim();

    //thanh vien thuoc dien
    _typeMemberModelDropdownList = Helper.buildDropdownFromMetaData(widget
        .listCombobox
        .where((e) => e.groupId == 'ThanhVienThuocDien')
        .toList());
    _typeMemberValue = widget.surveyInfo.thanhVienThuocDien.trim().isEmpty
        ? "0"
        : widget.surveyInfo.thanhVienThuocDien.trim();

    ///muc dich vay von bo sung
    _additionalLoanPurposeModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'MucDich').toList());
    _additionalLoanPurposeValue =
        widget.surveyInfo.mucDichVayBoSung.trim().isEmpty
            ? "0"
            : widget.surveyInfo.mucDichVayBoSung.trim();

    ///muc dich vay von
    _loanPurposeModelDropdownList = Helper.buildDropdownFromMetaData(
        widget.listCombobox.where((e) => e.groupId == 'MucDich').toList());
    _loanPurposeValue = widget.surveyInfo.mucDichVay.trim().isEmpty
        ? "0"
        : widget.surveyInfo.mucDichVay.trim();

    selectedSurveyDate = FormatDateConstants.convertJsonDateToDateTime(
        widget.surveyInfo.ngayKhaoSat);

    if (widget.surveyInfo.thoiDiemSuDungVonvay.length > 1) {
      selectedTimetoUseLoanDate = DateFormat('MM/dd/yyyy').parse(
          widget.surveyInfo.thoiDiemSuDungVonvay +
              '/' +
              DateTime.now().year.toString());
    }

    if (widget.surveyInfo.thoiDiemTatToan1.length > 1) {
      selectedFinalSettlement1Date = DateFormat('MM/dd/yyyy').parse(
          widget.surveyInfo.thoiDiemTatToan1 +
              '/' +
              DateTime.now().year.toString());
    }

    if (widget.surveyInfo.thoiDiemTatToan2.length > 1) {
      selectedFinalSettlement2Date = DateFormat('MM/dd/yyyy').parse(
          widget.surveyInfo.thoiDiemTatToan2 +
              '/' +
              DateTime.now().year.toString());
    }

    if (widget.surveyInfo.thoiDiemRut.length > 1) {
      selectedTimeOfWithdrawalDate = DateFormat('MM/dd/yyyy').parse(
          widget.surveyInfo.thoiDiemRut + '/' + DateTime.now().year.toString());
    }

    selectedDateofAdditionalCapital =
        FormatDateConstants.convertJsonDateToDateTime(
            widget.surveyInfo.ngayVayBoSung);

    _controllerNumberPeopleInFamily = new TextEditingController(
        text: widget.surveyInfo.songuoiTrongHo.toString());

    _controllerNumberPeopleWorked = new TextEditingController(
        text: widget.surveyInfo.songuoiCoviecLam.toString());

    _controllerAmountOfLaborTools.text =
        MoneyFormat.moneyFormat(widget.surveyInfo.dungCuLaoDong.toString());

    _controllerAmountOfVehiclesTransport.text =
        MoneyFormat.moneyFormat(widget.surveyInfo.phuongTienDiLai.toString());

    _controllerAmountLivingEquipment.text =
        MoneyFormat.moneyFormat(widget.surveyInfo.taiSanSinhHoat.toString());

    _controllerNumberOfAlleyNearHome = new TextEditingController(
        text: widget.surveyInfo.hemTruocNha.toString());

    _controllerAcreageOfHome = new TextEditingController(
        text: widget.surveyInfo.dienTichNhaTinhTren1Nguoi.toString());

    _controllerPurposeUseMoney = new TextEditingController(
        text: widget.surveyInfo.mucDichSudungVon.toString());

    _controllerAmountRequiredForCapitalUsePurposes.text =
        MoneyFormat.moneyFormat(widget.surveyInfo.soTienCanThiet
            .toString()); // maybe so tien can cho muc dich su dung von

    _controllerAmountMemberHave = new TextEditingController(
        text: MoneyFormat.moneyFormat(
            widget.surveyInfo.soTienThanhVienDaCo.toString()));

    _controllerAmountMemberNeed = new TextEditingController(
        text:
            MoneyFormat.moneyFormat(widget.surveyInfo.soTienCanVay.toString()));

    _controllerTotalAmountGetSeason = new TextEditingController(
        text:
            MoneyFormat.moneyFormat(widget.surveyInfo.tongVonDauTu.toString()));

    _controllerTotalAmountMonthlyforActivityIncomeIncrease =
        new TextEditingController(
            text: MoneyFormat.moneyFormat(
                widget.surveyInfo.thuNhapRongHangThang.toString()));

    _controllerIncomeOfWifeHusband = new TextEditingController(
        text: MoneyFormat.moneyFormat(
            widget.surveyInfo.thuNhapCuaVoChong.toString()));

    _controllerIncomeOfChild = new TextEditingController(
        text: MoneyFormat.moneyFormat(
            widget.surveyInfo.thuNhapCuaCacCon.toString()));

    _controllerIncomeOther = new TextEditingController(
        text:
            MoneyFormat.moneyFormat(widget.surveyInfo.thuNhapKhac.toString()));

    _controllerTotalMonthlyExpenses = new TextEditingController(
        text: MoneyFormat.moneyFormat(
            widget.surveyInfo.tongChiPhiCuaThanhvien.toString()));
    _controllerTotalPowerAndWater = new TextEditingController(
        text: MoneyFormat.moneyFormat(
            widget.surveyInfo.chiPhiDienNuoc.toString()));
    _controllerTotalCharge = new TextEditingController(
        text:
            MoneyFormat.moneyFormat(widget.surveyInfo.chiPhiAnUong.toString()));
    _controllerTotalFee = new TextEditingController(
        text:
            MoneyFormat.moneyFormat(widget.surveyInfo.chiPhiHocTap.toString()));
    _controllerTotalOtherCost = new TextEditingController(
        text: MoneyFormat.moneyFormat(widget.surveyInfo.chiPhiKhac.toString()));
    _controllerCostofLoanRepaymentToCEPMonthly = new TextEditingController(
        text: MoneyFormat.moneyFormat(
            widget.surveyInfo.chiTraTienVayHangThang.toString()));
    _controllerMonthlyBalanceUseCapital = new TextEditingController(
        text: MoneyFormat.moneyFormat(
            widget.surveyInfo.tichLuyTangThemHangThang.toString()));
    _controllerTotalAmountCapital1.text =
        MoneyFormat.moneyFormat(widget.surveyInfo.sotienVay1.toString());

    // = new TextEditingController(text: widget.surveyInfo.sotienVay1 == null? "": widget.surveyInfo.sotienVay1.toString());
    _controllerTotalAmountCapital2 = new TextEditingController(
        text: widget.surveyInfo.sotienVay2 == null
            ? ""
            : MoneyFormat.moneyFormat(widget.surveyInfo.sotienVay2.toString()));
    _controllerPoorHouseholdsCode = new TextEditingController(
        text: widget.surveyInfo.maSoHoNgheo == null
            ? ""
            : widget.surveyInfo.maSoHoNgheo.toString());
    _controllerNameofHouseholdHead = new TextEditingController(
        text: widget.surveyInfo.hoTenChuHo == null
            ? ""
            : widget.surveyInfo.hoTenChuHo.toString());
    _controllerSavingsDepositAmountEverytime = new TextEditingController(
        text: widget.surveyInfo.soTienGuiTietKiemMoiKy == null
            ? ""
            : MoneyFormat.moneyFormat(
                widget.surveyInfo.soTienGuiTietKiemMoiKy.toString()));
    _controllerRequiredDeposit = new TextEditingController(
        text: widget.surveyInfo.tietKiemBatBuocXinRut == null
            ? ""
            : MoneyFormat.moneyFormat(
                widget.surveyInfo.tietKiemBatBuocXinRut.toString()));
    _controllerOrientationDeposit = new TextEditingController(
        text: widget.surveyInfo.tietKiemTuNguyenXinRut == null
            ? ""
            : MoneyFormat.moneyFormat(
                widget.surveyInfo.tietKiemTuNguyenXinRut.toString()));

    _controllerFlexibleDeposit = new TextEditingController(
        text: widget.surveyInfo.tietKiemLinhHoatXinRut == null
            ? ""
            : MoneyFormat.moneyFormat(
                widget.surveyInfo.tietKiemLinhHoatXinRut.toString()));

    _controllerAmountAdditionalLoan = new TextEditingController(
        text: widget.surveyInfo.mucVayBoSung == null
            ? ""
            : MoneyFormat.moneyFormat(
                widget.surveyInfo.mucVayBoSung.toString()));

    _controllerCreditOfficerNotes = new TextEditingController(
        text: widget.surveyInfo.ghiChu == null
            ? ""
            : widget.surveyInfo.ghiChu.toString());

    _controllerDisbursementAmount = new TextEditingController(
        text: widget.surveyInfo.soTienDuyetChovay == null
            ? ""
            : MoneyFormat.moneyFormat(
                widget.surveyInfo.soTienDuyetChovay.toString()));

    _controllerDisbursementAmountOrientationDeposit = new TextEditingController(
        text: widget.surveyInfo.tietKiemDinhHuong == null
            ? ""
            : MoneyFormat.moneyFormat(
                widget.surveyInfo.tietKiemDinhHuong.toString()));

    if (widget.surveyInfo.tongChiPhiCuaThanhvien == 0)
      selectedIndexTotalMonthly = 1;
    else
      selectedIndexTotalMonthly = 0;

    if (widget.surveyInfo.thoiDiemRut == "") {
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
      'Th??nh th???',
      'N??ng th??n',
    ];

    List<String> listTypeOfTotalMonth = [
      'Ng?????i tr??? l???i bi???t t???ng chi ph??',
      'Ng?????i tr??? l???i kh??ng bi???t t???ng chi ph??',
    ];

    List<String> listTimeOfWithdrawal = [
      'Cu???i k???',
      'Kh??c, c??? th???',
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
                  title: new Text("C???p Nh???t Th??ng Tin Kh???o S??t",
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
                                    'Th??ng Tin',
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
                                    'Vay L???n 1',
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
                                    'Nhu C???u V???n',
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
                                    'Vay Ngu???n Kh??c',
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
                                    '????nh Gi??',
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
                        /// TH??NG TIN PAGE ///
                        new Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                new Center(
                                  child: Text(
                                    "Th??ng Tin Th??nh Vi??n",
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
                                              "Th??nh Vi??n:",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                            VerticalDivider(
                                              width: 10,
                                            ),
                                            Text(
                                              widget.surveyInfo.thanhvienId +
                                                  ' - ' +
                                                  widget.surveyInfo.hoVaTen,
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
                                              "Gi???i T??nh:",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              widget.surveyInfo.gioiTinh == 1
                                                  ? "Nam"
                                                  : "N???",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "- N??m Sinh:",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              widget.surveyInfo.ngaySinh
                                                  .substring(0, 4),
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
                                              widget.surveyInfo.cmnd,
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
                                              "?????a ch???:",
                                              style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 14,
                                              ),
                                            ),
                                            VerticalDivider(
                                              width: 10,
                                            ),
                                            Text(
                                              widget.surveyInfo.diaChi,
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
                                                    "Tham gia t???:",
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    FormatDateConstants
                                                        .convertDateTimeToDDMMYYYY(
                                                            widget.surveyInfo
                                                                .thoigianthamgia),
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
                                              "Vay l???n ${widget.surveyInfo.lanvay}",
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
                                                "Khu v???c",
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
                                                "Ng?????i tr??? l???i kh???o s??t",
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
                                                "T??nh tr???ng h??n nh??n",
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
                                                "Tr??nh ????? h???c v???n",
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
                                                "Ng??y kh???o s??t",
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
                                                      "* Tr?????ng n??y b???t bu???c nh???p !",
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
                                                    'C???p nh???t CCCD',
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
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  'personalinforuserdetail',
                                                  arguments: {
                                                    'customerCode': widget
                                                        .surveyInfo.thanhvienId,
                                                    'branchID': widget
                                                        .surveyInfo.chinhanhId,
                                                  });
                                            },
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

                        /// VAY L???N 1 PAGE ///
                        new Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                new Center(
                                  child: Text(
                                    "Th??ng Tin Th??nh Vi??n Vay L???n 1 Ho???c ????nh Gi?? T??c ?????ng",
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
                                                    "1. Th??ng tin v??? t??? l??? ph??? thu???c",
                                                children: [
                                                  Text(
                                                    "S??? ng?????i trong h??? gia ????nh",
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
                                                              "Nh???p s??? (Ng?????i)"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return "* B???n ph???i nh???p tr?????ng n??y !";
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
                                                    "S??? ng?????i c?? vi???c l??m",
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
                                                              "Nh???p s??? (Ng?????i)"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return "* B???n ph???i nh???p tr?????ng n??y !";
                                                        } else if (int.parse(
                                                                value) >
                                                            int.parse(
                                                                _controllerNumberPeopleInFamily
                                                                    .text)) {
                                                          return "* S??? ng?????i c?? vi???c l??m kh??ng ???????c l???n h??n s??? ng?????i trong h??? !";
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

                                              /// 2. Th??ng tin v??? t??i s???n h??? gia ????nh
                                              CardCustomizeWidget(
                                                title:
                                                    "2. Th??ng tin v??? t??i s???n h??? gia ????nh",
                                                width: screenWidth * 1,
                                                children: [
                                                  Text(
                                                    "D???ng c??? lao ?????ng",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "Ph????ng ti???n ??i l???i",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "T??i s???n sinh ho???t (tivi, ?????u ????a, b??n gh???, t??? l???nh, m??y gi???t, b???p gas)",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        CurrencyInputFormatter()
                                                      ], // Only numbers can be entered
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              ///3. Th??ng tin v??? ??i???u ki???n nh?? ???
                                              ///
                                              CardCustomizeWidget(
                                                title:
                                                    "3. Th??ng tin v??? ??i???u ki???n nh?? ???",
                                                width: screenWidth * 1,
                                                children: [
                                                  Text(
                                                    "Quy???n s??? h???u",
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
                                                    "???????ng/ h???m tr?????c nh??",
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
                                                              "Nh???p...",
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
                                                    "Ch???t l?????ng nh??",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "- M??i nh??",
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
                                                    "- T?????ng",
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
                                                    "- N???n",
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
                                                    "Di???n t??ch s??? d???ng",
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
                                                              "Nh???p s???",
                                                              suffixText:
                                                                  "(m2/ng?????i)"),
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
                                                    "??i???n",
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
                                                    "N?????c",
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
                        /// NHU C???U V???N PAGE ///
                        new Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                new Center(
                                  child: Text(
                                    "Th??ng Tin Nhu C???u V???n Thu Nh???p, Chi Ph??, T??ch L??y",
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
                                                    "4.1 M???ch ????ch s??? d???ng v???n",
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
                                                              "Nh???p t???i ??a 40 k?? t???",
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
                                                    "4.2 S??? ti???n c???n cho m???c ????ch s??? d???ng v???n",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "4.3 S??? ti???n th??nh vi??n ???? c??",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "4.4 S??? ti???n th??nh vi??n c???n vay",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "4.5 Th???i ??i???m s??? d???ng v???n vay",
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
                                                    "4. Th??ng tin v??? nhu c???u v???n",
                                                width: screenWidth * 1,
                                                onTap: () {
                                                  dialogCustomForCEP(
                                                      context,
                                                      "Th??ng tin v??? nhu c???u v???n",
                                                      _copyInfoLoanDemand,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Ng??y kh???o s??t: ",
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
                                                                "* M???c ????ch s??? d???ng v???n: ",
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
                                                                "* S??? ti???n c???n cho m???c ????ch: ",
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
                                                                "* S??? ti???n th??nh vi??n ???? c??: ",
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
                                                                "* S??? ti???n th??nh vi??n c???n vay: ",
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
                                                                "* Th???i ??i???m s??? d???ng v???n vay: ",
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

                                              /// 4. Th??ng tin v??? thu nh???p, chi ph??, t??ch l??y h??? gia ????nh th??nh vi??n

                                              CardCustomizeWidget(
                                                isShowCopyIcon: isDataHistory,
                                                children: [
                                                  Text(
                                                    "5.1 T???ng s??? v???n ?????u t?? cho ho???t ?????ng t??ng thu nh???p/ m??a v???",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "5.2 T???ng thu nh???p h??? gia ????nh h??ng th??ng",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "* Thu nh???p r??ng h??ng th??ng t??? ho???t ?????ng t??ng thu nh???p/ m??a v???",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "* Thu nh???p ch???ng/v???",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "* Thu nh???p con",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "* Thu nh???p t??? ngu???n kh??c",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "5.3 Nhu nh???p b??nh qu??n ?????u ng?????i h??ng th??ng",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "5.4 T???ng chi ph?? h??? gia ????nh h??ng th??ng",
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
                                                              "Ng?????i tr??? l???i bi???t t???ng chi ph?? c??? th???",
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
                                                                    "Nh???p s??? ti???n...",
                                                                    suffixText:
                                                                        "VN??"),
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
                                                            "* Chi ph?? ??i???n, n?????c",
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
                                                                      "Nh???p s??? ti???n...",
                                                                      suffixText:
                                                                          "VN??"),
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
                                                            "* Chi ph?? ??n u???ng",
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
                                                                      "Nh???p s??? ti???n...",
                                                                      suffixText:
                                                                          "VN??"),
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
                                                            "* Chi ph?? h???c t???p",
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
                                                                      "Nh???p s??? ti???n...",
                                                                      suffixText:
                                                                          "VN??"),
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
                                                            "* Chi ph?? kh??c",
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
                                                                      "Nh???p s??? ti???n...",
                                                                      suffixText:
                                                                          "VN??"),
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
                                                    "5.5 Chi ph?? ??ang tr??? ti???n vay CEP h??ng th??ng (n???u c??) (Khi kh???o s??t th??nh vi??n vay v???n b??? sung ho???c kh???n c???p)",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "5.6 T??ch l??y h??? gia ????nh h??ng th??ng",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "5.7 T??ch l??y h??ng th??ng d??? ki???n t??ng th??m khi s??? d???ng kho???n vay",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                      "Th??ng tin v??? thu nh???p, chi ph??, t??ch l??y",
                                                      _copyInfoIcome,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Ng??y kh???o s??t: ",
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
                                                                "* T???ng v???n ?????u t?? ho???t ?????ng t??ng thu nh???p/m??a v???: ",
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
                                                                "* T???ng thu nh???p h??ng th??ng: ",
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
                                                                "* GDP b??nh qu??n ?????u ng?????i h??ng th??ng: ",
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
                                                                "* T???ng chi ph?? h??ng th??ng: ",
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
                                                                "* Chi ph?? tr??? g??p h??ng th??ng: ",
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
                                                                "* T??ch l??y h??ng th??ng: ",
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
                                                                "* T??ch l??y h??ng th??ng t??ng th??m khi s??? d???ng kho???n vay: ",
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
                                                    "5. Th??ng tin v??? thu nh???p, chi ph??, t??ch l??y h??? gia ????nh th??nh vi??n",
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
                        /// VAY NGU???N KH??C PAGE ///
                        new Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                new Center(
                                  child: Text(
                                    "Th??ng Tin Kh??c",
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
                                                    "6.1 Ngu???n vay 1",
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
                                                              "S??? ti???n",
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
                                                                    "Nh???p s??? ti???n...",
                                                                    suffixText:
                                                                        "VN??"),
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
                                                              "L?? do vay",
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
                                                              "Th???i ??i???m t???t to??n",
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
                                                              "Bi???n ph??p th???ng nh???t",
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
                                                    "6.2 Ngu???n vay 2",
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
                                                              "S??? ti???n",
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
                                                                    "Nh???p s??? ti???n...",
                                                                    suffixText:
                                                                        "VN??"),
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
                                                              "L?? do vay",
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
                                                              "Th???i ??i???m t???t to??n",
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
                                                              "Bi???n ph??p th???ng nh???t",
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
                                                    "6. Th??nh vi??n c?? ??ang vay ngu???n v???n kh??c",
                                                width: screenWidth * 1,
                                              ),
                                              CardCustomizeWidget(
                                                isShowCopyIcon: isDataHistory,
                                                children: [
                                                  Text(
                                                    "Th??nh vi??n thu???c di???n",
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
                                                    "M?? s??? h??? ngh??o, h??? c???n ngh??o",
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
                                                              "Nh???p ch??? v?? s???"),
                                                      keyboardType:
                                                          TextInputType.text,
                                                      // Only numbers can be entered
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "T??n ch??? h???",
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
                                                              "Nh???p ch??? c?? d???u ho???c kh??ng d???u"),
                                                      keyboardType:
                                                          TextInputType.text,
                                                      // Only numbers can be entered
                                                    ),
                                                  ),
                                                ],
                                                onTap: () {
                                                  dialogCustomForCEP(
                                                      context,
                                                      "Th??nh vi??n thu???c di???n",
                                                      _copyTypeMember,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Ng??y kh???o s??t: ",
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
                                                                "* Th??nh vi??n thu???c di???n: ",
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
                                                                widget
                                                                    .listCombobox
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
                                                                "* M?? s??? h??? ngh??o: ",
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
                                                                "* H??? t??n ch??? h???: ",
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
                                                    "7. Th??nh vi??n thu???c di???n",
                                                width: screenWidth * 1,
                                              ),
                                              CardCustomizeWidget(
                                                //isShowCopyIcon: isDataHistory,
                                                children: [
                                                  Text(
                                                    "S??? ti???n g???i m???i k???",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "8. Th??nh vi??n c?? tham gia g???i ti???t ki???m ?????nh h?????ng?",
                                                width: screenWidth * 1,
                                              ),
                                              CardCustomizeWidget(
                                                children: [
                                                  Text(
                                                    "Ti???t ki???m b???t bu???c",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "Ti???t ki???m ?????nh h?????ng",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "Ti???t ki???m linh ho???t",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "Th???i ??i???m r??t",
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
                                                    "9. Th??nh vi??n c?? tham gia g???i ti???t ki???m ?????nh h?????ng?",
                                                width: screenWidth * 1,
                                              ),
                                              CardCustomizeWidget(
                                                children: [
                                                  Text(
                                                    "M???c vay b??? sung",
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
                                                              "Nh???p s??? ti???n...",
                                                              suffixText:
                                                                  "VN??"),
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
                                                    "M???c ????ch vay v???n b??? sung",
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
                                                    "Ng??y nh???n v???n b??? sung",
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
                                                    "10. Th??nh vi??n c?? ????ng k?? vay b??? sung",
                                              )

                                              /// 4. Th??ng tin v??? thu nh???p, chi ph??, t??ch l??y h??? gia ????nh th??nh vi??n
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
                        /// ????NH GI?? PAGE ///
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
                                      "????nh Gi?? V?? ????? Xu???t Duy???t Vay C???a Nh??n Vi??n T??n D???ng",
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
                                                      "11. Lo???i h??? ngh??o c???a th??nh vi??n vay l???n 1",
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
                                                                "Nh???p ch??? c?? d???u ho???c kh??ng d???u"),
                                                        //keyboardType: TextInputType.text,
                                                        // Only numbers can be entered
                                                      ),
                                                    ),
                                                  ],
                                                  onTap: () {
                                                    dialogCustomForCEP(
                                                        context,
                                                        "Ghi ch?? c???a CBQL",
                                                        _copyNoted,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Ng??y kh???o s??t: ",
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
                                                      "12. Ghi ch?? c???a nh??n vi??n t??n d???ng",
                                                  width: screenWidth * 1,
                                                ),
                                                CardCustomizeWidget(
                                                  children: [
                                                    Text(
                                                      "S??? ti???n",
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
                                                                "Nh???p s??? ti???n...",
                                                                suffixText:
                                                                    "VN??"),
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
                                                      "Ti???t ki???m ?????nh h?????ng",
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
                                                                "Nh???p s??? ti???n...",
                                                                suffixText:
                                                                    "VN??"),
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
                                                      "M???c ????ch",
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
                                                  title: "13. ????? xu???t",
                                                  width: screenWidth * 1,
                                                ),
                                                CardCustomizeWidget(
                                                  children: [
                                                    RawMaterialButton(
                                                      fillColor: Colors.green,
                                                      splashColor: Colors.blue,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: const <
                                                              Widget>[
                                                            Text(
                                                              "Ph??t Tri???n C???ng ?????ng",
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        onSaveDataToCommunityDevelopment();
                                                      },
                                                      shape:
                                                          const StadiumBorder(),
                                                    ),
                                                  ],
                                                  title:
                                                      "14. Tham gia ch????ng tr??nh Ph??t Tri???n C???ng ?????ng",
                                                  width: screenWidth * 1,
                                                ),

                                                /// 4. Th??ng tin v??? thu nh???p, chi ph??, t??ch l??y h??? gia ????nh th??nh vi??n
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
    // dialogCustomForCEP(context, "B???n c?? mu???n l??u d??? li???u kh???o s??t ?", _onSubmit,
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
          context, "B???n c?? mu???n l??u d??? li???u kh???o s??t ?", _onSubmit,
          children: [], width: screenWidth * 0.7);
    }
  }

  @override
  bool get wantKeepAlive => true;

  onSaveDataToCommunityDevelopment() {
    List<KhachHang> listKhachang = new List<KhachHang>();
    KhachHang model = new KhachHang();
    model.maKhachHang = widget.surveyInfo.chinhanhId.toString() +
        '_' +
        widget.surveyInfo.thanhvienId;
    model.chinhanhId = widget.surveyInfo.chinhanhId.toDouble();
    model.duanId = widget.surveyInfo.duanId.toDouble();
    model.masoql = widget.surveyInfo.masoCanBoKhaoSat;
    model.cumId = widget.surveyInfo.cumId;
    model.hoTen = widget.surveyInfo.hoVaTen;
    model.thanhVienId = widget.surveyInfo.thanhvienId;
    model.cmnd = widget.surveyInfo.cmnd;
    model.gioitinh = widget.surveyInfo.gioiTinh.toDouble();
    model.ngaysinh = widget.surveyInfo.ngaySinh;
    model.diachi = widget.surveyInfo.diaChi;
    model.dienthoai = "";
    model.lanvay = widget.surveyInfo.lanvay.toDouble();
    model.thoigianthamgia = widget.surveyInfo.thoigianthamgia;
    model.thanhVienThuocDien = widget.surveyInfo.thanhVienThuocDien.isEmpty
        ? 0
        : double.parse(widget.surveyInfo.thanhVienThuocDien);
    model.maHongheoCanngheo = widget.surveyInfo.maSoHoNgheo;
    model.ngheNghiep = 0;
    model.ghiChu = "";
    model.moHinhNghe = false;
    model.thunhapHangthangCuaho = 0;
    model.coVoChongConLaCnv = false;
    listKhachang.add(model);
    surVeyBloc.emitEvent(InsertNewCommunityDevelopment(context, listKhachang));
  }
}
