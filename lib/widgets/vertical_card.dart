import '../../styles.dart';
import 'package:flutter/material.dart';

class VerticalCard extends StatelessWidget {
  String adImg;
  String adName;
  String adPrice;

  VerticalCard({
    required this.adImg,
    required this.adName,
    required this.adPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 110,
          height: 170,
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Button2BorderColor),
          ),
          child: Stack(
            children: [
              Container(
                width: 110,
                height: 80,
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
                margin: EdgeInsets.only(top: 95, left: 2, right: 2),
                child: Text(
                  adName,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              Container(
                height: 30,
                width: double.infinity,
                margin: EdgeInsets.only(top: 135, left: 2, right: 2),
                child: Text(
                  adPrice,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
