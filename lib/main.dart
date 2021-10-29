import 'package:fahrenheit/bloc/BlocState.dart';
import 'package:fahrenheit/screens/auth_ui/GetStarted/GetStarted.dart';
import 'package:fahrenheit/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
    statusBarBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: mainPrimaryColor,
        primaryColor: mainColor,
        accentColor: Color(0xff2EBBA1),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.white),
          subtitle2: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: EdgeInsets.only(bottom: 7, top: 10),
          enabledBorder: new UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        visualDensity: VisualDensity.compact,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
            backgroundColor: MaterialStateProperty.all(Colors.red),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
          ),
        ),
        dividerColor: Colors.white70,
      ),
      // home: BlocBuilder<BlocCubit, BlocState>(
      //   builder: (context, state) => SplashPage(),
      home: GetStartedPage(),

      // ),
    );
  }
}

Color mainColor = Color(0xffE82D30);
Map<int, Color> maincolor = {
  50: mainColor.withOpacity(.1),
  100: mainColor.withOpacity(.2),
  200: mainColor.withOpacity(.3),
  300: mainColor.withOpacity(.4),
  400: mainColor.withOpacity(.5),
  500: mainColor.withOpacity(.6),
  600: mainColor.withOpacity(.7),
  700: mainColor.withOpacity(.8),
  800: mainColor.withOpacity(.9),
  900: mainColor.withOpacity(1),
};
MaterialColor mainPrimaryColor = MaterialColor(mainColor.value, maincolor);
