abstract class IErrorModel {
  final String? message;
  final int? statusCode;
  IErrorModel({this.message, this.statusCode});
}

abstract class IResponseModel<T> {
  T? data;
  IErrorModel? error;
}
