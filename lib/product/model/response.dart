import 'package:my_furniture/core/init/network/IResponseModel.dart';

class ResponseModel<T> extends IResponseModel<T> {
  ResponseModel({this.data, this.error});
  @override
  final T? data;
  @override
  final IErrorModel? error;
}
