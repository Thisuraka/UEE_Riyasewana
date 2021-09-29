import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:riyasewana/screens/account/favorites_screen.dart';
import 'package:riyasewana/screens/account/user-profile_screen.dart';
import 'package:riyasewana/screens/home_screen.dart';
import 'package:riyasewana/styles.dart';

class NavDrawer extends StatefulWidget {
  String profileImg = '';

  NavDrawer({required this.profileImg});

  @override
  _NavDrawerScreen createState() => _NavDrawerScreen();
}

class _NavDrawerScreen extends State<NavDrawer> {
  String _defaultImg = 'assets/images/nav.jpg';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            children: [
              Blur(
                blur: 3.5,
                blurColor: Colors.black,
                child: Container(
                  color: Colors.white,
                  height: 220,
                  width: 310,
                  child: Image.asset(
                    widget.profileImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.only(top: 120, left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  child: Image.asset(
                    widget.profileImg,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              Container(
                color: DefaultColor,
                width: double.infinity,
                height: 4,
                margin: EdgeInsets.only(top: 220),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Image.asset(
              'assets/icons/home-grey.png',
            ),
            title: Text('Home'),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              )
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/icons/fav-grey.png',
            ),
            title: Text('My account'),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                ),
              )
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/icons/profile-grey.png',
            ),
            title: Text('My Favourites'),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserProfile(),
                ),
              )
            },
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 120, top: 320),
              child: Text(
                "Donate",
                style: SeeAllStyle,
              ),
            ),
          )
        ],
      ),
    );
  }
}
