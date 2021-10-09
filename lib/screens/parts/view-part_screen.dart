import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/utils/settings.dart';
import 'package:riyasewana/widgets/contact_button.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_slider.dart';
import 'package:riyasewana/widgets/custom_textboxCol.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:intl/intl.dart';
import '../../styles.dart';

class ViewPartScreen extends StatefulWidget {
  @override
  _ViewPartScreenState createState() => _ViewPartScreenState();

  String adID = "";

  ViewPartScreen({required this.adID});
}

String _postDate = "2021-04-21";
String _pName = "";
String _pPrice = "";
bool _negotiable = true;
String _pLocation = "";
String _pCondition = "";
String _pInfo = "";
String _posted = "";

bool _bookmark = true;
List<dynamic> _imgList = [];

String _uid = "";
String _token = "";
String _phoneNumber = "";

class _ViewPartScreenState extends State<ViewPartScreen> {
  void getUser() async {
    await Settings.getUserID().then((value) => {_uid = value!});
    await Settings.getAccessToken().then((value) => {_token = value!});
    await Settings.getUserPhone().then((value) => {_phoneNumber = value!});

    setState(() {});
  }

  void getAdData() async {
    // print("++++++++++++++++++++++++++++++++++++++++++++++++++");
    final response = await ApiCalls.partGet(adID: widget.adID);

    if (response.isSuccess) {
      _pName = response.jsonBody["pName"];
      _pPrice = response.jsonBody["pPrice"];
      _pLocation = response.jsonBody["pLocation"];
      _pCondition = response.jsonBody["pCondition"];
      _pInfo = response.jsonBody["pInfo"];

      _imgList = response.jsonBody["pImages"];
      DateTime date = DateTime.parse(response.jsonBody["updatedAt"]);

      _posted = DateFormat('yyyy-MM-dd').format(date);

      print(_posted);

      if (response.jsonBody['pNegotiate'] == "true") {
        _negotiable = true;
      } else {
        _negotiable = false;
      }
    } else {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
    getAdData();
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
          "Posted on " + _posted,
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
                  onTap: () => {UrlLauncher.launch('tel:+${_phoneNumber}')},
                  child: ContactButton(call: true),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 330, left: 200),
                child: GestureDetector(
                  onTap: () => {UrlLauncher.launch('sms:+${_phoneNumber}')},
                  child: ContactButton(call: false),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 380),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomColTextbox(header: "Location", info: _pLocation),
                      CustomColTextbox(header: "Condition", info: _pCondition),
                      CustomColTextbox(header: "More details", info: _pInfo),
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
