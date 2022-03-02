import 'package:fahrenheit/screens/EventToday/EventsTodayPage.dart';
import 'package:fahrenheit/screens/MyTickets/MyTicket.dart';
import 'package:fahrenheit/screens/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = [
    EventsTodayPage(),
    MyTicket(),
    ProfileScreen(),
  ];

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: pages[currentPage],
      ),
      bottomNavigationBar: _bottomNavigationBar(context, current: currentPage,
          onItemPressed: (page) {
        setState(() {
          currentPage = page;
        });
      }),
    );
  }
}

Widget _bottomNavigationBar(
  BuildContext context, {
  int current = 0,
  Function(int) onItemPressed,
}) {
  return Container(
    height: 90,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      color: Theme.of(context).bottomAppBarColor,
    ),
    child: Row(
      children: [
        _bottomNavigationItem(
          icon: "assets/icons/bottomHome.png",
          label: "Home",
          isSelected: current == 0,
          onPressed: () => {onItemPressed(0)},
        ),
        _bottomNavigationItem(
          icon: "assets/icons/bottomTicket.png",
          label: "Tickets",
          isSelected: current == 1,
          onPressed: () => {onItemPressed(1)},
        ),
        _bottomNavigationItem(
          icon: "assets/icons/bottomProfile.png",
          label: "Profile",
          isSelected: current == 2,
          onPressed: () => {onItemPressed(2)},
        )
      ],
    ),
  );
}

Widget _bottomNavigationItem({
  String icon,
  String label,
  bool isSelected,
  Function() onPressed,
}) {
  return Expanded(
    child: Center(
      child: Builder(builder: (context) {
        if (isSelected)
          return Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xff3C3C3C),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  icon,
                  width: 29,
                ),
                SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 12.5),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          );
        return IconButton(
          onPressed: onPressed,
          icon: Image.asset(
            icon,
            width: 29,
          ),
        );
      }),
    ),
  );
}
