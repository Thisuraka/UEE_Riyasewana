import 'package:flutter/material.dart';
import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/screens/vehicles/view-vehicle_screen.dart';
import 'package:riyasewana/utils/settings.dart';
import 'package:riyasewana/widgets/navDrawer.dart';
import 'package:riyasewana/widgets/bigger_vertical_card.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_bottomNavBar.dart';
import 'package:riyasewana/widgets/vehicle_filter.dart';
import '../../styles.dart';

class VehicleListScreen extends StatefulWidget {
  @override
  _VehicleListScreen createState() => _VehicleListScreen();
}

class _VehicleListScreen extends State<VehicleListScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String dropdownValue = 'Newest First';
  String _profileImg = 'assets/images/avatar.jpg';

  List<dynamic> vehicles = [];
  String _token = "";
  String _uid = "";

  void getUser() async {
    await Settings.getUserID().then((value) => {_uid = value!});
    await Settings.getAccessToken().then((value) => {_token = value!});

    getAds();
  }

  void getAds() async {
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
              mainTitle: "Vehicles",
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
          endDrawer: VehicleFilter(),
          body: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 10),
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        height: 40,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>[
                            'Newest First',
                            'Newest Last',
                            'Lowest Price',
                            'Highest Price'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _drawerKey.currentState?.openEndDrawer();
                        },
                        child: Container(
                            height: 40,
                            margin: EdgeInsets.only(top: 10, left: 330),
                            child: Text(
                              "Filter",
                              style: SeeAllStyle,
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 40),
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
                                    builder: (context) => ViewVehicleScreen(),
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
          ),
        ),
      ),
    );
  }
}
