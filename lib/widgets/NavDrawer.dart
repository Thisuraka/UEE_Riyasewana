import 'package:flutter/material.dart';
import 'package:riyasewana/screens/account/favorites_screen.dart';
import 'package:riyasewana/screens/account/user-profile_screen.dart';
import 'package:riyasewana/screens/home_screen.dart';
import 'package:riyasewana/styles.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            children: [
              Image.asset(
                'assets/images/nav.jpg',
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.grey,
                width: double.infinity,
                height: 2,
                margin: EdgeInsets.only(top: 290),
              )
            ],
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
          )
        ],
      ),
    );
  }
}
