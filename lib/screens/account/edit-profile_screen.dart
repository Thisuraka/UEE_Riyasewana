import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/screens/account/user-profile_screen.dart';
import 'package:riyasewana/styles.dart';
import 'package:riyasewana/utils/settings.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/custom_button2.dart';
import 'package:riyasewana/widgets/custom_textbox.dart';

@override
void initState() {}

class EditProfileScreen extends StatefulWidget {
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _emailAddress = TextEditingController();
  var _fName = TextEditingController();
  var _lName = TextEditingController();
  var _phoneNumber = TextEditingController();
  var _password = TextEditingController();
  var _confPassword = TextEditingController();

  String _uid = "";
  String _name = "";
  String _email = "";
  String _mobile = "";
  String _token = "";
  void getUser() async {
    await Settings.getUserID().then((value) => {_uid = value!});
    await Settings.getFName().then((value) => {_fName.text = value!});
    await Settings.getLName().then((value) => {_lName.text = value!});
    await Settings.getUserEmail()
        .then((value) => {_emailAddress.text = value!});
    await Settings.getUserPhone().then((value) => {_phoneNumber.text = value!});
    await Settings.getAccessToken().then((value) => {_token = value!});

    setState(() {});
  }

  @override
  void initState() {
    getUser();
  }

  void updateUser() async {
    if (_formKey.currentState!.validate()) {
      if (_password.text != _confPassword.text) {
        Fluttertoast.showToast(
          msg: "Password mismatched",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      } else {
        final response = await ApiCalls.updateUser(
          id: _uid,
          token: _token,
          fName: _fName.text,
          lName: _lName.text,
          mobile: _phoneNumber.text,
          password: _password.text,
        );
        if (response.isSuccess) {
          var json = response.jsonBody;
          await Settings.setSigned(true);
          String fName = json['first_name'];
          await Settings.setFName(fName);
          String lName = json['last_name'];
          await Settings.setLName(lName);
          String userPhone = json['mobile'];
          await Settings.setUserPhone(userPhone);
          String userEmail = json['email'];
          await Settings.setUserEmail(userEmail);

          Fluttertoast.showToast(
            msg: "Welcome",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: CustomAppbarWidget(
          mainTitle: "Edit account data",
          leadingImg: false,
          logo: false,
          searchIcon: true,
        ),
      ),
      body: GestureDetector(
        onTap: () => {FocusScope.of(context).unfocus()},
        child: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, top: 40),
                  child: Text("Riyasewana",
                      style: TextStyle(
                          fontFamily: DefaultFont,
                          color: DefaultColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 40.0)),
                ),
                Container(
                  height: 550,
                  // color: Colors.amber,
                  margin: EdgeInsets.only(top: 100),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextBox(
                          controller: _emailAddress,
                          hint: "Email address",
                          labelText: 'Email address',
                          readOnly: true,
                          enabled: false,
                          prifixIcon: 'assets/icons/email.png',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CustomTextBox(
                          controller: _fName,
                          hint: "First Name",
                          labelText: 'First Name',
                          prifixIcon: 'assets/icons/account.png',
                          keyboardType: TextInputType.text,
                          validator: (_fName) {
                            if (_fName.isEmpty) {
                              return "Please enter your first name";
                            }
                            return null;
                          },
                        ),
                        CustomTextBox(
                          controller: _lName,
                          hint: "Last Name",
                          labelText: 'Last Name',
                          prifixIcon: 'assets/icons/account.png',
                          keyboardType: TextInputType.text,
                          validator: (_lName) {
                            if (_lName.isEmpty) {
                              return "Please enter your last name";
                            }
                            return null;
                          },
                        ),
                        CustomTextBox(
                          controller: _password,
                          hint: "Password",
                          labelText: 'Password',
                          prifixIcon: 'assets/icons/lock.png',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (_password) {
                            if (_password.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                        ),
                        CustomTextBox(
                          controller: _confPassword,
                          hint: "Confrim Password",
                          labelText: 'Confrim Password',
                          prifixIcon: 'assets/icons/lock.png',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (_confPassword) {
                            if (_confPassword.isEmpty) {
                              return "Please re-enter password";
                            }
                            return null;
                          },
                        ),
                        CustomTextBox(
                          controller: _phoneNumber,
                          hint: "Phone Number",
                          labelText: 'Phone Number',
                          prifixIcon: 'assets/icons/phone.png',
                          readOnly: true,
                          keyboardType: TextInputType.phone,
                          validator: (_phoneNumber) {
                            if (_phoneNumber.isEmpty) {
                              return "Please enter your phone number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: updateUser,
                          child: CustomButton(
                            text: "Confirm",
                            width: 330.0,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
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
