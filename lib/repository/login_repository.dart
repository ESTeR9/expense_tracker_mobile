import 'package:network/dio_client.dart';

import 'endpoints/login_api.dart';
import '../model/user.dart';

class LoginRepository {
  late LoginApi _loginApi;

  LoginRepository() {
    final DioClient dioClient = DioClient();
    _loginApi = LoginApi(dioClient.dio);
  }

  Future<bool?> login(User user) async {
    bool loginResponse = false;
    try {
      loginResponse = await _loginApi.login(user);
    } catch (e) {
      return false;
    }
    return loginResponse;
  }
}
