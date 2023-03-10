import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/user.dart';

part 'login_api.g.dart';

@RestApi()
abstract class LoginApi {
  factory LoginApi(Dio dio) = _LoginApi;

  @POST("/user/login")
  Future<bool> login([@Body() User? user]);
}
