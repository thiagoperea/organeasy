import 'package:flutter/material.dart';
import 'package:organeasy/presentation/splash/splash_page.dart';

Future<void> main() async => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organeasy',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
