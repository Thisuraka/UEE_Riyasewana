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

class HomeScreen extends StatelessWidget {
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
              mainTitle: "Latest",
              leadingImg: true,
              logo: false,
              searchIcon: true,
            ),
          ),
          bottomNavigationBar: BottomNavbar(),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 7, left: 6),
                        child: Text(
                          "Vehicle Parts",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 7, left: 330),
                        child: Text(
                          "See All",
                          style: SeeAllStyle,
                        )),
                    Container(
                        height: 170,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 30),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            VerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution VI",
                              adPrice: "Rs. 900000",
                            ),
                            VerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution VI",
                              adPrice: "Rs. 900000",
                            ),
                            VerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution VI",
                              adPrice: "Rs. 900000",
                            ),
                          ],
                        ))
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.only(top: 220),
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 7, left: 6),
                          child: Text(
                            "Vehicles",
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                          // color: Colors.blueAccent,
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(9, (index) {
                              return Center(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
