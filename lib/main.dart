import 'package:flutter/material.dart';
import 'package:riyasewana/screens/parts/edit-part_screen.dart';
import 'package:riyasewana/screens/testscreens/testScreen2.dart';
// import 'package:riyasewana/screens/parts/view-part_screen.dart';
// import 'package:riyasewana/screens/testScreen.dart';
// import 'package:riyasewana/screens/onboarding/splash_screen.dart';
// import 'package:riyasewana/screens/onboarding/login_screen.dart';
// import 'package:riyasewana/screens/onboarding/register_screen.dart';
// import 'package:riyasewana/screens/account/user-profile_screen.dart';
// import 'package:riyasewana/screens/account/edit-profile_screen.dart';
// import 'package:riyasewana/screens/account/favorites_screen.dart';
// import 'package:riyasewana/screens/home_screen.dart';
// import 'package:riyasewana/screens/parts/add-part_screen.dart';
// import 'package:riyasewana/screens/vehicles/vehicle-list_screen.dart';
// import 'package:riyasewana/screens/parts/part-list_screen.dart';
// import 'package:riyasewana/screens/vehicles/add-vehicle_screen.dart';
// import 'package:riyasewana/screens/vehicles/edit-vehicle_screen.dart';
// import 'package:riyasewana/screens/vehicles/view-vehicle_screen.dart';

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
      home: TestScreen2(),
    );
  }
}

// EditVehicleScreen(),
// ViewPartScreen(),
// ViewVehicleScreen(),
// AddVehicleScreen(),
// PartListScreen(),
// VehicleListScreen(),
// FavoritesScreen(),
// HomeScreen(),
// UserProfile(),
// EditProfileScreen(),
// RegisterScreen(),
// LoginScreen(),
// SplashScreen(),


// TestScreen(),
// TestScreen2(),