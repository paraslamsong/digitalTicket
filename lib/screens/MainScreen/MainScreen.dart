import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fahrenheit/bloc/BlocState.dart';
import 'package:fahrenheit/screens/EventToday/EventsTodayPage.dart';
import 'package:fahrenheit/screens/MyTickets/MyTicket.dart';
import 'package:fahrenheit/screens/Profile/Profile.dart';
import 'package:fahrenheit/screens/auth_ui/Model/UserLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/src/provider.dart';

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

  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          physics: !context.read<SessionCubit>().state
              ? NeverScrollableScrollPhysics()
              : BouncingScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              currentPage = page;
            });
          },
          controller: _pageController,
          children: pages,
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        child: BottomNavyBar(
          selectedIndex: currentPage,
          showElevation: true,
          animationDuration: Duration(milliseconds: 300),
          onItemSelected: (index) {
            if (!context.read<SessionCubit>().state) {
              Fluttertoast.showToast(msg: "Please login");
              return;
            }
            setState(() {
              currentPage = index;
            });
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.linear);
          },
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          itemCornerRadius: 10,
          items: [
            BottomNavyBarItem(
              icon: Image.asset(
                "assets/icons/bottomHome.png",
                width: 29,
              ),
              title: Text('Home'),
              textAlign: TextAlign.center,
              activeColor: Colors.white,
            ),
            BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: Image.asset(
                  "assets/icons/bottomTicket.png",
                  width: 29,
                ),
                title: Text('Ticket'),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Image.asset(
                  "assets/icons/bottomProfile.png",
                  width: 29,
                ),
                title: Text('Profile'),
                textAlign: TextAlign.center,
                activeColor: Colors.white),
          ],
        ),
      ),
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
