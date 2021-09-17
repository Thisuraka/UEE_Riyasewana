import 'package:flutter/material.dart';
// import 'package:riyasewana/screens/onboarding/splash_screen.dart';
import 'package:riyasewana/screens/onboarding/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      home: LoginScreen(),
    );
  }
}
// LoginScreen(),
// SplashScreen(),