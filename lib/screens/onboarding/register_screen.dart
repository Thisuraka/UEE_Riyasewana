import 'package:flutter/material.dart';
import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/screens/home_screen.dart';
import 'package:riyasewana/screens/onboarding/login_screen.dart';
import 'package:riyasewana/styles.dart';
import 'package:riyasewana/utils/settings.dart';
import 'package:riyasewana/utils/validate.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/custom_button2.dart';
import 'package:riyasewana/widgets/custom_textbox.dart';
import 'package:fluttertoast/fluttertoast.dart';

@override
void initState() {}

class RegisterScreen extends StatefulWidget {
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _fName = TextEditingController();
  TextEditingController _lName = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confPassword = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _reset() {
      _emailAddress = TextEditingController();
      _fName = TextEditingController();
      _lName = TextEditingController();
      _phoneNumber = TextEditingController();
      _password = TextEditingController();
    }

    void signUp() async {
      if (_formKey.currentState!.validate()) {
        if (_password.text != _confPassword.text) {
          Fluttertoast.showToast(
            msg: "Password mismatched",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        } else {
          final response = await ApiCalls.signUp(
              email: _emailAddress.text,
              fName: _fName.text,
              lName: _lName.text,
              mobile: _phoneNumber.text,
              password: _password.text);
          if (response.isSuccess) {
            var json = response.jsonBody;
            String accessToken = json['token'];
            await Settings.setAccessToken(accessToken);
            String userID = json['_id'];
            await Settings.setUserID(userID);
            String fName = json['first_name'];
            await Settings.setFName(fName);
            String lName = json['last_name'];
            await Settings.setLName(lName);
            String userPhone = json['mobile'];
            await Settings.setUserPhone(userPhone);
            String userEmail = json['email'];
            await Settings.setUserEmail(userEmail);
            _reset();

            Fluttertoast.showToast(
              msg: "Welcome",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
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

    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: CustomAppbarWidget(
              mainTitle: "Create account",
              leadingImg: false,
              logo: false,
              searchIcon: false,
            ),
          ),
          body: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextBox(
                            controller: _emailAddress,
                            hint: "Email address",
                            labelText: 'Email address',
                            prifixIcon: 'assets/icons/email.png',
                            keyboardType: TextInputType.emailAddress,
                            validator: (_emailAddress) {
                              if (_emailAddress.isEmpty) {
                                return "Please enter your email address";
                              }
                              Validate().validateEmail(_emailAddress);
                            },
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
                                return "Please enter your password";
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
                            keyboardType: TextInputType.phone,
                            validator: (_phoneNumber) {
                              if (_phoneNumber.isEmpty) {
                                return "Please enter phone number";
                              }
                              Validate().validatemobile(_phoneNumber);
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            child: CustomButton(
                              text: "Register",
                              width: 330.0,
                            ),
                            onTap: () async {
                              signUp();
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            child: Text(
                              "Terms and Conditions",
                              style: TextButtonStyle,
                            ),
                            onTap: () {
                              Fluttertoast.showToast(
                                msg: "Terms and conditions",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                              );
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            },
                            child: CustomButton2(
                              text: "Already have Account?  Login",
                            ),
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
      ),
    );
  }
}
