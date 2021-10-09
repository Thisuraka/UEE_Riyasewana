import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riyasewana/utils/helper.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/custom_dropdown.dart';
import 'package:riyasewana/widgets/custom_imagePicker.dart';
import 'package:riyasewana/widgets/custom_imagePicker2.dart';
import 'package:riyasewana/widgets/custom_textbox2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:riyasewana/utils/settings.dart';
import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/screens/account/user-profile_screen.dart';
import '../../styles.dart';

class EditPartScreen extends StatefulWidget {
  @override
  _EditPartScreenState createState() => _EditPartScreenState();
  String adID = "";
  EditPartScreen({required this.adID});
}

class _EditPartScreenState extends State<EditPartScreen> {
  String _token = "";
  String _pLocation = "";
  String _pType = "";
  String _pCatagory = "";
  String _pCondition = "";
  bool _pNegotiate = false;
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
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _addInfo = TextEditingController();
  TextEditingController _pName = TextEditingController();

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
        await ApiCalls.userPartAdGet(adID: widget.adID, token: _token);
    if (response.isSuccess) {
      print("======================================");
      _pLocation = response.jsonBody["pLocation"];
      _pType = response.jsonBody["pType"];
      _pCatagory = response.jsonBody["pCatagory"];
      _pCondition = response.jsonBody["pCondition"];
      _pName.text = response.jsonBody["pName"];
      _price.text = response.jsonBody["pPrice"];
      _addInfo.text = response.jsonBody["pInfo"];
      if (response.jsonBody["pNegotiate"] == "true") {
        _pNegotiate = true;
      } else {
        _pNegotiate = false;
      }
      _cloudImages = response.jsonBody["pImages"];
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

        final response = await ApiCalls.partsUpdate(
          adID: widget.adID,
          token: _token,
          pLocation: _pLocation,
          pType: _pType,
          pCatagory: _pCatagory,
          pCondition: _pCondition,
          pName: _pName.text,
          pPrice: _price.text,
          pNegotiate: _pNegotiate.toString(),
          pInfo: _addInfo.text,
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
                              CustomTextBox2(
                                controller: _phone,
                                hint: "Phone Number",
                                labelText: _phoneTxt,
                                readOnly: true,
                                enabled: true,
                              ),
                              CustomDropDown(
                                hint: "Location",
                                itemList: LocationList,
                                newValue: (value) {
                                  _pLocation = value;
                                },
                                itemValue: _pLocation,
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
                              ),
                              CustomDropDown(
                                hint: "Part Catagory",
                                itemList: PartCatagoryList,
                                newValue: (value) {
                                  _pCatagory = value;
                                },
                                itemValue: _pCatagory,
                              ),
                              CustomDropDown(
                                hint: "Condtion",
                                itemList: PartConditionList,
                                newValue: (value) {
                                  _pCondition = value;
                                },
                                itemValue: _pCondition,
                              ),
                              CustomTextBox2(
                                controller: _pName,
                                hint: "Brand / Model",
                                labelText: "Brand / Model",
                                readOnly: false,
                                enabled: true,
                                validator: (_pName) {
                                  if (_pName.isEmpty) {
                                    return "Please enter the model";
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
                                    padding: EdgeInsets.symmetric(vertical: 20),
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
                                  text: "Confirm",
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
