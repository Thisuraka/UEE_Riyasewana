import '../../styles.dart';
import 'package:flutter/material.dart';

class BigVerticalCard extends StatelessWidget {
  String adID;
  String adImg;
  String adModel;
  String adBrand;
  String adCatagory;
  String adPrice;

  BigVerticalCard({
    required this.adID,
    required this.adImg,
    this.adBrand = "",
    this.adModel = "",
    this.adCatagory = "",
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
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                width: 170,
                height: 140,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: ClipRRect(
                  child: adImg.isNotEmpty
                      ? Image.network(
                          adImg,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/avatar.jpg',
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
                margin: EdgeInsets.only(top: 150, left: 6, right: 2),
                child: Text(
                  adModel,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
              adBrand != ""
                  ? Container(
                      height: 30,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 175, left: 6, right: 2),
                      child: Text(
                        adBrand,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    )
                  : Container(),
              adCatagory != ""
                  ? Container(
                      height: 30,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 175, left: 6, right: 2),
                      child: Text(
                        adCatagory,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    )
                  : Container(),
              Container(
                height: 30,
                width: double.infinity,
                margin: EdgeInsets.only(top: 195, left: 6, right: 2),
                child: Text(
                  adPrice,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
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
