import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/widgets/contact_button.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_slider.dart';
import 'package:riyasewana/widgets/custom_textboxCol.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../styles.dart';

class ViewVehicleScreen extends StatefulWidget {
  @override
  _ViewVehicleScreenState createState() => _ViewVehicleScreenState();

  String adID = "";
  ViewVehicleScreen({required this.adID});
}

String _postDate = "2021-04-21";
String _vBrand = "";
String _vModel = "";
String _vPrice = "";
bool _negotiable = false;
String _vLocation = "";
String _vCondition = "";
String _vManfYear = "";
String _vTransType = "";
String _vFuelType = "";
String _vMilage = "";
String _vInfo = "";
String _posted = "";

bool _bookmark = true;
List<dynamic> _imgList = [];

class _ViewVehicleScreenState extends State<ViewVehicleScreen> {
  void getAdData() async {
    // print("++++++++++++++++++++++++++++++++++++++++++++++++++");
    final response = await ApiCalls.vehicleGet(adID: widget.adID);

    if (response.isSuccess) {
      _vBrand = response.jsonBody["vBrand"];
      _vModel = response.jsonBody["vModel"];
      _vModel = response.jsonBody["vModel"];
      _vPrice = response.jsonBody["vPrice"];
      _vLocation = response.jsonBody["vLocation"];
      _vCondition = response.jsonBody["vCondition"];
      _vManfYear = response.jsonBody["vManfYear"];
      _vTransType = response.jsonBody["vTransType"];
      _vFuelType = response.jsonBody["vFuelType"];
      _vMilage = response.jsonBody["vMilage"];
      _vInfo = response.jsonBody["vInfo"];

      _imgList = response.jsonBody["vImages"];

      DateTime date = DateTime.parse(response.jsonBody["updatedAt"]);

      _posted = DateFormat('yyyy-MM-dd').format(date);

      if (response.jsonBody['vNegotiate'] == "true") {
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
                        _vBrand + " " + _vModel,
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
                  onTap: () => {launch("tel://214324234")},
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
                      CustomColTextbox(header: "Location", info: _vLocation),
                      CustomColTextbox(header: "Brand", info: _vBrand),
                      CustomColTextbox(header: "Model", info: _vModel),
                      CustomColTextbox(
                          header: "Transmission", info: _vTransType),
                      CustomColTextbox(header: "Fuel type", info: _vFuelType),
                      CustomColTextbox(
                          header: "Manufacture year", info: _vManfYear),
                      CustomColTextbox(header: "Milage (KM)", info: _vMilage),
                      CustomColTextbox(header: "Condition", info: _vCondition),
                      CustomColTextbox(header: "More details", info: _vInfo),
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
