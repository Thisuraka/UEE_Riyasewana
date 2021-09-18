import '../../styles.dart';
import 'package:flutter/material.dart';

class BigVerticalCard extends StatelessWidget {
  String adImg;
  String adName;
  String adPrice;

  BigVerticalCard({
    required this.adImg,
    required this.adName,
    required this.adPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 170,
          height: 220,
          margin: EdgeInsets.only(left: 15, right: 10, top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Button2BorderColor),
          ),
          child: Stack(
            children: [
              Container(
                width: 170,
                height: 130,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: ClipRRect(
                  child: Image.asset(
                    adImg,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2)),
                ),
              ),
              Container(
                height: 30,
                width: double.infinity,
                margin: EdgeInsets.only(top: 135, left: 5, right: 2),
                child: Text(
                  adName,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              Container(
                height: 30,
                width: double.infinity,
                margin: EdgeInsets.only(top: 160, left: 5, right: 2),
                child: Text(
                  adPrice,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
