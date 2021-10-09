import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

class AddPartScreen extends StatefulWidget {
  @override
  _AddPartScreenState createState() => _AddPartScreenState();
}

class _AddPartScreenState extends State<AddPartScreen> {
  String _token = "";
  String _uNname = "";
  String _fName = "";
  String _lName = "";
  String _uPhone = "";
  String _pLocation = "";
  String _pType = "";
  String _pCatagory = "";
  String _pCondition = "";
  bool _pNegotiate = false;
  List<XFile>? _imageFileList = [];
  List<String> _imgPaths = [];
  bool _gen = false;

  bool _loaded = true;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _addInfo = TextEditingController();
  TextEditingController _pModel = TextEditingController();

  @override
  void initState() {
    getUserData();
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
        _loaded = false;
        final response = await ApiCalls.partsAd(
          token: _token,
          pCatagory: _pCatagory,
          pType: _pType,
          pCondition: _pCondition,
          pName: _pModel.text,
          pPrice: _price.text,
          pNegotiate: _pNegotiate.toString(),
          pInfo: _addInfo.text,
          pLocation: _pLocation,
          pImages: _imgPaths,
        );

        if (response.isSuccess) {
          var json = response.jsonBody;

          _loaded = true;

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
          mainTitle: "Add parts",
          leadingImg: false,
          logo: false,
          searchIcon: false,
        ),
      ),
      body: _loaded
          ? GestureDetector(
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
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10),
                                child: Text("Contact Information",
                                    style: SubHeadStyle),
                              ),
                              CustomTextBox2(
                                controller: _name,
                                hint: "Name",
                                labelText: _uNname,
                                readOnly: true,
                                enabled: false,
                              ),
                              CustomTextBox2(
                                controller: _phone,
                                hint: "Phone Number",
                                labelText: _uPhone,
                                readOnly: true,
                                enabled: false,
                              ),
                              CustomDropDown(
                                hint: "Location",
                                itemList: LocationList,
                                newValue: (value) {
                                  _pLocation = value;
                                },
                                itemValue: _pLocation,
                                validator: (_pLocation) {
                                  if (_pLocation.isEmpty) {
                                    return "Please select location";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10),
                                child: Text("Parts Information",
                                    style: SubHeadStyle),
                              ),
                              CustomDropDown(
                                hint: "Part Type",
                                itemList: PartTypeList,
                                newValue: (value) {
                                  _pType = value;
                                },
                                itemValue: _pType,
                                validator: (_pType) {
                                  if (_pType.isEmpty) {
                                    return "Please select type";
                                  }
                                  return null;
                                },
                              ),
                              CustomDropDown(
                                hint: "Part Catagory",
                                itemList: PartCatagoryList,
                                newValue: (value) {
                                  _pCatagory = value;
                                },
                                itemValue: _pCatagory,
                                validator: (_pCatagory) {
                                  if (_pCatagory.isEmpty) {
                                    return "Please select catagory";
                                  }
                                  return null;
                                },
                              ),
                              CustomDropDown(
                                hint: "Condtion",
                                itemList: PartConditionList,
                                newValue: (value) {
                                  _pCondition = value;
                                },
                                itemValue: _pCondition,
                                validator: (_pCondition) {
                                  if (_pCondition.isEmpty) {
                                    return "Please select condition";
                                  }
                                  return null;
                                },
                              ),
                              CustomTextBox2(
                                controller: _pModel,
                                hint: "Brand / Model",
                                labelText: "Brand / Model",
                                readOnly: false,
                                enabled: true,
                                validator: (_vModel) {
                                  if (_vModel.isEmpty) {
                                    return "Please enter the brand / model";
                                  }
                                  return null;
                                },
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
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Checkbox(
                                      value: _pNegotiate,
                                      checkColor: DefaultColor,
                                      onChanged: (value) {
                                        setState(() {
                                          _pNegotiate = true;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: 80,
                                    padding:
                                        EdgeInsets.only(bottom: 10, top: 10),
                                    child: Text("Negotoiate"),
                                  ),
                                  SizedBox(height: 100)
                                ],
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
                                  text: "Add part",
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
            )
          : SpinKitFoldingCube(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? DefaultColor : InactiveColor,
                  ),
                );
              },
            ),
    );
  }
}
