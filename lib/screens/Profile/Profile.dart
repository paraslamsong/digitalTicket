import 'package:fahrenheit/model/User.dart';
import 'package:fahrenheit/screens/Profile/Model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    print(User().getRefresh());
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Card(
        margin: EdgeInsets.all(20),
        elevation: 2,
        color: Color(0xFF1C1C1E),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: FutureBuilder<UserModel>(
              future: userModel.fetchData(),
              builder: (context, AsyncSnapshot<UserModel> snapshot) {
                if (snapshot.hasData)
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _information(context,
                          title: "First Name", value: snapshot.data.firstName),
                      Divider(),
                      _information(context,
                          title: "Last Name", value: snapshot.data.lastName),
                      Divider(),
                      _information(context,
                          title: "Email", value: snapshot.data.email),
                      Divider(),
                      _information(context,
                          title: "Gender", value: snapshot.data.gender),
                    ],
                  );
                else if (snapshot.connectionState == ConnectionState.waiting)
                  return Container(
                      height: 200, child: Center(child: CircularProgressIndicator()));
                else
                  return Text("Error");
              }),
        ),
      ),
    );
  }

  Widget _information(BuildContext context, {String title, String value}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
        SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
