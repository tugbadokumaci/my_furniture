import 'package:flutter/material.dart';
import 'package:my_furniture/core/base/view/base_view.dart';

class HomeView extends BaseView<HomeCubit> {
  const HomeView({super.key, required super.viewModel, required super.onPageBuilder, required super.onModelReady});

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
