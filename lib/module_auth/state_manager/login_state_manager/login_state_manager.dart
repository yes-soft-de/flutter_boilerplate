import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/module_auth/enums/auth_status.dart';
import 'package:pasco_shipping/module_auth/enums/user_type.dart';
import 'package:pasco_shipping/module_auth/service/auth_service/auth_service.dart';
import 'package:pasco_shipping/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:pasco_shipping/module_auth/ui/states/login_states/login_state.dart';
import 'package:pasco_shipping/module_auth/ui/states/login_states/login_state_code_sent.dart';
import 'package:pasco_shipping/module_auth/ui/states/login_states/login_state_error.dart';
import 'package:pasco_shipping/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class LoginStateManager {
  final AuthService _authService;
  final PublishSubject<LoginState> _loginStateSubject =
      PublishSubject<LoginState>();

  late String _email;
  late String _password;

  late LoginScreenState _screenState;

  LoginStateManager(this._authService) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          checkInited(_screenState);
          break;
        case AuthStatus.CODE_SENT:
          _loginStateSubject.add(LoginStateCodeSent(_screenState));
          break;
        case AuthStatus.CODE_TIMEOUT:
          _loginStateSubject.add(LoginStateError(
              _screenState, 'Code Timeout', _email, _password));
          break;
        default:
          _loginStateSubject.add(LoginStateInit(_screenState));
          break;
      }
    }).onError((err) {
      _loginStateSubject.add(LoginStateError(
          _screenState, err.toString(), _email, _password));
    });
  }

  Stream<LoginState> get stateStream => _loginStateSubject.stream;

  void loginCaptain(String phoneNumber, LoginScreenState _loginScreenState) {
    _screenState = _loginScreenState;
    _authService.verifyWithPhone(false, phoneNumber, UserRole.ROLE_CAPTAIN);
  }

  void checkInited(LoginScreenState _loginScreenState) {
    // Check for name in Profile
    // _profileService.getProfile().then((profile) {
    //   _loginStateSubject
    //       .add(LoginStateSuccess(_loginScreenState, profile != null));
    // });
  }

  void loginOwner(
    String email,
    String password,
    LoginScreenState _loginScreenState,
  ) {
    _screenState = _loginScreenState;
    _email = email;
    _password = password;

    _authService.signInWithEmailAndPassword(
      email,
      password,
      UserRole.ROLE_OWNER,
      false,
    );
  }

  void confirmCaptainCode(String smsCode, LoginScreenState screenState) {
    _screenState = screenState;
    _authService.confirmWithCode(smsCode, UserRole.ROLE_CAPTAIN, false);
  }
}
