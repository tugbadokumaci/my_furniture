import 'package:flutter/material.dart';
import 'package:my_furniture/product/model/basic_model.dart';
import 'package:my_furniture/view/login/login_view.dart';

mixin LoginViewMixin on State<LoginView> {
  final TextEditingController _userNameController = TextEditingController();
  ValueNotifier<bool> isValidForTextController = ValueNotifier<bool>(false);

  TextEditingController get getUserNameController => _userNameController;
  String get valueFromNameController => _userNameController.text;
  BasicModel get basicModel => BasicModel(valueFromNameController);

  void onControllerChange(String value) {
    isValidForTextController.value = value.length > 3;
  }

  Future<void> controlToResult({bool result = false}) async {
    if (result) {
      await Navigator.of(context).pushNamed('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error'),
        ),
      );
    }
  }
}
