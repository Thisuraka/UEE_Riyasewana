class Validate {
  String? validatemobile(value) {
    if (value.isEmpty) {
      return "Please enter your mobile number";
    } else if (value.length != 10 || !value.startsWith("0")) {
      return "The mobile number you have entered is invalid";
    } else {
      return null;
    }
  }

  String? validateEmail(value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return "Email invalid";
    }
  }
}
