import 'package:my_furniture/core/init/network/IResponseModel.dart';

class BaseError<T> extends IErrorModel {
  BaseError(this.message);
  final String message;
}
