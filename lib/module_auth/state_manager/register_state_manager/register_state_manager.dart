import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/module_auth/enums/auth_status.dart';
import 'package:pasco_shipping/module_auth/enums/user_type.dart';
import 'package:pasco_shipping/module_auth/service/auth_service/auth_service.dart';
import 'package:pasco_shipping/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:pasco_shipping/module_auth/ui/states/register_states/register_state.dart';
import 'package:pasco_shipping/module_auth/ui/states/register_states/register_state_code_sent.dart';
import 'package:pasco_shipping/module_auth/ui/states/register_states/register_state_error.dart';
import 'package:pasco_shipping/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:pasco_shipping/module_auth/ui/states/register_states/register_state_success.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class RegisterStateManager {
  final AuthService _authService;
  final _registerStateSubject = PublishSubject<RegisterState>();

  late RegisterScreenState _registerScreen;

  RegisterStateManager(this._authService) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
        //to set init state in data
          // _aboutService.setInited().then((value) {
            
          // });
          _registerStateSubject.add(RegisterStateSuccess(_registerScreen));
          break;
        case AuthStatus.CODE_SENT:
          _registerStateSubject
              .add(RegisterStatePhoneCodeSent(_registerScreen));
          break;
        case AuthStatus.CODE_TIMEOUT:
          _registerStateSubject
              .add(RegisterStateError(_registerScreen, 'Code Timeout'));
          break;
        default:
          _registerStateSubject.add(RegisterStateInit(_registerScreen));
          break;
      }
    }).onError((err) {
      _registerStateSubject
          .add(RegisterStateError(_registerScreen, err.toString()));
    });
  }

  Stream<RegisterState> get stateStream => _registerStateSubject.stream;

  void registerCaptain(
    String phoneNumber,
    RegisterScreenState _registerScreenState,
  ) {
    _registerScreen = _registerScreenState;
    _authService.verifyWithPhone(true, phoneNumber, UserRole.ROLE_CAPTAIN);
  }

  void registerOwner(String email, String name, String password,
      RegisterScreenState _registerScreenState) {
    _registerScreen = _registerScreenState;

    _authService.registerWithEmailAndPassword(
        email, password, name, UserRole.ROLE_OWNER);
  }

  void confirmCaptainCode(String smsCode) {
    _authService.confirmWithCode(smsCode, UserRole.ROLE_CAPTAIN, true);
  }
}
