import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
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
        title: Center(child: Text('OFFERS')),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Container(),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 30.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 15.0),
            child: Text("OFFERS",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                )),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
              height: 270.0,
              width: 180.0,
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 20.0);
                  },
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 270.0,
                        width: 180.0,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        'images/dance.jpg',
                                        height: 250.0,
                                        width: 180.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                        width: 200.0,
                                        padding: EdgeInsets.only(
                                            top: 0.0, left: 8.0, right: 8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0)),
                                          child: Container(
                                            color: Colors.black,
                                            height: 80.0,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                  top: 10.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Buy 2 & Get 1 Free",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0),
                                                  ),
                                                  Text(
                                                    "Valid only for purchase\nmade by our mobile app.",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            )));
                  }),
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 15.0),
            child: Text("COUPONS",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                )),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Center(
                        child: Container(
                          height: 30.0,
                        ),
                      ),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0.0),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 150.0,
                      color: Colors.black,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: MediaQuery.of(context).size.width,
                                color: Colors.red.withOpacity(0.7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 10.0),
                                      child: Text(
                                        "Six Event Ticket with free\nglow band for each",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 9.0),
                                      ),
                                    ),
                                    SizedBox(height: 2.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 12.0),
                                      child: Container(
                                        height: 2.0,
                                        width: 150.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.21,
                                            child: Text(
                                              "20",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 65.0),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "%",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 40.0),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Text(
                                                    "OFF",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 14.0),
                                      child: Container(
                                        height: 2.0,
                                        width: 150.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 3.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 12.0),
                                      child: Text(
                                        "Club Squad Meal with two Old\nDurbar and six Carlsberg Beer",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 9.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            /*  Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: Card(
                                elevation: 4.0,
                                child: Container(
                                  height: 50.0,
                                  width: 10.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),*/
                            Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: MediaQuery.of(context).size.width,
                                color: Colors.grey.withOpacity(0.4),
                                child: SizedBox(
                                  height: 50.0,
                                  width: 50.0,
                                  child: Image.asset(
                                    "images/qr_code.png",
                                  ),
                                )),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(height: 35.0),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              child: Card(
                child: Container(
                  height: 170.0,
                  width: double.infinity,
                  color: Colors.black54.withOpacity(0.7),
                  child: Column(
                    children: [
                      SizedBox(height: 15.0),
                      Center(
                        child: Text(
                          "Refer & Earn",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 35.0, right: 35.0, top: 15.0),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            child: Container(
                              height: 50.0,
                              width: double.infinity,
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 35.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.email_outlined,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        "Yourfriend@gmail.com",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        "Refer and when your friend purchase first ticket from our app.\nYou both will be rewarded with two beer",
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }
}
