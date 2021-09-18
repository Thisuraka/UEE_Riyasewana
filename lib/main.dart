import 'package:flutter/material.dart';
// import 'package:riyasewana/screens/onboarding/splash_screen.dart';
// import 'package:riyasewana/screens/onboarding/login_screen.dart';
// import 'package:riyasewana/screens/onboarding/register_screen.dart';
// import 'package:riyasewana/screens/account/user-profile_screen.dart';
import 'package:riyasewana/screens/home_screen.dart';

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
      home: HomeScreen(),
    );
  }
}
// UserProfile(),
// RegisterScreen(),
// LoginScreen(),
// SplashScreen(),