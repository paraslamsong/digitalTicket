// import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

//Custom Package
import 'package:fahrenheit/screens/MyTickets/TicketDetail.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.black,
        title: Center(child: Text("PAYMENT")),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        children: [
          SizedBox(
            height: 25.0,
          ),
          Text(
            "Select Your Prefer Payment",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/imepay.png',
                      height: 55.0,
                      width: 90.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  Toast.show("IMEPay", context,
                      gravity: Toast.BOTTOM,
                      duration: Toast.LENGTH_LONG,
                      backgroundColor: Colors.black);
                },
              ),
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/esewa.png',
                      height: 55.0,
                      width: 90.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  Toast.show("ESewa", context,
                      gravity: Toast.BOTTOM,
                      duration: Toast.LENGTH_LONG,
                      backgroundColor: Colors.black);
                },
              ),
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/imepay.png',
                      height: 55.0,
                      width: 90.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  Toast.show("PrabhuPay", context,
                      gravity: Toast.BOTTOM,
                      duration: Toast.LENGTH_LONG,
                      backgroundColor: Colors.black);
                },
              ),
            ],
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              child: Container(
                height: 550.0,
                width: double.infinity,
                color: Colors.grey.withOpacity(0.4),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full Name",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextFormField(
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        "Esewa ID",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextFormField(
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        "Payment Note",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextFormField(
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        "Pricing Details",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                              Text(
                                "20% for Couple Booking",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Text(
                            "-Rs800",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 5.0),
                        child: Container(
                          height: 20.0,
                          width: 70.0,
                          color: Colors.cyanAccent.withOpacity(0.5),
                          child: FlatButton(
                              onPressed: () {
                                Toast.show("More Offers", context,
                                    gravity: Toast.BOTTOM,
                                    duration: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.black);
                              },
                              child: Text(
                                "More Offers",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 7.0),
                              )),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // Container(
                      //   height: 35.0,
                      //   child: DottedBorder(
                      //     color: Colors.green,
                      //     strokeWidth: 0.5,
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             "Additional savings",
                      //             style: TextStyle(
                      //                 color: Colors.white, fontSize: 15.0),
                      //           ),
                      //           Text(
                      //             "Rs2500",
                      //             style: TextStyle(
                      //                 color: Colors.white, fontSize: 15.0),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price to pay",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            "Rs2500",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          )
                        ],
                      ),
                      SizedBox(height: 40.0),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 18,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TicketDetailPage()),
                              );
                            },
                            child: Text(
                              "Pay Now",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 13.0,
              width: MediaQuery.of(context).size.width / 2.8,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: FlatButton(
                onPressed: () {
                  Toast.show("Other Option", context,
                      gravity: Toast.BOTTOM,
                      duration: Toast.LENGTH_LONG,
                      backgroundColor: Colors.black);
                },
                child: Text(
                  "Other Option",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 60.0),
        ],
      ),
    );
  }
}
