import 'package:qr_code_demo/GlobalTranslations.dart';
import 'package:qr_code_demo/GlobalUser.dart';
import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/blocs/setting/setting_event.dart';
import 'package:qr_code_demo/blocs/setting/setting_state.dart';
import 'package:qr_code_demo/config/toast_result_message.dart';
import 'package:qr_code_demo/services/commonService.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:rxdart/rxdart.dart';

class SettingBloc extends BlocEventStateBase<SettingEvent, SettingState> {
  final SharePreferenceService sharePreferenceService;
  final CommonService commonService;

  SettingBloc(this.sharePreferenceService, this.commonService)
      : super(initialState: SettingState.init());

  BehaviorSubject<bool> _getIsAuthenLocal = BehaviorSubject<bool>();
  Stream<bool> get getIsAuthenLocal => _getIsAuthenLocal;

  @override
  void dispose() {
    //_getSurveyController?.close();
    super.dispose();
  }

  @override
  Stream<SettingState> eventHandler(
      SettingEvent event, SettingState state) async* {
    if (event is LoadAuthenLocalEvent) {
      yield SettingState.updateLoading(true);
      this.sharePreferenceService.getAuthenLocal();
      _getIsAuthenLocal.add(globalUser.getAuthenLocal);
    }
    if (event is UpdateAuthenLocalEvent) {
      yield SettingState.updateLoading(true);

      if (event.isAuthenRadio == false) {
        if (event.password == globalUser.getPassword) {
          this.sharePreferenceService.saveAuthenLocal(true);
          _getIsAuthenLocal.add(true);
          ToastResultMessage.success(allTranslations.text("AuthenSuccess"));
        } else {
          _getIsAuthenLocal.add(false);
          ToastResultMessage.error(allTranslations.text("PassNotCorrect"));
        }
      } else {
        if (event.password == globalUser.getPassword) {
          this.sharePreferenceService.saveAuthenLocal(false);
          _getIsAuthenLocal.add(false);
          ToastResultMessage.success(allTranslations.text("UnAuthenSuccess"));
        } else {
          _getIsAuthenLocal.add(true);
          ToastResultMessage.error(allTranslations.text("PassNotCorrect"));
        }
      }
    }
  }
}
