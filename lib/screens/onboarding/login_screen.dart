import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riyasewana/api/api_calls.dart';
import 'package:riyasewana/screens/onboarding/register_screen.dart';
import 'package:riyasewana/styles.dart';
import 'package:riyasewana/utils/settings.dart';
import 'package:riyasewana/utils/validate.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/custom_button2.dart';
import 'package:riyasewana/widgets/custom_textbox.dart';

import '../home_screen.dart';

@override
void initState() {}

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _signin() async {
      if (_formKey.currentState!.validate()) {
        final response = await ApiCalls.signIn(
            email: _emailAddress.text, password: _password.text);

        if (response.isSuccess) {
          var json = response.jsonBody;
          await Settings.setSigned(true);
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: CustomAppbarWidget(
          mainTitle: "Login",
          leadingImg: false,
          logo: false,
          searchIcon: false,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 30),
                    child: Text("Riyasewana",
                        style: TextStyle(
                            fontFamily: DefaultFont,
                            color: DefaultColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 40.0)),
                  ),
                  Container(
                    height: 510,
                    margin: EdgeInsets.only(top: 150),
                    child: Form(
                      key: _formKey,
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
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            child: CustomButton(
                              text: "Login",
                              width: 330.0,
                            ),
                            onTap: () {
                              _signin();
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            child: Text(
                              "Terms and Conditions",
                              style: TextButtonStyle,
                            ),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                            },
                            child: CustomButton2(
                              text: "Register",
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            child: Image.asset('assets/images/signGoogle.png'),
                            onTap: () {
                              Fluttertoast.showToast(
                                msg: "Coming soon...",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                              );
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
      ),
    );
  }
}
