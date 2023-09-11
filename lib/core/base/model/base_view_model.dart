import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_furniture/core/base/state/base_state.dart';

abstract class BaseViewModel extends Cubit<BaseState> {
  BaseViewModel() : super(BaseInitialState()) {
    load();
  }

  bool _isLoading = false;
  bool _isDisposed = false;

  FutureOr<void> _initState;

  FutureOr<void> init();

  void load() async {
    isLoading = true;
    _initState = init();
    await _initState;
  }

  //Getters
  bool get isLoading => _isLoading;
  bool get isDisposed => _isDisposed;

  dynamic get data;

  //Setters
  set isLoading(bool value) {
    _isLoading = value;
    if (!_isDisposed && _isLoading) emit(BaseLoadingSate());
  }

  @override
  Future<void> close() async {
    _isDisposed = true;
    super.close();
  }
}
