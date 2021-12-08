import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/model/User.dart';
import 'package:fahrenheit/screens/Profile/Model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserModel userModel = UserModel();

  final List<TextEditingController> controllers =
      List<TextEditingController>.generate(5, (i) => TextEditingController());
  String image, gender = "MALE";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await userModel.fetchData();

    controllers[0].text = userModel.firstName;
    controllers[1].text = userModel.email;
    controllers[2].text = userModel.phone;
    controllers[3].text = userModel.dob;
    controllers[4].text = userModel.location;
    setState(() {
      gender = userModel.gender ?? "MALE";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        title: Text("Profile"),
        // bottom: PreferredSize(
        //   preferredSize: Size(double.infinity, 120),
        //   child: Container(
        //     width: double.infinity,
        //     padding: EdgeInsets.symmetric(vertical: 20),
        //     child: Center(
        //       child: Stack(
        //         clipBehavior: Clip.none,
        //         children: [
        //           ClipRRect(
        //             borderRadius: BorderRadius.circular(100),
        //             child: CachedNetworkImage(
        //               height: 90,
        //               width: 90,
        //               fit: BoxFit.cover,
        //               imageUrl:
        //                   "https://images.hindustantimes.com/img/2021/08/20/1600x900/82f2cb26-01e5-11ec-8bb0-cae8e339dabd_1629485044566.jpg",
        //             ),
        //           ),
        //           Positioned(
        //             right: 0,
        //             bottom: 0,
        //             child: IconButton(
        //               icon: Container(
        //                 decoration: BoxDecoration(
        //                   color: Theme.of(context).primaryColor,
        //                   borderRadius: BorderRadius.circular(100),
        //                 ),
        //                 child: Icon(Icons.camera),
        //               ),
        //               onPressed: () {},
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // shape: RoundedRectangleBorder(
        //   borderRadius:
        //       BorderRadius.vertical(bottom: Radius.elliptical(60, 60)),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Color(0xFF1C1C1E),
                  title: Text(
                    'Do you want to logout?',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        User().logout(context);
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
              //
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Material(
                elevation: 2,
                color: Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _information(
                        context,
                        icon: AssetImage("assets/icons/userIcon.png"),
                        hintText: "First Name",
                        controller: controllers[0],
                      ),
                      _information(
                        context,
                        hintText: "Email",
                        icon: AssetImage("assets/icons/emailIcon.png"),
                        controller: controllers[1],
                      ),
                      _information(
                        context,
                        hintText: "Phone",
                        icon: AssetImage("assets/icons/phoneIcon.png"),
                        controller: controllers[2],
                      ),
                      _information(
                        context,
                        hintText: "yyyy-mm-dd",
                        icon: AssetImage("assets/icons/dobIcon.png"),
                        inputFormatters: [
                          DateTextFormatter(),
                        ],
                        maxLength: 10,
                        controller: controllers[3],
                      ),
                      _information(
                        context,
                        icon: AssetImage("assets/icons/locationIcon.png"),
                        hintText: "Location",
                        controller: controllers[4],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 56),
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
              SizedBox(height: 56),
              TextButton(
                onPressed: () {
                  userModel.saveChanges(
                    context,
                    fullName: controllers[0].text,
                    email: controllers[1].text,
                    phone: controllers[2].text,
                    dob: controllers[3].text,
                    location: controllers[4].text,
                    gender: gender,
                  );
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _information(
    BuildContext context, {
    AssetImage icon,
    TextEditingController controller,
    String hintText,
    List<TextInputFormatter> inputFormatters,
    int maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        style:
            TextStyle(fontSize: 13, fontFamily: "SF Pro", color: Colors.white),
        inputFormatters: inputFormatters,
        maxLength: maxLength,
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
      ),
    );
  }

  Widget _genderButton(BuildContext context,
      {String icon, String title, bool isSelected}) {
    return Container(
      child: IconButton(
        onPressed: () {
          setState(() {
            gender = title.toUpperCase();
          });
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
