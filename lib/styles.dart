import 'package:flutter/material.dart';

const DefaultColor = Color(0xFF2980B9);
const InactiveColor = Color(0xFFCFCFCF);
const Button2BorderColor = Color(0xFFC6C6C6);
const WarningAlertColor = Color(0xFFFFD429);
const SuccessAlertColor = Color(0xFFB5BF24);

//Fonts and text
const String DefaultFont = 'Roboto';

const LogoText = TextStyle(
    fontFamily: DefaultFont,
    color: DefaultColor,
    fontWeight: FontWeight.w900,
    fontSize: 30.0);

const HeaderStyle = TextStyle(
    fontFamily: DefaultFont,
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold);

const SubHeadStyle = TextStyle(
    color: Color(0xFF858585), fontWeight: FontWeight.bold, fontSize: 13);

const LabelStyle1 = TextStyle(
    fontFamily: DefaultFont,
    color: Color(0XFFABABAB),
    fontWeight: FontWeight.w500,
    fontSize: 15.0);

const HintStyle1 = TextStyle(
    fontFamily: DefaultFont,
    color: Color(0XFFABABAB),
    fontWeight: FontWeight.w500,
    fontSize: 15.0);

const SeeAllStyle = TextStyle(
    fontFamily: DefaultFont,
    color: Color(0xFF5F8DF3),
    fontWeight: FontWeight.w600,
    fontSize: 16.0);

const LogOut = TextStyle(
    fontFamily: DefaultFont,
    color: Colors.red,
    fontWeight: FontWeight.w600,
    fontSize: 16.0);

const ProfileDataStyle = TextStyle(
    fontFamily: DefaultFont,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 15.0);

const TextButtonStyle = TextStyle(
  fontFamily: DefaultFont,
  color: Color(0xFFAFB0B1),
  fontSize: 12.0,
);

//Sample text and list
List<String> LocationList = ["Kandy", "Colombo", "Galle", "Dompe"];
List<String> VehcileTypeList = [
  "Bus",
  "Car",
  "Crew-cab",
  "Heavy-duty",
  "Lorry",
  "Mo-Cycle",
  "Pickup",
  "SUV",
  "Tuk",
  "Tractor"
];
List<String> VehicleBrandList = ["Toyota", "Honda", "Nissan", "Subrau"];
List<String> VehicleConditionList = [
  "Any",
  "Used",
  "Registered",
  "Unregistered"
];
List<String> VehicleTransmissionList = ["Any", "Manual", "Automatic", "CVT"];
List<String> VehicleFuelList = ["Petrol", "Diesel", "Electic", "Hydrogen"];
List<String> PartTypeList = ["Car", "Van", "Bike", "Truck"];
List<String> PartCatagoryList = [
  "Electrical",
  "Component",
  "Accessorie",
  "Other"
];
List<String> PartConditionList = ["Used", "Second-hand"];

String sampleHeading = "Lorem ipsum dolor sit amet";
String samplePara =
    "Nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et";
