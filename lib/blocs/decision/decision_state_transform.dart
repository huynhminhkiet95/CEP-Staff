import 'package:qr_code_demo/bloc_helpers/bloc_state_transform_base.dart';
import 'package:qr_code_demo/blocs/authentication/authentication_bloc.dart';
import 'package:qr_code_demo/blocs/authentication/authentication_state.dart';
import 'package:qr_code_demo/blocs/decision/decision_state_action.dart';
import 'package:qr_code_demo/ui/screens/Home/dashboard.dart';
import 'package:qr_code_demo/ui/screens/Login/welcomePage.dart';

class DecisionStateTransform
    extends BlocStateTransformBase<DecisionStateAction, AuthenticationState> {
  DecisionStateTransform({
    DecisionStateAction initialAction,
    AuthenticationBloc blocIn,
  })  : assert(blocIn != null),
        super(initialState: initialAction, blocIn: blocIn);

  //
  // Take initial action, based on the authentication status
  //
  factory DecisionStateTransform.init(AuthenticationBloc blocIn) {
    AuthenticationState authenticationState = blocIn.lastState;
    DecisionStateAction action;
    // String token = globalUser.gettoken;

    if (authenticationState == null || !authenticationState.isAuthenticated) {
      action = DecisionStateAction.routeToPage(WelcomePage());
    } else {
      action = DecisionStateAction.routeToPage(MenuDashboardPage());
    }
    // if (token != null && token != "") {
    //   action = DecisionStateAction.routeToPage(MenuDashboardPage());
    // }

    // authenticationState == null || !authenticationState.isAuthenticated
    //     ? DecisionStateAction.routeToPage(MenuDashboardPage())
    //     : DecisionStateAction.routeToPage(MenuDashboardPage());

    return DecisionStateTransform(
      initialAction: action,
      blocIn: blocIn,
    );
  }

  ///
  /// Business Logic
  ///
  @override
  Stream<DecisionStateAction> stateHandler(
      {DecisionStateAction currentState, AuthenticationState newState}) async* {
    DecisionStateAction action = DecisionStateAction.doNothing();

    if (newState.isAuthenticated) {
      action = DecisionStateAction.routeToPage(MenuDashboardPage());
    } else if (newState.isAuthenticating || newState.hasFailed) {
      // do nothing
    } else if (!newState.isAuthenticating &&
        (newState.userIsNotExit == true || newState.hasFailed == true)) {
    } else {
      action = DecisionStateAction.routeToPage(WelcomePage());
    }
    yield action;
  }
}
