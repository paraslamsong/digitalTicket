import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

//Custom Package
import 'package:fahrenheit/screens/WalletPage.dart';

class PayWithPage extends StatefulWidget {
  @override
  _PayWithPageState createState() => _PayWithPageState();
}

class _PayWithPageState extends State<PayWithPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50.0),
        )),
        backgroundColor: Colors.grey.withOpacity(0.37),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Center(child: Text('PAY WITH')),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Container(),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 25.0),
          Container(
            height: 200.0,
            width: 260.0,
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 35.0);
                },
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 200.0,
                      width: 260.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: Offset(4, 4),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'images/dance.jpg',
                            height: 200.0,
                            width: 260.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ));
                }),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              child: Container(
                height: 300.0,
                width: double.infinity,
                color: Colors.grey.withOpacity(0.4),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name on Card",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextFormField(
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        "Card Number",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextFormField(
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        "Expiry Date",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextFormField(
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 35.0),
          Container(
            height: 80.0,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 45.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: FlatButton(
                    onPressed: () {
                      Toast.show("Back", context,
                          gravity: Toast.BOTTOM,
                          duration: Toast.LENGTH_LONG,
                          backgroundColor: Colors.black);
                    },
                    child: Text(
                      "BACK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: 45.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: FlatButton(
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
          SizedBox(height: 45.0),
        ],
      ),
    );
  }
}
