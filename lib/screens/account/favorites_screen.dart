import 'package:flutter/material.dart';
import 'package:riyasewana/styles.dart';
import 'package:riyasewana/widgets/bigger_vertical_card.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_bottomNavBar.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/custom_button2.dart';
import 'package:riyasewana/widgets/custom_textbox.dart';
import 'package:riyasewana/widgets/vertical_card.dart';

@override
void initState() {}

class FavoritesScreen extends StatelessWidget {
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
              searchIcon: true,
            ),
          ),
          bottomNavigationBar: BottomNavbar(),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(top: 30),
            child: Stack(
              children: [
                Container(
                  height: 290,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 6),
                          child: Text(
                            "Vehicle Parts",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 330),
                          child: Text(
                            "See All",
                            style: SeeAllStyle,
                          )),
                      Container(
                        height: 300,
                        width: double.infinity,
                        // padding: EdgeInsets.only(top: 40),
                        margin: EdgeInsets.only(top: 25),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution",
                              adPrice: "Rs. 900000",
                            ),
                            BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution",
                              adPrice: "Rs. 900000",
                            ),
                            BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution",
                              adPrice: "Rs. 900000",
                            ),
                            BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution",
                              adPrice: "Rs. 900000",
                            ),
                            BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution",
                              adPrice: "Rs. 900000",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 290,
                  margin: EdgeInsets.only(top: 300),
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 7, left: 6),
                          child: Text(
                            "Vehicles",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 7, left: 330),
                          child: Text(
                            "See All",
                            style: SeeAllStyle,
                          )),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 30),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution",
                              adPrice: "Rs. 900000",
                            ),
                            BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution",
                              adPrice: "Rs. 900000",
                            ),
                            BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution",
                              adPrice: "Rs. 900000",
                            ),
                            BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution",
                              adPrice: "Rs. 900000",
                            ),
                            BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution",
                              adPrice: "Rs. 900000",
                            ),
                          ],
                        ),
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
