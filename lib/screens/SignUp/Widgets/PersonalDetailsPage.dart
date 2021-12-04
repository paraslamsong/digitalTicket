import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                    SizedBox(height: 30.0),
                    Text("Full Name", style: textStyle),
                    SizedBox(height: 5.0),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: controllers[0],
                      validator: validateForm,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.next,
                    ),
                    // SizedBox(height: 20.0),
                    // Text("Last Name", style: textStyle),
                    // SizedBox(height: 5.0),
                    // TextFormField(
                    //   keyboardType: TextInputType.name,
                    //   controller: controllers[1],
                    //   validator: validateForm,
                    //   cursorColor: Colors.white,
                    //   style: TextStyle(color: Colors.white),
                    //   textInputAction: TextInputAction.next,
                    // ),
                    SizedBox(height: 20.0),
                    Text("Email", style: textStyle),
                    SizedBox(height: 5.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: controllers[2],
                      validator: validateEmail,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20.0),
                    Text("Password", style: textStyle),
                    SizedBox(height: 5.0),
                    TextFormField(
                      controller: controllers[3],
                      validator: validatePassword,
                      cursorColor: Colors.white,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: Text(
                        "Gender",
                        style: textStyle,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        genderBtn("Male", () {
                          onGenderSelect("Male");
                        }, this.gender == "Male"),
                        SizedBox(
                          width: 40,
                        ),
                        genderBtn("Female", () {
                          onGenderSelect("Female");
                        }, this.gender == "Female"),
                      ],
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
              Text(
                "Accept terms and conditions",
                style: TextStyle(color: Colors.white, fontSize: 10.0),
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
}
