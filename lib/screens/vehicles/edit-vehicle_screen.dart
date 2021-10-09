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
import 'package:riyasewana/widgets/custom_imagePicker2.dart';
import 'package:riyasewana/widgets/custom_textbox2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../styles.dart';

class EditVehicleScreen extends StatefulWidget {
  @override
  _EditVehicleScreenState createState() => _EditVehicleScreenState();

  String adID = "";
  EditVehicleScreen({required this.adID});
}

class _EditVehicleScreenState extends State<EditVehicleScreen> {
  String _token = "";
  String _vLocation = "";
  String _vType = "";
  String _vBrand = "";
  String _vCondition = "";
  String _vTransmission = "";
  String _vFuel = "";
  String _manftext = "Manufactury year";
  DateTime _Manf = DateTime.now();
  bool _vNegotiate = false;
  bool _loaded = false;
  int _imgLimiter = 0;
  String _nameTxt = "";
  String _lname = "";
  String _fname = "";
  String _phoneTxt = "";

  List<XFile>? _imageFileList = [];
  List<dynamic>? _cloudImages = [];
  List<String> _imgPaths = [];
  List<String> _cloudImgPaths = [];
  bool _gen = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _price = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _addInfo = TextEditingController();
  TextEditingController _milage = TextEditingController();
  TextEditingController _vModel = TextEditingController();

  void getUser() async {
    await Settings.getAccessToken().then((value) => {_token = value!});
    await Settings.getFName().then((value) => {_fname = value!});
    await Settings.getLName().then((value) => {_lname = value!});
    await Settings.getUserPhone().then((value) => {_phoneTxt = value!});

    _nameTxt = _fname + " " + _lname;

    setState(() {});
    getAdData();
  }

  void getAdData() async {
    final response =
        await ApiCalls.userVehicleAdGet(adID: widget.adID, token: _token);
    if (response.isSuccess) {
      print("======================================");
      _vLocation = response.jsonBody["vLocation"];
      _vType = response.jsonBody["vType"];
      _vBrand = response.jsonBody["vBrand"];
      _vCondition = response.jsonBody["vCondition"];
      _vModel.text = response.jsonBody["vModel"];
      _price.text = response.jsonBody["vPrice"];
      _vTransmission = response.jsonBody["vTransType"];
      _vFuel = response.jsonBody["vFuelType"];
      _milage.text = response.jsonBody["vMilage"];
      _addInfo.text = response.jsonBody["vInfo"];
      _Manf = DateTime(int.parse(response.jsonBody["vManfYear"]));
      if (response.jsonBody["vNegotiate"] == "true") {
        _vNegotiate = true;
      } else {
        _vNegotiate = false;
      }
      _cloudImages = response.jsonBody["vImages"];
      _imgLimiter = _cloudImages!.length;

      _loaded = true;
      setState(() {});
    } else {
      _loaded = false;
      setState(() {});
    }
  }

  Future<void> updateAd() async {
    if (_formKey.currentState!.validate()) {
      if (_imageFileList!.length < 1 && _cloudImages!.length < 1) {
        Fluttertoast.showToast(
          msg: "Please add images",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      } else {
        for (int i = 0; i < _imageFileList!.length; i++) {
          _imgPaths.add(_imageFileList![i].path);
        }

        for (int i = 0; i < _cloudImages!.length; i++) {
          _cloudImgPaths.add(_cloudImages![i]);
        }

        final response = await ApiCalls.vehiclesUpdate(
          adID: widget.adID,
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
          vImages: _cloudImgPaths,
          newImages: _imgPaths,
        );

        print(response.apiStatus);
        _loaded = false;
        if (response.isSuccess) {
          var json = response.jsonBody;

          print(json);

          Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );

          _loaded = true;
          _cloudImgPaths.clear();
          _imgPaths.clear();

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UserProfile()));
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
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: CustomAppbarWidget(
          mainTitle: "Edit ad data",
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
                        "Photos " +
                            (_imageFileList!.length + _imgLimiter).toString() +
                            "/9",
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
                      width: double.infinity,
                      height: 100,
                      child: CustomImagePicker2(_cloudImages, removeCloudImage,
                          gen: _gen),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 260),
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
                                labelText: _nameTxt,
                                readOnly: true,
                                enabled: false,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextBox2(
                                controller: _phone,
                                hint: "Phone Number",
                                labelText: _phoneTxt,
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
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10),
                                child: Text("Vehicle Information",
                                    style: SubHeadStyle),
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
                                    border: Border.all(
                                        color: Colors.black, width: 0.5),
                                  ),
                                  child: Text(
                                    _Manf == DateTime.now()
                                        ? _manftext
                                        : _Manf.year.toString(),
                                    style: _Manf == DateTime.now()
                                        ? HintStyle1
                                        : TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
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
                                      })
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
                                          _vNegotiate = true;
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
                                  }),
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
                                  text: "Confrim",
                                  width: 330.0,
                                ),
                                onTap: () {
                                  updateAd();
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

  void removeCloudImage(int index) {
    _cloudImages!.removeAt(index);
    _imgLimiter = _cloudImages!.length;

    setState(() {});
  }

  void setCloudGen() {
    if (_cloudImages!.length > 0) {
      _gen = true;
    } else {
      _gen = false;
    }
    setState(() {});
  }

  Future<void> addImage() async {
    _imageFileList = await Helper.selectNewImages(_imgLimiter);
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
}
