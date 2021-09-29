import 'package:flutter/material.dart';
import 'package:riyasewana/screens/account/user-profile_screen.dart';
import '../../styles.dart';

class CustomAppbarWidget extends StatefulWidget {
  String mainTitle = "Riyasewana";
  bool leadingImg;
  bool logo;
  bool searchIcon;
  GlobalKey<ScaffoldState>? drawerKey = GlobalKey();

  CustomAppbarWidget(
      {required this.mainTitle,
      required this.leadingImg,
      required this.logo,
      required this.searchIcon,
      this.drawerKey});

  @override
  _CustomAppbarWidgetState createState() => new _CustomAppbarWidgetState();
}

class _CustomAppbarWidgetState extends State<CustomAppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: widget.leadingImg
          ? GestureDetector(
              onTap: () => {widget.drawerKey!.currentState?.openDrawer()},
              child: Image.asset('assets/icons/profile-default.png'))
          : GestureDetector(
              onTap: () => {Navigator.of(context).pop()},
              child: Image.asset('assets/icons/arrow-left.png')),
      title: widget.logo
          ? Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text("Riyasewana", style: LogoText))
          : Text(
              widget.mainTitle,
              style: HeaderStyle,
            ),
      actions: [
        Container(
            child: widget.searchIcon
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