import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

//Custom Package
import 'package:fahrenheit/screens/PaymentPage.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
        title: Center(child: Text('WALLET')),
        actions: [
          IconButton(
              icon: Icon(Icons.forward),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              })
        ],
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
                height: 350.0,
                width: double.infinity,
                color: Colors.grey.withOpacity(0.4),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Activities",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10.0),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        child: Container(
                            height: 60.0,
                            width: double.infinity,
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.watch_later_outlined,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Checked in Sunday\n10:00 pm",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(height: 15.0),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        child: Container(
                            height: 60.0,
                            width: double.infinity,
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.money,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Reward Received\n10% Off on Food",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(height: 15.0),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        child: Container(
                            height: 60.0,
                            width: double.infinity,
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Free Monthly Beer\n6 Out of 10 Remaining",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(height: 15.0),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        child: Container(
                            height: 60.0,
                            width: double.infinity,
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.money,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Holi Bash Ticket Purchased\n2 VIP ticket purchased",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 70.0,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.4),
          )
        ],
      ),
    );
    ;
  }
}
