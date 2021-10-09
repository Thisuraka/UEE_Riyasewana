import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riyasewana/api/api_caller.dart';
import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/screens/account/edit-profile_screen.dart';
import 'package:riyasewana/screens/parts/add-part_screen.dart';
import 'package:riyasewana/screens/parts/edit-part_screen.dart';
import 'package:riyasewana/screens/vehicles/add-vehicle_screen.dart';
import 'package:riyasewana/styles.dart';
import 'package:blur/blur.dart';
import 'package:riyasewana/utils/settings.dart';
import 'package:riyasewana/widgets/custom_bottomNavBar.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/horizontal_card.dart';

class UserProfile extends StatefulWidget {
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _uid = "";
  String _token = "";
  String _phoneNumber = "";
  String uName = "";
  String _fName = "";
  String _lName = "";
  String _name = "";
  String _email = "";
  List<dynamic> parts = [];
  List<dynamic> vehicles = [];
  bool _loaded = false;

  String profileImg = 'assets/images/avatar.jpg';

  void getUser() async {
    await Settings.getUserID().then((value) => {_uid = value!});
    await Settings.getAccessToken().then((value) => {_token = value!});
    await Settings.getFName().then((value) => {_fName = value!});
    await Settings.getLName().then((value) => {_lName = value!});
    await Settings.getUserEmail().then((value) => {_email = value!});
    await Settings.getUserPhone().then((value) => {_phoneNumber = value!});

    uName = _fName + " " + _lName;
    setState(() {});
    getUserAds();
  }

  void getUserAds() async {
    final partsResponse = await ApiCalls.userPartsGet(uid: _uid, token: _token);
    parts = partsResponse.jsonBody;

    final vehiclesResponse =
        await ApiCalls.userVehiclesGet(uid: _uid, token: _token);
    vehicles = vehiclesResponse.jsonBody;
    _loaded = true;
    setState(() {});
  }

  @override
  void initState() {
    getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
      body: _loaded
          ? GestureDetector(
              onTap: () => {FocusScope.of(context).unfocus()},
              child: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Blur(
                      blur: 3.5,
                      blurColor: Colors.black,
                      child: Container(
                        color: Colors.blueAccent,
                        height: 220,
                        width: double.infinity,
                        child: Image.asset(
                          profileImg,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        )
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        margin: EdgeInsets.only(top: 60, left: 340),
                        child: Image.asset(
                          'assets/icons/edit.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      margin: EdgeInsets.only(top: 120, left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.blueAccent,
                      ),
                      child: ClipRRect(
                        child: Image.asset(
                          profileImg,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    Container(
                      width: 230,
                      height: 90,
                      margin: EdgeInsets.only(top: 120, left: 130),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              uName,
                              style: ProfileDataStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              _email,
                              style: ProfileDataStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              _phoneNumber,
                              style: ProfileDataStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 260),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddPartScreen(),
                            ),
                          ),
                        },
                        child: CustomButton(
                          text: "Add parts",
                          width: 170.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 210, top: 260),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddVehicleScreen(),
                            ),
                          ),
                        },
                        child: CustomButton(
                          text: "Add vehicles",
                          width: 170.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 340),
                      child: Text(
                          "Your Ads" + "               <-     Swipe     ->",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 370),
                      width: double.infinity,
                      height: 550,
                      child: GridView.count(
                          scrollDirection: Axis.horizontal,
                          childAspectRatio: (100 / 104),
                          crossAxisCount: 1,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 450,
                              margin: EdgeInsets.all(10),
                              child: RefreshIndicator(
                                onRefresh: _pullRefresh,
                                child: vehicles.isNotEmpty
                                    ? GridView.count(
                                        padding: EdgeInsets.all(0),
                                        scrollDirection: Axis.vertical,
                                        childAspectRatio: (100 / 31),
                                        crossAxisCount: 1,
                                        children: vehicles.map((vehicle) {
                                          return HorizontalCard(
                                            adID: vehicle["_id"],
                                            adImg:
                                                (vehicle["vImages"].length > 0)
                                                    ? vehicle["vImages"][0]
                                                    : '',
                                            adBrand: (vehicle["vBrand"] != null)
                                                ? vehicle["vBrand"]
                                                : "Name Not Found",
                                            adModel: (vehicle["vModel"] != null)
                                                ? vehicle["vModel"]
                                                : "Name Not Found",
                                            adPrice: (vehicle["vPrice"] != null)
                                                ? "Rs. " + vehicle["vPrice"]
                                                : "--",
                                            adType: 'Vehicle',
                                            onChange: (value) {
                                              if (value) {
                                                _pullRefresh();
                                              }
                                            },
                                          );
                                        }).toList(),
                                      )
                                    : Center(
                                        child: Text("No vehicles to show")),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 450,
                              margin: EdgeInsets.all(10),
                              child: RefreshIndicator(
                                onRefresh: _pullRefresh,
                                child: parts.isNotEmpty
                                    ? GridView.count(
                                        padding: EdgeInsets.all(0),
                                        scrollDirection: Axis.vertical,
                                        childAspectRatio: (100 / 31),
                                        crossAxisCount: 1,
                                        children: parts.map((part) {
                                          return HorizontalCard(
                                            adID: part["_id"],
                                            adImg: (part["pImages"].length > 0)
                                                ? part["pImages"][0]
                                                : '',
                                            adModel: (part["pName"] != null)
                                                ? part["pName"]
                                                : "Name Not Found",
                                            adCatagory:
                                                (part["pCatagory"] != null)
                                                    ? part["pCatagory"]
                                                    : "Name Not Found",
                                            adPrice: (part["pPrice"] != null)
                                                ? "Rs. " + part["pPrice"]
                                                : "--",
                                            adType: 'Part',
                                            onChange: (value) {
                                              if (value) {
                                                _pullRefresh();
                                              }
                                            },
                                          );
                                        }).toList(),
                                      )
                                    : Center(child: Text("No parts to show")),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            )
          : SpinKitFoldingCube(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? DefaultColor : InactiveColor,
                  ),
                );
              },
            ),
    );
  }

  Future<void> _pullRefresh() async {
    getUserAds();
    setState(() {});
  }
}
