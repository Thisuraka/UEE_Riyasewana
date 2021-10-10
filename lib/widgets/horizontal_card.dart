import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/screens/account/user-profile_screen.dart';
import 'package:riyasewana/screens/parts/edit-part_screen.dart';
import 'package:riyasewana/screens/vehicles/edit-vehicle_screen.dart';
import 'package:riyasewana/utils/settings.dart';

import '../../styles.dart';
import 'package:flutter/material.dart';

class HorizontalCard extends StatefulWidget {
  _HorizontalCardState createState() => _HorizontalCardState();
  String adID;
  String adImg;
  String adBrand;
  String adModel;
  String adCatagory;
  String adPrice;
  String adType;
  final void Function(bool) onChange;

  HorizontalCard({
    required this.adID,
    this.adImg = '',
    this.adBrand = '',
    this.adCatagory = '',
    required this.onChange,
    required this.adModel,
    required this.adPrice,
    required this.adType,
  });
}

class _HorizontalCardState extends State<HorizontalCard> {
  String _token = "";

  void getUser() async {
    await Settings.getAccessToken().then((value) => {_token = value!});
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.only(top: 20, left: 5, right: 5),
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
            width: 100,
            height: 100,
            child: ClipRRect(
              child: widget.adImg.isNotEmpty
                  ? Image.network(
                      widget.adImg,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/avatar.jpg',
                      fit: BoxFit.cover,
                    ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          GestureDetector(
            onTap: () => {
              if (widget.adType == "Part")
                {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditPartScreen(
                        adID: widget.adID,
                      ),
                    ),
                  ),
                }
              else if (widget.adType == "Vehicle")
                {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditVehicleScreen(
                        adID: widget.adID,
                      ),
                    ),
                  ),
                }
              else
                {null}
            },
            child: Container(
              margin: EdgeInsets.only(left: 320, top: 5),
              width: 25,
              height: 25,
              child: Image.asset(
                'assets/icons/edit2.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => {
              if (widget.adType == "Part")
                {
                  ApiCalls.deletePartAd(adID: widget.adID, token: _token),
                  widget.onChange(true)
                }
              else if (widget.adType == "Vehicle")
                {
                  ApiCalls.deleteVehicleAd(adID: widget.adID, token: _token),
                  widget.onChange(true)
                }
              else
                {null}
            },
            child: Container(
              margin: EdgeInsets.only(left: 320, top: 50),
              width: 30,
              height: 30,
              child: Image.asset(
                'assets/icons/bin.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: 190,
            margin: EdgeInsets.only(top: 10, left: 120),
            child: Text(
              widget.adModel,
              style: TextStyle(
                  fontFamily: DefaultFont,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            ),
          ),
          Container(
            width: 190,
            margin: EdgeInsets.only(top: 37, left: 120),
            child: widget.adBrand != ""
                ? Text(
                    widget.adBrand,
                    style: TextStyle(
                        fontFamily: DefaultFont,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  )
                : null,
          ),
          Container(
            width: 190,
            margin: EdgeInsets.only(top: 37, left: 120),
            child: widget.adCatagory != ""
                ? Text(
                    widget.adCatagory,
                    style: TextStyle(
                        fontFamily: DefaultFont,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  )
                : null,
          ),
          Container(
            width: 190,
            margin: EdgeInsets.only(top: 65, left: 120),
            child: Text(
              widget.adPrice,
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
