import 'package:flutter/material.dart';
import 'package:fahrenheit/screens/BuyTicket/Ticket.dart';

class FoodOrderPage extends StatefulWidget {
  @override
  _FoodOrderPageState createState() => _FoodOrderPageState();
}

class _FoodOrderPageState extends State<FoodOrderPage> {
  List<String> foodTitle = ["CLUB SQUAD", "NON-ALCHOLIC", "COUPLE SPECIAL"];
  List<String> foodPrice = ["Rs20000", "Rs1500", "Rs5000"];

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
        title: Center(child: Text('FOOD ORDER')),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Container(),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 15.0),
        children: [
          SizedBox(height: 35.0),
          Text("PROMO",
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              )),
          SizedBox(height: 10.0),
          Container(
            height: 200.0,
            width: 130.0,
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 20.0);
                },
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 8.0),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 200.0,
                      width: 130.0,
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
                          child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'images/dance.jpg',
                                  height: 200.0,
                                  width: 130.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: 100.0,
                                width: 150.0,
                                color: Colors.black.withOpacity(0.4),
                                child: Center(
                                  child: Text(
                                    "Get 10 beer at Rs.5000\nwith free reservation &\ncomplimentary snacks.",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 9.0),
                                  ),
                                ),
                              ),
                            ],
                          )));
                }),
          ),
          SizedBox(height: 30.0),
          Text("OUR MENU",
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              )),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 24.0, top: 8.0),
            child: Container(
              height: 700.0,
              width: double.infinity,
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 30.0,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(top: 8.0),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(children: <Widget>[
                        Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              child: Container(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'images/dance.jpg',
                                  height: 170.0,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                                width: 400.0,
                                padding: EdgeInsets.only(
                                    top: 100.0, left: 25, right: 25),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35.0)),
                                  child: Container(
                                    color: Colors.black,
                                    height: 120.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            foodTitle[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25.0),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "FAHRENHEIT SPECIAL GRILL PORK\n6 CAN CARLSBERG BEER\n2 FULL OLD DURBAR\nSnacks & Starter",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 9.0),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 2.0),
                                                child: Text(
                                                  foodPrice[index],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 21.0),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ]),
                    );
                  }),
            ),
          ),
          SizedBox(height: 70.0),
        ],
      ),
      floatingActionButton: Container(
        height: 50.0,
        width: double.infinity,
        color: Colors.transparent,
        child: Center(
          child: Container(
            height: 40.0,
            width: 160.0,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TicketPage()),
                );
              },
              child: Text(
                "Order Now",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
