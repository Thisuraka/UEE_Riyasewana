import 'package:flutter/material.dart';
import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/screens/parts/part-list_screen.dart';
import 'package:riyasewana/screens/parts/view-part_screen.dart';
import 'package:riyasewana/utils/settings.dart';
import 'package:riyasewana/widgets/navDrawer.dart';
import 'package:riyasewana/screens/vehicles/vehicle-list_screen.dart';
import 'package:riyasewana/screens/vehicles/view-vehicle_screen.dart';
import 'package:riyasewana/styles.dart';
import 'package:riyasewana/widgets/bigger_vertical_card.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_bottomNavBar.dart';
import 'package:riyasewana/widgets/vertical_card.dart';

@override
void initState() {}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String _profileImg = 'assets/images/avatar.jpg';
  List<dynamic> parts = [];
  List<dynamic> vehicles = [];
  String _token = "";
  String _uid = "";

  void getUser() async {
    await Settings.getUserID().then((value) => {_uid = value!});
    await Settings.getAccessToken().then((value) => {_token = value!});

    getAds();
  }

  void getAds() async {
    final partsResponse = await ApiCalls.allPartsGet();
    parts = partsResponse.jsonBody;

    final vehiclesResponse = await ApiCalls.allVehiclesGet();
    vehicles = vehiclesResponse.jsonBody;
    setState(() {});
    // print("============================================================");
  }

  @override
  void initState() {
    getUser();
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
          key: _drawerKey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: CustomAppbarWidget(
              mainTitle: "Latest",
              leadingImg: true,
              logo: false,
              searchIcon: true,
              drawerKey: _drawerKey,
            ),
          ),
          bottomNavigationBar: BottomNavbar(),
          drawer: NavDrawer(
            profileImg: _profileImg,
          ),
          body: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Vehicle Parts",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      GestureDetector(
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PartListScreen(),
                            ),
                          )
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 330),
                            child: Text(
                              "See All",
                              style: SeeAllStyle,
                            )),
                      ),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 25),
                        child: parts.isNotEmpty
                            ? GridView.count(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                childAspectRatio: 1.3,
                                // childAspectRatio: (140 / 105),
                                crossAxisCount: 1,
                                children: parts.map((part) {
                                  return GestureDetector(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ViewPartScreen(
                                            adID: part["_id"],
                                          ),
                                        ),
                                      ),
                                    },
                                    child: VerticalCard(
                                      adID: part["_id"],
                                      adImg: (part["pImages"].length > 0)
                                          ? part["pImages"][0]
                                          : '',
                                      adName: (part["pName"] != null)
                                          ? part["pName"]
                                          : "Name Not Found",
                                      adCatagory: (part["pCatagory"] != null)
                                          ? part["pCatagory"]
                                          : "Name Not Found",
                                      adPrice: (part["pPrice"] != null)
                                          ? "Rs. " + part["pPrice"]
                                          : "--",
                                    ),
                                  );
                                }).toList(),
                              )
                            : Center(child: Text("No parts to show")),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.only(top: 230),
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 7, left: 20),
                          child: Text(
                            "Vehicles",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          )),
                      GestureDetector(
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VehicleListScreen(),
                            ),
                          )
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 7, left: 330),
                            child: Text(
                              "See All",
                              style: SeeAllStyle,
                            )),
                      ),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                        child: vehicles.isNotEmpty
                            ? GridView.count(
                                crossAxisCount: 2,
                                padding: EdgeInsets.all(0),
                                childAspectRatio: (170 / 220),
                                children: vehicles.map((vehicle) {
                                  return GestureDetector(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewVehicleScreen(
                                            adID: vehicle["_id"],
                                          ),
                                        ),
                                      ),
                                    },
                                    child: Container(
                                      height: 250,
                                      width: 170,
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: BigVerticalCard(
                                        adID: vehicle["_id"],
                                        adImg: (vehicle["vImages"].length > 0)
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
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                            : Center(child: Text("No vehicles to show")),
                      )
                    ],
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
