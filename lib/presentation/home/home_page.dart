import 'package:flutter/material.dart';
import 'package:organeasy/presentation/dashboard/dashboard_page.dart';
import 'package:organeasy/presentation/settings/settings_page.dart';
import 'package:organeasy/presentation/transactions/transactions_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  int _pageIndex = 0;

  final List<Widget> _appPages = [
    const DashboardPage(),
    const TransactionsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard_rounded),
              title: const Text('Dashboard'),
              onTap: () => _onDrawerTap(0),
            ),
            ListTile(
              leading: const Icon(Icons.playlist_add_rounded),
              title: const Text('Transactions'),
              onTap: () => _onDrawerTap(1),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => _onDrawerTap(2),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => _onHamburgerTap(),
              icon: const Icon(Icons.menu),
            ),
            Expanded(
              child: _appPages[_pageIndex],
            ),
          ],
        ),
      ),
    );
  }

  void _onDrawerTap(int idx) {
    setState(() {
      _pageIndex = idx;
    });

    Navigator.of(context).pop();
  }

  void _onHamburgerTap() => _scaffoldKey.currentState?.openDrawer();
}
