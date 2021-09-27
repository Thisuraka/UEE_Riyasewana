import 'package:flutter/material.dart';
import 'package:riyasewana/widgets/contact_button.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_slider.dart';
import 'package:riyasewana/widgets/custom_textboxCol.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../styles.dart';

class ViewPartScreen extends StatefulWidget {
  @override
  _ViewPartScreenState createState() => _ViewPartScreenState();
}

String _postDate = "2021-04-21";
String _pName = "Honda CM125 Tanks";
String _pPrice = "10,000";
bool _negotiable = true;
bool _bookmark = true;

List<String> _imgList = [
  'assets/images/part1.jfif',
  'assets/images/part2.jfif',
  'assets/images/part3.jfif',
];

class _ViewPartScreenState extends State<ViewPartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: EdgeInsets.only(bottom: 10, top: 5),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.black),
          ),
        ),
        child: Text(
          "Posted on " + _postDate,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: DefaultColor, fontSize: 15),
        ),
      ),
      body: GestureDetector(
        onTap: () => {FocusScope.of(context).unfocus()},
        child: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              CustomSlider(
                imgList: _imgList,
              ),
              Container(
                height: 80,
                width: double.infinity,
                margin: EdgeInsets.only(top: 255),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        _pName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 19.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 34),
                      child: Text(
                        "Rs. " + _pPrice,
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
                      height: 30,
                      margin: EdgeInsets.only(top: 15, left: 335),
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
                margin: EdgeInsets.only(top: 380),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomColTextbox(header: "Location", info: "Colombo 05"),
                      CustomColTextbox(header: "Condition", info: "Used"),
                      CustomColTextbox(
                          header: "More details",
                          info:
                              "CM125 tanks \nFirst one has a bit of rust \nNo brokers \nOriginal Japan"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
