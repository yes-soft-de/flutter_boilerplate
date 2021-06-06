import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/module_auth/enums/auth_status.dart';
import 'package:pasco_shipping/module_auth/enums/user_type.dart';
import 'package:pasco_shipping/module_auth/exceptions/auth_exception.dart';
import 'package:pasco_shipping/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:pasco_shipping/module_auth/presistance/auth_prefs_helper.dart';
import 'package:pasco_shipping/module_auth/request/login_request/login_request.dart';
import 'package:pasco_shipping/module_auth/request/register_request/register_request.dart';
import 'package:pasco_shipping/module_auth/response/login_response/login_response.dart';
import 'package:rxdart/rxdart.dart';

@Injectable()
class AuthServiceApi {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final PublishSubject<AuthStatus> _authSubject = PublishSubject<AuthStatus>();

  AuthServiceApi(
    this._prefsHelper,
    this._authManager,
  );
  Future<bool> get isLoggedIn => _prefsHelper.isSignedIn();

  Future<String?> get userID => _prefsHelper.getUserId();

  Future<UserRole> get userRole => _prefsHelper.getCurrentRole();

  Stream<AuthStatus> get authListener => _authSubject.stream;

  Future<void> _loginWithoutFirebase(
      String email, String password, var role) async {
    // Change This
    LoginResponse? loginResult = await _authManager.login(LoginRequest(
      username: email,
      password: password,
    ));

    if (loginResult == null) {
      _authSubject.addError('Error getting the token from the API');
      await logout();
      throw UnauthorizedException('Error getting the token from the API');
    }
// setInited if there is about screen in the begaining of the application

    await Future.wait([
      _prefsHelper.setEmail(email),
      //     _aboutService.setInited(),
      _prefsHelper.setPassword(password),
      _prefsHelper.setToken(loginResult.token),
      _prefsHelper.setCurrentRole(role),
    ]);

    _authSubject.add(AuthStatus.AUTHORIZED);
  }

  Future<void> _registerWithoutFirebase(
      String email, String password, var role) async {
    // Create the profile in our database
    await _authManager.register(RegisterRequest(
      userID: email,
      password: password,
      // This should change from the API side
      roles: [],
    ));
    await _loginWithoutFirebase(email, password, role);
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    UserRole role,
    bool isRegister,
  ) async {
    if (isRegister) {
      await _registerWithoutFirebase(email, password, role);
    } else {
      await _loginWithoutFirebase(email, password, role);
    }
  }

  Future<void> logout() async {
    await _prefsHelper.deleteToken();
    await _prefsHelper.cleanAll();
  }
}
