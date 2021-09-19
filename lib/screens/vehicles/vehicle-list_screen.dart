import 'package:flutter/material.dart';
import 'package:riyasewana/widgets/bigger_vertical_card.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_bottomNavBar.dart';
import '../../styles.dart';

class VehicleListScreen extends StatefulWidget {
  @override
  _VehicleListScreen createState() => _VehicleListScreen();
}

@override
void initState() {}

class _VehicleListScreen extends State<VehicleListScreen> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Newest First';
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: CustomAppbarWidget(
              mainTitle: "Vehicles",
              leadingImg: true,
              logo: false,
              searchIcon: true,
            ),
          ),
          bottomNavigationBar: BottomNavbar(),
          body: Container(
            height: double.infinity,
            width: double.infinity,
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
                      Container(
                          height: 40,
                          margin: EdgeInsets.only(top: 10, left: 330),
                          child: Text(
                            "Filter",
                            style: SeeAllStyle,
                          )),
                    ],
                  ),
                ),
                Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 40),
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (170 / 220),
                      children: List.generate(8, (index) {
                        return Container(
                          height: 250,
                          width: 170,
                          margin: EdgeInsets.only(bottom: 10),
                          child: BigVerticalCard(
                            adImg: 'assets/images/avatar.jpg',
                            adName: "Misubhshi Evolution  " + '$index',
                            adPrice: "Rs. 900000",
                          ),
                        );
                      }),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
