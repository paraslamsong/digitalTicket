import 'package:fahrenheit/screens/SignUp/Bloc/SignUpModel.dart';
import 'package:fahrenheit/screens/utils/ImageIcons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class PaymentsPage extends StatefulWidget {
  final SignUp state;
  final TabController tabController;
  final Function(String) onOTPComplete;
  PaymentsPage({this.tabController, this.state, this.onOTPComplete});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  String pin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 25.0),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 3.0,
            color: Color(0xFF1C1C1E),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Your detail",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: ImageIcon(
                          ImageIcons.edit,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        onPressed: () {
                          this.widget.tabController.animateTo(0);
                        },
                      ),
                    ],
                  ),
                  _information(context,
                      icon: ImageIcons.user,
                      value: this.widget.state.firstName),
                  _information(context,
                      icon: ImageIcons.email, value: this.widget.state.email),
                  _information(context,
                      icon: ImageIcons.email, value: this.widget.state.phone),
                  _information(context,
                      icon: ImageIcons.email, value: this.widget.state.dob),
                  _information(context,
                      icon: ImageIcons.email,
                      value: this.widget.state.location),
                  SizedBox(height: 20),
                  Text(
                    "Enter OTP we sent you",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: OTPTextField(
                      length: 4,
                      fieldWidth: 50,
                      width: double.infinity,
                      style: TextStyle(fontSize: 17, color: Colors.white),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle: OtpFieldStyle(
                          backgroundColor: Colors.black38,
                          borderColor: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          pin = value;
                        });
                      },
                      onCompleted: (pin) {
                        widget.onOTPComplete(pin);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Didn't get OTP? ",
                        style: TextStyle(fontSize: 11),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 40,
                        icon: Text(
                          "Resend",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          widget.state.sendOtp();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100.0,
        width: double.infinity,
        color: Color(0xFF1C1C1E),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: Container()),
            TextButton(
              onPressed: () {
                if (pin.length < 4)
                  Fluttertoast.showToast(msg: "Enter complete OTP");
                else
                  widget.onOTPComplete(pin);
              },
              child: Text(
                "Verify Now",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Widget _information(BuildContext context,
      {ImageProvider icon, String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ImageIcon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: 15),
          Text(value),
        ],
      ),
    );
  }
}
