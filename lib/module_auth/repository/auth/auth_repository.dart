import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/consts/urls.dart';
import 'package:pasco_shipping/module_auth/request/login_request/login_request.dart';
import 'package:pasco_shipping/module_auth/request/register_request/register_request.dart';
import 'package:pasco_shipping/module_auth/response/login_response/login_response.dart';
import 'package:pasco_shipping/module_network/http_client/http_client.dart';

@injectable
class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<bool> createUser(RegisterRequest request) async {
    var result = await _apiClient.post(
      Urls.SIGN_UP_API,
      request.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    // ignore: unnecessary_null_comparison
    return result != null;
  }

  Future<LoginResponse?> getToken(LoginRequest loginRequest) async {
    var result = await _apiClient.post(
      Urls.CREATE_TOKEN_API,
      loginRequest.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    // ignore: unnecessary_null_comparison
    if (result == null) {
      return null;
    }
    return LoginResponse.fromJson(result);
  }
}
