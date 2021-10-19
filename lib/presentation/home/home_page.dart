import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organeasy/presentation/dashboard/dashboard_page.dart';
import 'package:organeasy/presentation/goals/goals_page.dart';
import 'package:organeasy/presentation/home/cubit/home_cubit.dart';
import 'package:organeasy/presentation/home/cubit/home_state.dart';
import 'package:organeasy/presentation/investments/investments_page.dart';
import 'package:organeasy/presentation/settings/settings_page.dart';
import 'package:organeasy/presentation/transactions/transactions_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final List<String> _appTitles = const [
    "Resumo",
    "Transações",
    "Metas",
    "Investimentos",
    "Configurações",
  ];

  final List<Widget> _appPages = const [
    const DashboardPage(),
    const TransactionsPage(),
    const GoalsPage(),
    const InvestmentsPage(),
    const SettingsPage(),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Widget _page;
  late String _title;
  late List<Widget> _actions;
  late final HomeCubit _cubit;

  @override
  void initState() {
    _page = widget._appPages[0];
    _title = widget._appTitles[0];
    _actions = _getActions(0);
    _cubit = HomeCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: _actions,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                child: Text(
                  'Organeasy',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard_rounded),
                title: Text(widget._appTitles[0]),
                onTap: () => _onDrawerTap(0),
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.listAlt),
                title: Text(widget._appTitles[1]),
                onTap: () => _onDrawerTap(1),
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.bullseye),
                title: Text(widget._appTitles[2]),
                onTap: () => _onDrawerTap(2),
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.seedling),
                title: Text(widget._appTitles[3]),
                onTap: () => _onDrawerTap(3),
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.userCog),
                title: Text(widget._appTitles[4]),
                onTap: () => _onDrawerTap(4),
              ),
            ],
          ),
        ),
        body: _page,
      ),
    );
  }

  void _onDrawerTap(int idx) {
    setState(() {
      _page = widget._appPages[idx];
      _title = widget._appTitles[idx];
      _actions = _getActions(idx);
    });

    Navigator.of(context).pop();
  }

  List<Widget> _getActions(int idx) {
    final List<Widget> actions = List.empty(growable: true);

    switch (idx) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
    }

    /// INFO: every screen has a info button
    actions.add(
      IconButton(
        onPressed: () => _cubit.onActionMenuPressed(HomeActions.screenHelp),
        icon: Icon(Icons.info),
      ),
    );

    return actions;
  }
}
