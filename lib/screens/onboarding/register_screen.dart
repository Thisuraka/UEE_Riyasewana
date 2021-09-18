import 'package:flutter/material.dart';
import 'package:riyasewana/styles.dart';
import 'package:riyasewana/widgets/custom_appbar.dart';
import 'package:riyasewana/widgets/custom_button.dart';
import 'package:riyasewana/widgets/custom_button2.dart';
import 'package:riyasewana/widgets/custom_textbox.dart';

@override
void initState() {}

class RegisterScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _fName = TextEditingController();
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
              mainTitle: "Create account",
              leadingImg: false,
              logo: false,
              searchIcon: true,
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
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
                          controller: _fName,
                          hint: "First Name",
                          labelText: 'First Name',
                          prifixIcon: 'assets/icons/account.png',
                          keyboardType: TextInputType.text,
                          onTap: () {},
                        ),
                        CustomTextBox(
                          controller: _lName,
                          hint: "Last Name",
                          labelText: 'Last Name',
                          prifixIcon: 'assets/icons/account.png',
                          keyboardType: TextInputType.text,
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
                        CustomTextBox(
                          controller: _confPassword,
                          hint: "Confrim Password",
                          labelText: 'Confrim Password',
                          prifixIcon: 'assets/icons/lock.png',
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          onTap: () {},
                        ),
                        CustomTextBox(
                          controller: _phoneNumber,
                          hint: "Phone Number",
                          labelText: 'Phone Number',
                          prifixIcon: 'assets/icons/phone.png',
                          keyboardType: TextInputType.phone,
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          child: CustomButton(
                            text: "Register",
                          ),
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          child: Text(
                            "Terms and Conditions",
                            style: TextButtonStyle,
                          ),
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          child: CustomButton2(
                            text: "Already have Account?  Login",
                          ),
                          onTap: () {},
                        ),
                      ],
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