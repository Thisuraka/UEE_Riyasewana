import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riyasewana/utils/helper.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/custom_dropdown.dart';
import 'package:riyasewana/widgets/custom_imagePicker.dart';
import 'package:riyasewana/widgets/custom_textbox2.dart';
import '../../styles.dart';

class EditPartScreen extends StatefulWidget {
  @override
  _EditPartScreenState createState() => _EditPartScreenState();
}

class _EditPartScreenState extends State<EditPartScreen> {
  String _pLocation = "";
  String _pType = "";
  String _pCatagory = "";
  String _pCondition = "";
  bool _pNegotiate = false;

  List<XFile>? _imageFileList = [];
  bool _gen = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _addInfo = TextEditingController();

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
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text("Contact Information", style: SubHeadStyle),
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
                        margin:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text("Parts Information", style: SubHeadStyle),
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
                        controller: _phone,
                        hint: "Brand / Model",
                        labelText: "Brand / Model",
                        readOnly: false,
                        enabled: true,
                        onTap: () {},
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
                              onTap: () {},
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
                        onTap: () {},
                      ),
                      SizedBox(height: 50),
                      GestureDetector(
                        child: CustomButton(
                          text: "Confirm",
                          width: 330.0,
                        ),
                        onTap: () {},
                      ),
                    ],
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
