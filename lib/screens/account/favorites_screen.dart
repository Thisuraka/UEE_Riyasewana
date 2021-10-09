import 'package:flutter/material.dart';
import 'package:riyasewana/widgets/bigger_vertical_card.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_bottomNavBar.dart';

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
              searchIcon: false,
            ),
          ),
          bottomNavigationBar: BottomNavbar(),
          body: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
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
                      /*  Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 25),
                        child: GridView.count(
                          scrollDirection: Axis.horizontal,
                          childAspectRatio: (140 / 104),
                          crossAxisCount: 1,
                          children: List.generate(9, (index) {
                            return BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution  " + '$index',
                              adPrice: "Rs. 900000",
                            );
                          }),
                        ),
                      ) */
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
                      /*  Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 25),
                        child: GridView.count(
                          scrollDirection: Axis.horizontal,
                          childAspectRatio: (140 / 104),
                          crossAxisCount: 1,
                          children: List.generate(9, (index) {
                            return BigVerticalCard(
                              adImg: 'assets/images/avatar.jpg',
                              adName: "Misubhshi Evolution  " + '$index',
                              adPrice: "Rs. 900000",
                            );
                          }),
                        ),
                      ) */
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
