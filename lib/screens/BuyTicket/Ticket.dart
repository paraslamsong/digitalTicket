import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/model/User.dart';
import 'package:fahrenheit/screens/BuyTicket/Model/TicketModel.dart';
import 'package:fahrenheit/screens/BuyTicket/Popups/PeopleSectionDialog.dart';
import 'package:fahrenheit/screens/BuyTicket/Popups/PromoCodeDialog.dart';
import 'package:fahrenheit/screens/BuyTicket/Widgets/DateSelection.dart';
import 'package:fahrenheit/screens/EventDetail/Model/EventDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketPage extends StatefulWidget {
  final List<Package> packages;
  final List<Rate> tickets;
  final String organizerName;
  final int id;
  TicketPage({this.tickets, this.organizerName, this.packages, this.id});
  @override
  _PayWithPageState createState() => _PayWithPageState();
}

class _PayWithPageState extends State<TicketPage> {
  int people = 1;
  List<TextEditingController> controllers =
      List<TextEditingController>.generate(
          3, (i) => TextEditingController(text: ""));
  Rate _selectedTicket = Rate();
  TicketModel _ticketModel = TicketModel();
  PaymentType _paymentType = PaymentType.Khalti;
  int _currentIndex = 0;

  final _formKey = GlobalKey<FormState>();

  bool isLoggedIn = (User().getAcess() != "");

  PromocodeModel _promocodeModel = PromocodeModel.fromJson({}, "");

  Package _package = Package();

  @override
  void initState() {
    super.initState();
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _information(
                context,
                icon: AssetImage("assets/icons/userIcon.png"),
                hintText: "First Name",
                controller: controllers[0],
                // ignore: missing_return
                validator: (value) {
                  if (value == "")
                    return "This field cannot be empty";
                  else if (!value.contains(" ")) return "Enter Full name";
                },
              ),
              _information(
                context,
                hintText: "Email",
                icon: AssetImage("assets/icons/emailIcon.png"),
                controller: controllers[1],
                // ignore: missing_return
                validator: (value) {
                  if (value == "")
                    return "This field cannot be empty";
                  else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) return "Enter valid email";
                },
              ),
              _information(
                context,
                hintText: "Phone",
                icon: AssetImage("assets/icons/phoneIcon.png"),
                controller: controllers[2],
                // ignore: missing_return
                validator: (value) {
                  if (value == "")
                    return "This field cannot be empty";
                  else if (value.length < 6) return "Enter valid phone number";
                },
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
    String Function(String) validator,
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
        validator: validator,
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
          Visibility(
            visible: !isLoggedIn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userInfo(),
                SizedBox(height: 36),
              ],
            ),
          ),
          DateSelectionWidget(
            packages: widget.packages,
            selected: _package,
            onSelect: (package) {
              setState(() {
                _package = package;
              });
            },
          ),
          Text(
            "Select Ticket",
            style: TextStyle(
              fontFamily: "SF Pro",
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          GridView.builder(
            itemCount: widget.tickets.length,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 5),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 4.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              bool isSelected = _selectedTicket == widget.tickets[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(18)),
                            child: CachedNetworkImage(
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              imageUrl: widget.tickets[index].image,
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color(0xff1C1C1E),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.tickets[index].name.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "रू " + widget.tickets[index].rate.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2FBCA1),
                                ),
                              ),
                              Container(
                                height: 20,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/people.png",
                                      height: 10,
                                    ),
                                    SizedBox(width: 5),
                                    Visibility(
                                      visible: isSelected,
                                      child: Text(
                                        people.toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.red
                                              : Colors.white.withOpacity(0.44),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: Container(),
                      onPressed: () {
                        showDialog(
                          barrierColor: Colors.black.withOpacity(0.78),
                          context: context,
                          builder: (context) => PeopleSelectionDialog(
                            adults: people,
                            inclusions: widget.tickets[index].ticketInclusions,
                            onPeopleChange: (adults) {
                              setState(() {
                                people = adults;
                              });
                            },
                          ),
                        );

                        if (_selectedTicket == widget.tickets[index]) return;
                        setState(() {
                          _selectedTicket = widget.tickets[index];
                          // people = 1;
                        });
                      },
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              _selectedTicket.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "रू ${(people * _selectedTicket.rate).toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: _promocodeModel.id != 0,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Promo Applied",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "रू -${_promocodeModel.off.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "रू ${(_promocodeModel.grandtotal).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: !isLoggedIn,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoDetail(context,
                            icon: "assets/icons/user.png",
                            value: controllers[0].text ?? ""),
                        _infoDetail(context,
                            icon: "assets/icons/email.png",
                            value: controllers[1].text ?? ""),
                        _infoDetail(context,
                            icon: "assets/icons/phone.png",
                            value: controllers[2].text ?? ""),
                      ],
                    ),
                  ),
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
          PromocodeBox(
            id: widget.id,
            onCodeApply: (promo) {
              promo.calculate(_selectedTicket.rate * people);
              setState(() {
                _promocodeModel = promo;
              });
            },
          ),
          SizedBox(height: 20),
          Text(
            "Payment Method",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Visibility(
            visible: _selectedTicket.rate > 0.0,
            child: Center(
              child: _paymentButton(
                context,
                icon: "assets/icons/khalti.jpg",
                isSelected: true,
                onPressed: () {
                  setState(() {
                    _paymentType = PaymentType.Khalti;
                  });
                },
              ),
            ),
          ),
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
      width: 100,
      height: 60,
      padding: EdgeInsets.zero,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(icon),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
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
            "रू " + (people * _selectedTicket.rate).toString(),
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Spacer(),
          Container(
            width: 100,
            child: TextButton(
              onPressed: () {
                if (!isLoggedIn) {
                  if (!_formKey.currentState.validate()) return;
                }
                if (_package.id == 0) {
                  final snackBar =
                      SnackBar(content: Text("Select date please"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
                if (_selectedTicket.id == 0) {
                  final snackBar =
                      SnackBar(content: Text("Select ticket please"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                return setState(() {
                  _currentIndex = 1;
                });
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
            width: 130,
            child: TextButton(
              onPressed: () {
                _ticketModel.saveData(
                  name: controllers[0].text,
                  email: controllers[1].text,
                  phone: controllers[2].text,
                  paymentType: _paymentType,
                  rate: _selectedTicket,
                  organizer: widget.organizerName,
                  counts: people,
                  code: _promocodeModel,
                  pack: _package,
                );
                _ticketModel.promocode = _promocodeModel;
                _ticketModel.bookTicket(context, _selectedTicket.id);
              },
              child: Text(
                "Proceed Now",
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
