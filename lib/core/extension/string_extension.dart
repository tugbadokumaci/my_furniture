import 'package:easy_localization/easy_localization.dart';
import 'package:my_furniture/core/constants/app/app_constants.dart';

extension StringLolization on String {
  String get locale => this.tr();

  String? get isValidEmail => contains(RegExp(ApplicationConstants.EMAIL_REGEX)) ? null : "Email not valid";
}
