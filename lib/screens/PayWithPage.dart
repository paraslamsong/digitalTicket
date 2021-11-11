import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fahrenheit/screens/WalletPage.dart';
import 'package:numberpicker/numberpicker.dart';

class PayWithPage extends StatefulWidget {
  @override
  _PayWithPageState createState() => _PayWithPageState();
}

class _PayWithPageState extends State<PayWithPage> {
  int people = 1;
  String ticketType = "Regular pass (Rs. 3400)";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Buy Ticket'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Material(
              elevation: 10,
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _information(context,
                          title: "Event Name", value: "New year event---"),
                      _information(context,
                          title: "Event date", value: "Mar 19, 2020"),
                      _information(context,
                          title: "Event time", value: "5:30 PM"),
                      _information(context,
                          title: "Door opens", value: "5:00 PM"),
                      Divider(),
                      PopupMenuButton(
                        tooltip: "Select ticket",
                        offset: Offset(6, 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: _information(context,
                                  title: "Ticket type", value: ticketType),
                            ),
                            Text(
                              "Choose ticket",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              setState(() {
                                ticketType = "Regular pass (Rs. 3400)";
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "Regular pass",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  "Rs 3400",
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                            value: 2,
                          ),
                          PopupMenuItem(
                            onTap: () {
                              setState(() {
                                ticketType = "VIP pass (Rs. 3400)";
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "VIP pass",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  "Rs 5400",
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                            value: 1,
                          ),
                        ],
                      ),
                      _ticketSelection(context,
                          title: "Choose show",
                          value: "1st Show",
                          btnTitle: "Choose show"),
                      SizedBox(height: 6),
                      _userInformationInput(context,
                          title: "Your Name",
                          controller: TextEditingController()),
                      _userInformationInput(context,
                          title: "Your contact number",
                          controller: TextEditingController()),
                      _userInformationInput(context,
                          title: "Your address",
                          controller: TextEditingController()),
                      Row(
                        children: [
                          Text(
                            "No of people",
                            style:
                                TextStyle(fontSize: 12, color: Colors.white70),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () => setState(() =>
                                people = people != 1 ? people - 1 : people),
                            icon: Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: NumberPicker(
                              value: people,
                              minValue: 0,
                              maxValue: 9,
                              decoration: BoxDecoration(),
                              itemCount: 3,
                              itemWidth: 16,
                              itemHeight: 30,
                              axis: Axis.horizontal,
                              onChanged: (value) =>
                                  setState(() => people = value),
                            ),
                          ),
                          IconButton(
                            onPressed: () => setState(() =>
                                people = people < 9 ? people + 1 : people),
                            icon: Text(
                              "+",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 100,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "BACK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              width: 100,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WalletPage()),
                  );
                },
                child: Text(
                  "PAY",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ticketSelection(BuildContext context,
      {String title,
      String value,
      String btnTitle,
      Function(dynamic) onSelect}) {
    return PopupMenuButton(
      tooltip: btnTitle,
      offset: Offset(6, 30),
      child: Row(
        children: [
          Expanded(
            child: _information(context, title: title, value: value),
          ),
          Text(
            btnTitle,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            setState(() {
              ticketType = "Regular pass (Rs. 3400)";
            });
          },
          child: Column(
            children: [
              Text(
                "Regular pass",
                style: TextStyle(fontSize: 10),
              ),
              Text(
                "Rs 3400",
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
          value: 2,
        ),
        PopupMenuItem(
          onTap: () {
            setState(() {
              ticketType = "VIP pass (Rs. 3400)";
            });
          },
          child: Column(
            children: [
              Text(
                "VIP pass",
                style: TextStyle(fontSize: 10),
              ),
              Text(
                "Rs 5400",
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
          value: 1,
        ),
      ],
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

  Widget _userInformationInput(BuildContext context,
      {String title, TextEditingController controller}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white60, fontSize: 12),
        ),
        TextFormField(
          cursorColor: Colors.white,
          controller: controller,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: new UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
