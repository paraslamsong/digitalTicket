String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.isEmpty) {
    return 'Please Enter Email';
  } else if (!regExp.hasMatch(value)) {
    return 'Enter Valid Email';
  } else {
    return null;
  }
}

String validatePassword(String value) {
  if (value.isEmpty) {
    return 'This field required';
  } else {
    return null;
  }
}
