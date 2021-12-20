import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }
    var dateText = _addSeperators(newValue.text, '-');
    return newValue.copyWith(
        text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 3) {
        newString += seperator;
      }
      if (i == 5) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

class PersonalDetailsPage extends StatelessWidget {
  final TabController tabController;
  final List<TextEditingController> controllers;
  final String gender;
  final bool acceptTerms;
  final Function(String) onGenderSelect;
  final Function(bool) onAcceptTerm;
  final Function onNextPage;
  PersonalDetailsPage(
      {this.tabController,
      this.controllers,
      this.gender,
      this.acceptTerms,
      this.onGenderSelect,
      this.onAcceptTerm,
      this.onNextPage});

  final TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 14.0);
  final TextStyle textStyle2 =
      TextStyle(color: Color(0xFF7F7F80), fontSize: 11.0);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Color(0xFF1C1C1E),
            elevation: 3.0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    _information(
                      context,
                      icon: AssetImage("assets/icons/userIcon.png"),
                      hintText: "Full Name",
                      controller: controllers[0],
                      validator: validateForm,
                    ),
                    _information(
                      context,
                      hintText: "Email",
                      icon: AssetImage("assets/icons/emailIcon.png"),
                      controller: controllers[1],
                      validator: validateEmail,
                      keyboardtype: TextInputType.emailAddress,
                    ),
                    _information(
                      context,
                      hintText: "Password",
                      icon: AssetImage("assets/icons/passwordicon.png"),
                      controller: controllers[2],
                      obscureText: true,
                      validator: validateForm,
                    ),
                    _information(
                      context,
                      hintText: "Confirm Password",
                      icon: AssetImage("assets/icons/confirmPasswordIcon.png"),
                      controller: controllers[6],
                      obscureText: true,
                      validator: (value) {
                        if (value == "")
                          return "This field is required";
                        else if (value != controllers[2].text)
                          return "Passwords doesnot match";
                        return null;
                      },
                    ),
                    _information(
                      context,
                      hintText: "Phone",
                      icon: AssetImage("assets/icons/phoneIcon.png"),
                      controller: controllers[3],
                      validator: validatePhone,
                      keyboardtype: TextInputType.phone,
                    ),
                    _information(
                      context,
                      hintText: "yyyy-mm-dd",
                      inputFormatters: [
                        DateTextFormatter(),
                      ],
                      maxLength: 10,
                      controller: controllers[4],
                      icon: AssetImage("assets/icons/dobIcon.png"),
                      validator: validateForm,
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (_) => Container(
                                  height: 190,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 180,
                                        child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.date,
                                            initialDateTime: DateTime.now()
                                                .subtract(
                                                    Duration(days: 18 * 365)),
                                            onDateTimeChanged: (val) {
                                              controllers[4].text =
                                                  val.year.toString() +
                                                      "-" +
                                                      val.month.toString() +
                                                      "-" +
                                                      val.day.toString();
                                            }),
                                      ),
                                    ],
                                  ),
                                ));
                      },
                    ),
                    _information(
                      context,
                      hintText: "Location",
                      controller: controllers[5],
                      validator: validateForm,
                      icon: AssetImage("assets/icons/locationIcon.png"),
                      keyboardtype: TextInputType.text,
                      done: true,
                    ),
                    Material(
                      elevation: 2,
                      color: Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(28),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _genderButton(
                              context,
                              icon: "assets/icons/maleIcon.png",
                              isSelected: gender.toUpperCase() == "MALE",
                              title: "Male",
                            ),
                            SizedBox(width: 20),
                            _genderButton(
                              context,
                              icon: "assets/icons/femaleIcon.png",
                              isSelected: gender.toUpperCase() == "FEMALE",
                              title: "Female",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 100.0,
          width: double.infinity,
          color: Color(0xFF1C1C1E),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Checkbox(
                value: this.acceptTerms,
                checkColor: Colors.white,
                activeColor: Color(0xff2FBDA1),
                fillColor: MaterialStateProperty.all(Color(0xff2FBDA1)),
                shape: CircleBorder(),
                onChanged: (bool value) {
                  onAcceptTerm(value);
                },
              ),
              InkWell(
                onTap: () async {
                  String _url =
                      "https://www.meroticketapp.com/termsandconditions";
                  if (!await launch(_url)) throw 'Could not launch $_url';
                },
                child: Text(
                  "Accept terms and conditions",
                  style: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
              ),
              Spacer(),
              Hero(
                tag: "LoginBtn",
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (!this.acceptTerms)
                        Fluttertoast.showToast(
                            msg: "Please accept our terms and conditions");
                      else {
                        onNextPage();
                        tabController.animateTo(tabController.index + 1);
                      }
                    }
                  },
                  child: Text(
                    "NEXT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 18.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget genderBtn(String title, Function() onTap, bool isSelected) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(75),
            onTap: onTap,
            child: Stack(
              children: [
                ClipOval(
                  child: Image(
                    image: AssetImage('images/${title.toLowerCase()}.png'),
                    height: 75,
                  ),
                ),
                Visibility(
                  visible: isSelected,
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xff2FBDA1),
                    size: 29.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter email';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter valid Email';
    } else {
      return null;
    }
  }

  String validateForm(String value) {
    if (value.isEmpty) {
      return 'This field required';
    } else {
      return null;
    }
  }

  String validatePhone(String value) {
    if (value.isEmpty) {
      return 'This field required';
    } else if (value.length < 10) {
      return 'Enter 10 digit mobile number';
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'This field required';
    } else if (value.length < 8) {
      return 'Enter 8 digit password';
    } else {
      return null;
    }
  }

  Widget _information(
    BuildContext context, {
    AssetImage icon,
    TextEditingController controller,
    String hintText,
    List<TextInputFormatter> inputFormatters,
    int maxLength,
    String Function(String) validator,
    bool obscureText = false,
    TextInputType keyboardtype = TextInputType.text,
    bool done = false,
    Function() onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        highlightColor: Colors.transparent,
        onTap: onPressed,
        child: TextFormField(
          enabled: onPressed == null,
          controller: controller,
          style: TextStyle(
              fontSize: 13, fontFamily: "SF Pro", color: Colors.white),
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          maxLines: 1,
          obscureText: obscureText,
          keyboardType: keyboardtype,
          textInputAction: done ? TextInputAction.done : TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            isDense: false,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(100),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(100),
            ),
            prefixIcon: ImageIcon(
              icon,
              color: Colors.white,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              maxWidth: 50,
              minWidth: 50,
            ),
            prefixStyle: TextStyle(color: Colors.white),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white38,
              fontFamily: "SF Pro",
              fontSize: 13,
            ),
            filled: true,
            fillColor: Colors.black,
          ),
          validator: validator,
        ),
      ),
    );
  }

  Widget _genderButton(BuildContext context,
      {String icon, String title, bool isSelected}) {
    return Container(
      child: IconButton(
        onPressed: () {
          onGenderSelect(title.toUpperCase());
        },
        iconSize: 85,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: 57, minHeight: 87),
        icon: Column(
          children: [
            Opacity(
              opacity: isSelected ? 1 : 0.3,
              child: Image(
                width: 57,
                height: 57,
                image: AssetImage(icon),
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontFamily: "SF Pro",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
