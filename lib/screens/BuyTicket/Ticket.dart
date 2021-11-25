import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/screens/MyTickets/MyTicket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fahrenheit/screens/WalletPage.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketPage extends StatefulWidget {
  @override
  _PayWithPageState createState() => _PayWithPageState();
}

class _PayWithPageState extends State<TicketPage> {
  int people = 1;
  String ticketType = "Regular pass (Rs. 3400)";
  List<TextEditingController> controllers =
      List<TextEditingController>.generate(3, (i) => TextEditingController());

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        foregroundColor: Colors.white,
        title: Text("Ticket"),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 120),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _topRoundedBox(
                  context,
                  image: "assets/icons/ticket.png",
                  title: "Tickets",
                  isSelected: _currentIndex == 0,
                ),
                SizedBox(width: 70),
                _topRoundedBox(
                  context,
                  image: "assets/icons/payments.png",
                  title: "Payments",
                  isSelected: _currentIndex == 1,
                ),
              ],
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(bottom: Radius.elliptical(60, 60)),
        ),
      ),
      body: [
        _tickets(context),
        _payments(context),
      ][_currentIndex],
      bottomNavigationBar: [
        _bottom1(context),
        _bottom2(context)
      ][_currentIndex],
    );
  }

  Widget userInfo() {
    return Material(
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
          ],
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

  Widget _topRoundedBox(BuildContext context,
      {String image, String title, bool isSelected}) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Color(0xff3C3C3C),
              borderRadius: BorderRadius.circular(100),
            ),
            alignment: Alignment.center,
            child: Image(
              image: AssetImage(image),
              width: 30,
              height: 30,
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style:
                GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Tickets
  Widget _tickets(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: [
          userInfo(),
          SizedBox(height: 36),
          Text(
            "Select Ticket",
            style: TextStyle(
              fontFamily: "SF Pro",
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          GridView.builder(
            itemCount: 4,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 5),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 167 / 113,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              return Container(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: CachedNetworkImage(
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl:
                            "https://steamcdn-a.akamaihd.net/apps/570/icons/econ/leagues/subscriptions_nepal_inhouse_league_large.5fbedc293a72fbffa7e52af77c9aec71e7dcccf9.png",
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: Container(),
                      onPressed: () {},
                    ),
                    Positioned(
                      top: -15,
                      right: -15,
                      child: Checkbox(
                        fillColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        value: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  // Payments
  Widget _payments(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 3,
            color: Color(0xff1C1C1E),
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(
                          "VVIP PACKAGE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "रू 3000",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _infoDetail(context,
                      icon: "assets/icons/user.png", value: "Yeti Tech"),
                  _infoDetail(context,
                      icon: "assets/icons/email.png", value: "yeti@gmail.com"),
                  _infoDetail(context,
                      icon: "assets/icons/phone.png", value: "9814373666"),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                      constraints: BoxConstraints(maxWidth: 30, minHeight: 30),
                      padding: EdgeInsets.all(0),
                      splashRadius: 25,
                      icon: ImageIcon(
                        AssetImage("assets/icons/pencil.png"),
                        size: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Payment Method",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 90 / 65,
            crossAxisSpacing: 40,
            children: [
              _paymentButton(
                context,
                icon: "assets/icons/imepay.png",
                isSelected: true,
                onPressed: () {},
              ),
              _paymentButton(
                context,
                icon: "assets/icons/esewaicon.png",
                isSelected: false,
                onPressed: () {},
              ),
              _paymentButton(
                context,
                icon: "assets/icons/prabhu.png",
                isSelected: false,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 40),
          Center(
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(0xff1C1C1E),
                ),
              ),
              child: Text(
                "Other Option",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _infoDetail(BuildContext context, {String icon, String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(icon),
            size: 15,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentButton(BuildContext context,
      {String icon, bool isSelected, Function() onPressed}) {
    return Container(
      padding: EdgeInsets.zero,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image(
            fit: BoxFit.cover,
            image: AssetImage(icon),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: onPressed,
            child: Container(),
          ),
          Visibility(
            visible: isSelected,
            child: Positioned(
              right: -10,
              top: -10,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                fillColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                value: true,
                onChanged: (bool value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottom1(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      color: Color(0xff1C1C1E),
      child: Row(
        children: [
          SizedBox(width: 20),
          Text(
            "Confirm Ticket",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Spacer(),
          Container(
            width: 100,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => WalletPage()),
                // );
              },
              child: Text(
                "Confirm",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _bottom2(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      color: Color(0xff1C1C1E),
      child: Row(
        children: [
          SizedBox(width: 20),
          Checkbox(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            value: true,
            fillColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
            onChanged: (value) {},
          ),
          Text(
            "Save Payment",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Spacer(),
          Container(
            width: 100,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyTicket()),
                );
              },
              child: Text(
                "Pay Now",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
