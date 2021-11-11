import 'package:fahrenheit/screens/SignUp/Bloc/SignUpModel.dart';
import 'package:fahrenheit/screens/SignUp/Widgets/PaymentsPage.dart';
import 'package:fahrenheit/screens/SignUp/Widgets/PersonalDetailsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
      statusBarBrightness: Brightness.dark,
    ));
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _tabController.index = _tabController.index;
      });
    });
  }

  final _controllers = List.generate(4, (i) => TextEditingController());

  String gender = "Male";
  bool acceptTerms = false;

  SignUp user = SignUp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.0),
          ),
        ),
        backgroundColor: Color(0xFF1C1C1E),
        title:
            Text(_tabController.index == 0 ? "Personal Details" : "OTP Verify"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                _tabButton("images/house.png", "Personal Details", 0),
                _tabButton("images/payment.png", "OTP Verify", 1),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          PersonalDetailsPage(
              tabController: _tabController,
              controllers: _controllers,
              gender: gender,
              acceptTerms: acceptTerms,
              onAcceptTerm: (value) {
                setState(() {
                  acceptTerms = value;
                });
              },
              onGenderSelect: (value) {
                setState(() {
                  gender = value;
                });
              },
              onNextPage: () {
                user.setUserDetails(
                  firstName: _controllers[0].text,
                  lastName: _controllers[1].text,
                  email: _controllers[2].text,
                  gender: gender,
                  password: _controllers[3].text,
                  acceptTerms: acceptTerms,
                );
                user.sendOtp();
              }),
          PaymentsPage(
            tabController: _tabController,
            state: this.user,
            onOTPComplete: (value) {
              user.createUser(context, otp: value);
            },
          ),
        ],
      ),
    );
  }

  Widget _tabButton(icon, title, index) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: _tabController.index == index
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(
              icon,
              height: 26,
              color: Colors.white,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color:
                  _tabController.index == index ? Colors.white : Colors.white38,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
