import 'package:riyasewana/screens/parts/edit-part_screen.dart';
import 'package:riyasewana/screens/vehicles/edit-vehicle_screen.dart';

import '../../styles.dart';
import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  String adImg;
  String adName;
  String adPrice;
  String adType;

  HorizontalCard(
      {required this.adImg,
      required this.adName,
      required this.adPrice,
      required this.adType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, top: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Button2BorderColor),
      ),
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            child: ClipRRect(
              child: Image.asset(
                adImg,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          GestureDetector(
            onTap: () => {
              if (adType == "Part")
                {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditPartScreen(),
                    ),
                  ),
                }
              else if (adType == "Vehicle")
                {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditVehicleScreen(),
                    ),
                  ),
                }
              else
                {null}
            },
            child: Container(
              margin: EdgeInsets.only(left: 320, top: 5),
              width: 30,
              height: 30,
              child: Image.asset(
                'assets/icons/more.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: 190,
            margin: EdgeInsets.only(top: 20, left: 120),
            child: Text(
              adName,
              style: TextStyle(
                  fontFamily: DefaultFont,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
          Container(
            width: 190,
            margin: EdgeInsets.only(top: 50, left: 120),
            child: Text(
              adPrice,
              style: TextStyle(
                  fontFamily: DefaultFont,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }
}
