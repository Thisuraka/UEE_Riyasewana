import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/screens/account/user-profile_screen.dart';
import 'package:riyasewana/utils/helper.dart';
import 'package:riyasewana/utils/settings.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/custom_dropdown.dart';
import 'package:riyasewana/widgets/custom_imagePicker.dart';
import 'package:riyasewana/widgets/custom_textbox2.dart';
import '../../styles.dart';

class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  String _token = "";
  String _uNname = "";
  String _fName = "";
  String _lName = "";
  String _uPhone = "";

  String _vLocation = "";
  String _vType = "";
  String _vBrand = "";
  String _vCondition = "";
  String _vTransmission = "";
  String _vFuel = "";
  String _manftext = "Manufactury year";
  DateTime _Manf = DateTime.now();
  bool _vNegotiate = false;

  List<XFile>? _imageFileList = [];
  List<String> _imgPaths = [];
  bool _gen = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _addInfo = TextEditingController();
  TextEditingController _milage = TextEditingController();
  TextEditingController _vModel = TextEditingController();

  @override
  void initState() {
    getUserData();
    print(_uNname);
    print(_uPhone);
  }

  void getUserData() async {
    await Settings.getAccessToken().then((value) => {_token = value!});
    await Settings.getFName().then((value) => {_fName = value!});
    await Settings.getLName().then((value) => {_lName = value!});
    await Settings.getUserPhone().then((value) => {_uPhone = value!});

    _uNname = _fName + " " + _lName;
    setState(() {});
  }

  Future<void> addImage() async {
    _imageFileList = await Helper.selectImages();
    setGen();
  }

  void removeImage(int index) {
    _imageFileList!.removeAt(index);
    setGen();
  }

  void setGen() {
    if (_imageFileList!.length > 0) {
      _gen = true;
    } else {
      _gen = false;
    }
    setState(() {});
  }

  void newAd() async {
    if (_formKey.currentState!.validate()) {
      if (_imageFileList!.length < 1) {
        Fluttertoast.showToast(
          msg: "Please add images",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      } else {
        for (int i = 0; i < _imageFileList!.length; i++) {
          _imgPaths.add(_imageFileList![i].path);
        }

        final response = await ApiCalls.vehiclesAd(
          token: _token,
          vLocation: _vLocation,
          vType: _vType,
          vBrand: _vBrand,
          vCondition: _vCondition,
          vModel: _vModel.text,
          vPrice: _price.text,
          vManf: _Manf.year.toString(),
          vNegotiate: _vNegotiate.toString(),
          vTransmission: _vTransmission,
          vFuel: _vFuel,
          vMilage: _milage.text,
          vInfo: _addInfo.text,
          vImages: _imgPaths,
        );

        print(response.apiStatus);
        if (response.isSuccess) {
          var json = response.jsonBody;

          print(json);

          Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UserProfile()));

          _imgPaths.clear();
        } else {
          Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: CustomAppbarWidget(
          mainTitle: "Add vehicle",
          leadingImg: false,
          logo: false,
          searchIcon: false,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: createAd,
      // ),
      body: GestureDetector(
        onTap: () => {FocusScope.of(context).unfocus()},
        child: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  "Photos " + _imageFileList!.length.toString() + "/9",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              GestureDetector(
                onTap: addImage,
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  width: double.infinity,
                  height: 100,
                  child: CustomImagePicker(
                      _imageFileList, addImage, removeImage,
                      gen: _gen),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 140),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
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
                          labelText: _uNname,
                          readOnly: true,
                          enabled: false,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextBox2(
                          controller: _phone,
                          hint: "Phone Number",
                          labelText: _uPhone,
                          readOnly: true,
                          enabled: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomDropDown(
                          hint: "Location",
                          itemList: LocationList,
                          newValue: (value) {
                            _vLocation = value;
                          },
                          itemValue: _vLocation,
                          validator: (_vLocation) {
                            if (_vLocation.isEmpty) {
                              return "Please pick location";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          margin:
                              EdgeInsets.only(left: 15, right: 15, bottom: 10),
                          child:
                              Text("Vehicle Information", style: SubHeadStyle),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomDropDown(
                          hint: "Vehicle Type",
                          itemList: VehcileTypeList,
                          newValue: (value) {
                            _vType = value;
                          },
                          itemValue: _vType,
                          validator: (_vType) {
                            if (_vType.isEmpty) {
                              return "Please pick type";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomDropDown(
                          hint: "Brand",
                          itemList: VehicleBrandList,
                          newValue: (value) {
                            _vBrand = value;
                          },
                          itemValue: _vBrand,
                          validator: (_vBrand) {
                            if (_vBrand.isEmpty) {
                              return "Please pick brand";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomDropDown(
                          hint: "Condtion",
                          itemList: VehicleConditionList,
                          newValue: (value) {
                            _vCondition = value;
                          },
                          itemValue: _vCondition,
                          validator: (_vCondition) {
                            if (_vCondition.isEmpty) {
                              return "Please pick condition";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextBox2(
                          controller: _vModel,
                          hint: "Model",
                          labelText: "Model",
                          readOnly: false,
                          enabled: true,
                          validator: (_vModel) {
                            if (_vModel.isEmpty) {
                              return "Please enter the model";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            height: 52.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                            ),
                            child: Text(
                              _Manf == DateTime.now()
                                  ? _manftext
                                  : _Manf.year.toString(),
                              style: _Manf == DateTime.now()
                                  ? HintStyle1
                                  : TextStyle(color: Colors.black),
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
                                        initialDate: _Manf,
                                        selectedDate: _Manf,
                                        onChanged: (DateTime dateTime) {
                                          _Manf = dateTime;
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  );
                                }),
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 240,
                              child: CustomTextBox2(
                                controller: _price,
                                hint: "Price",
                                labelText: "Price",
                                readOnly: false,
                                enabled: true,
                                validator: (_price) {
                                  if (_price.isEmpty) {
                                    return "Please enter the price";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 60,
                              child: Checkbox(
                                value: _vNegotiate,
                                checkColor: DefaultColor,
                                onChanged: (value) {
                                  setState(() {
                                    _vNegotiate = !_vNegotiate;
                                  });
                                },
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 80,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text("Negotoiate"),
                            ),
                            SizedBox(height: 100)
                          ],
                        ),
                        CustomDropDown(
                          hint: "Transmission type",
                          itemList: VehicleTransmissionList,
                          newValue: (value) {
                            _vTransmission = value;
                          },
                          itemValue: _vTransmission,
                          validator: (_vTransmission) {
                            if (_vTransmission.isEmpty) {
                              return "Please pick transmission type";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomDropDown(
                          hint: "Fuel type",
                          itemList: VehicleFuelList,
                          newValue: (value) {
                            _vFuel = value;
                          },
                          itemValue: _vFuel,
                          validator: (_vFuel) {
                            if (_vFuel.isEmpty) {
                              return "Please pick fuel type";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextBox2(
                          controller: _milage,
                          hint: "Milage",
                          labelText: "Milage",
                          readOnly: false,
                          enabled: true,
                          validator: (_milage) {
                            if (_milage.isEmpty) {
                              return "Please enter the milage";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextBox2(
                          controller: _addInfo,
                          minLine: 5,
                          maxLine: 10,
                          hint: "Additional information",
                          labelText: "Additional information",
                          readOnly: false,
                          enabled: true,
                        ),
                        SizedBox(height: 50),
                        GestureDetector(
                          child: CustomButton(
                            text: "Add vehicle",
                            width: 330.0,
                          ),
                          onTap: () {
                            newAd();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
