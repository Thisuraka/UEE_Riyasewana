import 'package:riyasewana/screens/account/favorites_screen.dart';
import 'package:riyasewana/screens/account/user-profile_screen.dart';
import 'package:riyasewana/screens/home_screen.dart';
import 'package:riyasewana/screens/onboarding/login_screen.dart';
import 'package:riyasewana/utils/settings.dart';

import '../../styles.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;

  bool _signed = false;

  getStatus() async {
    await Settings.getSigned().then((value) => {_signed = value!});
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (_currentIndex) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
        break;
      case 1:
        _signed
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                ),
              )
            : Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );

        break;
      case 2:
        _signed
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserProfile(),
                ),
              )
            : Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BottomNavigationBar(
        onTap: (index) => onTabTapped(index),
        elevation: 15.0,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              label: "",
              backgroundColor: Colors.white,
              icon: Image.asset(
                'assets/icons/home.png',
                height: 30.0,
                gaplessPlayback: true,
              )),
          BottomNavigationBarItem(
              label: "",
              backgroundColor: Colors.white,
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Image.asset(
                  'assets/icons/fav.png',
                  height: 30.0,
                  gaplessPlayback: true,
                ),
              )),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              label: "",
              icon: Image.asset(
                'assets/icons/profile.png',
                height: 30.0,
                gaplessPlayback: true,
              )),
        ],
      ),
    );
  }
}
