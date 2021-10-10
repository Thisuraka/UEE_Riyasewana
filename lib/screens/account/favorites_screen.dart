import 'package:flutter/material.dart';
import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/screens/vehicles/view-vehicle_screen.dart';
import 'package:riyasewana/utils/settings.dart';
import 'package:riyasewana/widgets/bigger_vertical_card.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_bottomNavBar.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

String _uid = "";
String _token = "";
List<dynamic> parts = [];
List<dynamic> vehicles = [];
List<dynamic> favVehicles = [];
List<dynamic> favParts = [];

class _FavoritesScreenState extends State<FavoritesScreen> {
  void getUser() async {
    await Settings.getUserID().then((value) => {_uid = value!});
    await Settings.getAccessToken().then((value) => {_token = value!});

    setState(() {});
  }

  void getAds() async {
    final vehicleResponse = await ApiCalls.allVehicleFavs(token: _token);

    if (vehicleResponse.jsonBody.length > 0) {
      vehicles = vehicleResponse.jsonBody;

      vehicles.forEach((element) {
        if (element.length > 0 &&
            element["vehicle"] != null &&
            element["vehicle"].isNotEmpty) {
          favVehicles.add(element["vehicle"]);
        }
      });
    }

    final partsResponse = await ApiCalls.allPartFavs(token: _token);

    if (partsResponse.jsonBody.length > 0) {
      parts = partsResponse.jsonBody;
      parts.forEach((element) {
        if (element.length > 0 &&
            element["part"] != null &&
            element["part"].length > 0) {
          favParts.add(element["part"]);
        }
      });
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    parts.clear();
    vehicles.clear();
    favVehicles.clear();
    favParts.clear();
    getUser();
    getAds();
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
              mainTitle: "Favorites",
              leadingImg: true,
              logo: false,
              searchIcon: false,
            ),
          ),
          bottomNavigationBar: BottomNavbar(),
          body: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Container(
                  height: 290,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 6),
                          child: Text(
                            "Vehicle",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 25),
                        child: vehicles.isNotEmpty
                            ? GridView.count(
                                scrollDirection: Axis.horizontal,
                                crossAxisCount: 1,
                                padding: EdgeInsets.zero,
                                childAspectRatio: 1.5,
                                children: favVehicles.map((vehicle) {
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
                ),
                Container(
                  height: 290,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 6),
                          child: Text(
                            "Parts",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 25),
                        child: parts.isNotEmpty
                            ? GridView.count(
                                scrollDirection: Axis.horizontal,
                                crossAxisCount: 1,
                                padding: EdgeInsets.zero,
                                childAspectRatio: 1.5,
                                children: favParts.map((part) {
                                  return GestureDetector(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewVehicleScreen(
                                            adID: part["_id"],
                                          ),
                                        ),
                                      ),
                                    },
                                    child: Container(
                                      height: 250,
                                      width: 170,
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: BigVerticalCard(
                                        adID: part["_id"],
                                        adImg: (part["pImages"].length > 0)
                                            ? part["pImages"][0]
                                            : '',
                                        adBrand: (part["pName"] != null)
                                            ? part["pName"]
                                            : "Name Not Found",
                                        adModel: (part["pCatagory"] != null)
                                            ? part["pCatagory"]
                                            : "Name Not Found",
                                        adPrice: (part["pPrice"] != null)
                                            ? "Rs. " + part["pPrice"]
                                            : "--",
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                            : Center(child: Text("No parts to show")),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
