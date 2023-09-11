import 'package:my_furniture/core/base/model/base_view_model.dart';
import 'package:my_furniture/product/model/user_model.dart';

class HomeViewModel extends BaseViewModel {
  final UserModel service;
  HomeViewModel(this.service) : super();

  @override
  void init() {}

  @override
  // TODO: implement data
  get data => throw UnimplementedError();
}
