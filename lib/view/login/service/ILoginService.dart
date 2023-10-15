import 'package:dio/dio.dart';
import 'package:my_furniture/view/login/model/login_response_model.dart';

import '../../../core/extension/service_extension.dart';
import '../model/login_request_model.dart';

abstract class ILoginService {
  final Dio dio;

  ILoginService(this.dio);

  final String loginPath = ServicePath.LOGIN.rawValue;

  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model);
}
