import 'package:flutter/material.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_dropdown.dart';
import 'package:riyasewana/widgets/custom_textbox2.dart';
import '../../styles.dart';

class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  String _vLocation = "";
  String _vType = "";
  String _vBrand = "";
  String _vCondition = "";
  String _vTransmission = "";
  String _vFuel = "";
  DateTime _Manf = DateTime.now();

  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _lName = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confPassword = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
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
              mainTitle: "Add vehicle",
              leadingImg: false,
              logo: false,
              searchIcon: false,
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    "Photos 0/10",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  margin:
                      EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Button2BorderColor, width: 1.5),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 150, top: 10),
                        child: Image.asset(
                          'assets/icons/addImage.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 135, top: 60),
                        child: Text("Add images"),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 140),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(left: 15, right: 15, bottom: 10),
                          child:
                              Text("Contact Information", style: SubHeadStyle),
                        ),
                        CustomTextBox2(
                          controller: _name,
                          hint: "Name",
                          labelText: "John Doe",
                          readOnly: true,
                          enabled: false,
                          onTap: () {},
                        ),
                        CustomTextBox2(
                          controller: _phone,
                          hint: "Phone Number",
                          labelText: "07777777",
                          readOnly: true,
                          enabled: true,
                          onTap: () {},
                        ),
                        CustomDropDown(
                          hint: "Location",
                          itemList: LocationList,
                          onSelectionChange: (String value) {
                            setState(() {
                              _vLocation = value;
                            });
                          },
                          itemValue: _vLocation,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(left: 15, right: 15, bottom: 10),
                          child:
                              Text("Vehicle Information", style: SubHeadStyle),
                        ),
                        CustomDropDown(
                          hint: "Vehicle Type",
                          itemList: VehcileTypeList,
                          onSelectionChange: (String value) {
                            setState(() {
                              _vType = value;
                            });
                          },
                          itemValue: _vType,
                        ),
                        CustomDropDown(
                          hint: "Brand",
                          itemList: VehicleBrandList,
                          onSelectionChange: (String value) {
                            setState(() {
                              _vBrand = value;
                            });
                          },
                          itemValue: _vBrand,
                        ),
                        CustomDropDown(
                          hint: "Condtion",
                          itemList: VehicleConditionList,
                          onSelectionChange: (String value) {
                            setState(() {
                              _vCondition = value;
                            });
                          },
                          itemValue: _vCondition,
                        ),
                        CustomTextBox2(
                          controller: _phone,
                          hint: "Model",
                          labelText: "Model",
                          readOnly: false,
                          enabled: true,
                          onTap: () {},
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            height: 52.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                            ),
                            child: Text(
                              "Manufactury Year",
                              style: HintStyle1,
                            ),
                          ),
                          onTap: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Select Year"),
                                    content: Container(
                                      width: 200,
                                      height: 200,
                                      child: YearPicker(
                                        firstDate: DateTime(
                                            DateTime.now().year - 100, 1),
                                        lastDate: DateTime(
                                            DateTime.now().year + 100, 1),
                                        initialDate: DateTime.now(),
                                        selectedDate: _Manf,
                                        onChanged: (DateTime dateTime) {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  );
                                })
                          },
                        )
                      ],
                    ),
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
