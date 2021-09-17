import 'package:flutter/material.dart';
import '../../styles.dart';

class CustomAppbarWidget extends StatelessWidget {
  String mainTitle = "Riyasewana";
  String leadingImg;
  bool logo;
  bool searchIcon;

  CustomAppbarWidget(
      {required this.mainTitle,
      required this.leadingImg,
      required this.logo,
      required this.searchIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Image.asset(leadingImg),
      title: logo
          ? Padding(
              padding: EdgeInsets.only(left: 45),
              child: Text("Riyasewana", style: LogoText))
          : Text(
              mainTitle,
              style: HeaderStyle,
            ),
      actions: [
        Image.asset(
          'assets/icons/search-icon.png',
          width: 50,
        ),
      ],
    );
  }
}


// Image.asset('assets/icons/profile-default.png')