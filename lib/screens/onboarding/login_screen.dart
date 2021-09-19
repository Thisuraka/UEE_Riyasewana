import 'package:flutter/material.dart';
import 'package:riyasewana/styles.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/custom_button2.dart';
import 'package:riyasewana/widgets/custom_textbox.dart';

@override
void initState() {}

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _password = TextEditingController();

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
              mainTitle: "Login",
              leadingImg: false,
              logo: false,
              searchIcon: false,
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
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
                      child: Column(
                        children: [
                          CustomTextBox(
                            controller: _emailAddress,
                            hint: "Email address",
                            labelText: 'Email address',
                            prifixIcon: 'assets/icons/email.png',
                            keyboardType: TextInputType.emailAddress,
                            onTap: () {},
                          ),
                          CustomTextBox(
                            controller: _password,
                            hint: "Password",
                            labelText: 'Password',
                            prifixIcon: 'assets/icons/lock.png',
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            child: CustomButton(
                              text: "Login",
                              width: 330.0,
                            ),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            child: CustomButton2(
                              text: "Reset Password",
                            ),
                            onTap: () {},
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
                            child: CustomButton2(
                              text: "Register",
                            ),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            child: Image.asset('assets/images/signGoogle.png'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
