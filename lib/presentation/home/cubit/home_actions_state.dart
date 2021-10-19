class HomeActionsState {
  final HomeActions action;

  HomeActionsState({this.action = HomeActions.none});
}

enum HomeActions { none, screenHelp }
