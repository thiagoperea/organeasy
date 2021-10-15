import 'package:flutter/foundation.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {
  // no actions
}

class HomeActionMenuPressed extends HomeState {
  final HomeActions action;

  HomeActionMenuPressed(this.action);
}

enum HomeActions { screenHelp }
