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
          width: 100,
          height: 180,
          margin: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Button2BorderColor),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                width: 100,
                height: 90,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: ClipRRect(
                  child: Image.asset(
                    adImg,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ),
              Container(
                height: 30,
                width: double.infinity,
                margin: EdgeInsets.only(top: 105, left: 4, right: 2),
                child: Text(
                  adName,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Container(
                height: 30,
                width: double.infinity,
                margin: EdgeInsets.only(top: 140, left: 4, right: 2),
                child: Text(
                  adPrice,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
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
