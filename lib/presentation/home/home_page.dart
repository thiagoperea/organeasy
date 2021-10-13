import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organeasy/presentation/dashboard/dashboard_page.dart';
import 'package:organeasy/presentation/goals/goals_page.dart';
import 'package:organeasy/presentation/investments/investments_page.dart';
import 'package:organeasy/presentation/settings/settings_page.dart';
import 'package:organeasy/presentation/transactions/transactions_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  final List<String> _pageTitles = [
    "Resumo",
    "Transações",
    "Metas e Objetivos",
    "Investimentos",
    "Configurações",
  ];

  final List<Widget> _appPages = [
    const DashboardPage(),
    const TransactionsPage(),
    const GoalsPage(),
    const InvestmentsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pageTitles[_pageIndex])),
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
              title: Text(_pageTitles[0]),
              onTap: () => _onDrawerTap(0),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.listAlt),
              title: Text(_pageTitles[1]),
              onTap: () => _onDrawerTap(1),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.bullseye),
              title: Text(_pageTitles[2]),
              onTap: () => _onDrawerTap(2),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.seedling),
              title: Text(_pageTitles[3]),
              onTap: () => _onDrawerTap(3),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.userCog),
              title: Text(_pageTitles[4]),
              onTap: () => _onDrawerTap(4),
            ),
          ],
        ),
      ),
      body: _appPages[_pageIndex],
    );
  }

  void _onDrawerTap(int idx) {
    setState(() {
      _pageIndex = idx;
    });

    Navigator.of(context).pop();
  }
}
