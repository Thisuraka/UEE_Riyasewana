import 'package:flutter/material.dart';
import '../../styles.dart';

class CustomAppbarWidget extends StatelessWidget {
  String mainTitle = "Riyasewana";
  bool leadingImg;
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
      leading: leadingImg
          ? Image.asset('assets/icons/profile-default.png')
          : Image.asset('assets/icons/arrow-left.png'),
      title: logo
          ? Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text("Riyasewana", style: LogoText))
          : Text(
              mainTitle,
              style: HeaderStyle,
            ),
      actions: [
        Container(
            child: searchIcon
                ? Image.asset(
                    'assets/icons/search-icon.png',
                    width: 50,
                  )
                : null),
      ],
    );
  }
}


// Image.asset('assets/icons/profile-default.png')