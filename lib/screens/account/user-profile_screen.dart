import 'package:flutter/material.dart';
import 'package:riyasewana/screens/account/edit-profile_screen.dart';
import 'package:riyasewana/screens/parts/add-part_screen.dart';
import 'package:riyasewana/screens/vehicles/add-vehicle_screen.dart';
import 'package:riyasewana/styles.dart';
import 'package:blur/blur.dart';
import 'package:riyasewana/utils/settings.dart';
import 'package:riyasewana/widgets/custom_bottomNavBar.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/horizontal_card.dart';

class UserProfile extends StatefulWidget {
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String uName = "";
  String _fName = "";
  String _lName = "";
  String _uid = "";
  String _name = "";
  String _email = "";
  String _phoneNumber = "";

  String profileImg = 'assets/images/avatar.jpg';

  void getUser() async {
    await Settings.getUserID().then((value) => {_uid = value!});
    await Settings.getFName().then((value) => {_fName = value!});
    await Settings.getLName().then((value) => {_lName = value!});
    await Settings.getUserEmail().then((value) => {_email = value!});
    await Settings.getUserPhone().then((value) => {_phoneNumber = value!});

    uName = _fName + " " + _lName;
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
      body: GestureDetector(
        onTap: () => {FocusScope.of(context).unfocus()},
        child: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Blur(
                blur: 3.5,
                blurColor: Colors.black,
                child: Container(
                  color: Colors.blueAccent,
                  height: 220,
                  width: double.infinity,
                  child: Image.asset(
                    profileImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  )
                },
                child: Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.only(top: 60, left: 340),
                  child: Image.asset(
                    'assets/icons/edit.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.only(top: 120, left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blueAccent,
                ),
                child: ClipRRect(
                  child: Image.asset(
                    profileImg,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              Container(
                width: 230,
                height: 90,
                margin: EdgeInsets.only(top: 120, left: 130),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        uName,
                        style: ProfileDataStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        _email,
                        style: ProfileDataStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        _phoneNumber,
                        style: ProfileDataStyle,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 260),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddPartScreen(),
                      ),
                    ),
                  },
                  child: CustomButton(
                    text: "Add parts",
                    width: 170.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 210, top: 260),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddVehicleScreen(),
                      ),
                    ),
                  },
                  child: CustomButton(
                    text: "Add vehicles",
                    width: 170.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 340),
                child: Text("Your Ads",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0)),
              ),
              Container(
                margin: EdgeInsets.only(top: 370),
                width: double.infinity,
                height: 550,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HorizontalCard(
                        adImg: 'assets/images/part1.jfif',
                        adName: "Honda CM125 Tank",
                        adPrice: "Rs. 10000",
                        adType: 'Part',
                      ),
                      HorizontalCard(
                          adImg: 'assets/images/avatar.jpg',
                          adName: "Misubhshi Evolution VI",
                          adPrice: "Rs. 900000",
                          adType: 'Vehicle'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
