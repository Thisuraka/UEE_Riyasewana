import 'package:flutter/material.dart';
import 'package:riyasewana/widgets/contact_button.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_slider.dart';
import 'package:riyasewana/widgets/custom_textboxCol.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../styles.dart';

class ViewVehicleScreen extends StatefulWidget {
  @override
  _ViewVehicleScreenState createState() => _ViewVehicleScreenState();
}

String _postDate = "2021-04-21";
String _vName = "Nissan Silvia S15 - 1992";
String _vPrice = "9,400,000";
bool _negotiable = false;
bool _bookmark = false;

List<String> _imgList = [
  'assets/images/car1.jpg',
  'assets/images/car2.jpg',
  'assets/images/car3.jpg',
  'assets/images/car4.jpg',
  'assets/images/car5.jpg'
];

class _ViewVehicleScreenState extends State<ViewVehicleScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: CustomAppbarWidget(
              mainTitle: "",
              leadingImg: false,
              logo: true,
              searchIcon: false,
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Posted on " + _postDate,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: DefaultColor,
                  fontSize: 15),
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                CustomSlider(
                  imgList: _imgList,
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 250),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          _vName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 34),
                        child: Text(
                          "Rs. " + _vPrice,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 37, left: 100),
                        child: _negotiable
                            ? Text(
                                " - " + "Negotiable ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              )
                            : Text(
                                " - " + "Non-negotiable ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                      ),
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(top: 10, left: 335),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _bookmark = !_bookmark;
                            });
                          },
                          child: _bookmark
                              ? Image.asset(
                                  'assets/icons/bookmark.png',
                                  fit: BoxFit.contain,
                                )
                              : Image.asset('assets/icons/notBookmark.png',
                                  fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 330),
                  child: GestureDetector(
                    onTap: () => {},
                    child: ContactButton(call: true),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 330, left: 200),
                  child: GestureDetector(
                    onTap: () => {},
                    child: ContactButton(call: false),
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        // CustomColTextbox(controller: controller, hint: hint, labelText: labelText, prifixIcon: prifixIcon, onTap: onTap)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
