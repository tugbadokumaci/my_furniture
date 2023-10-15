import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get theme => Theme.of(context);
  double dynamicHeight(double value) => MediaQuery.of(context).size.height * value;
  double dyanmicWidth(double value) => MediaQuery.of(context).size.width * value;
}

class BaseInitialState extends BaseState {
  BaseInitialState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class BaseLoadingSate extends BaseState {
  BaseLoadingSate();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class BaseCompletedState extends BaseState {
  dynamic data;
  BaseCompletedState({this.data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class BaseErrorState extends BaseState {
  final String? errorMessage;
  BaseErrorState({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
