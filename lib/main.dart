import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/bloc/BlocState.dart';
import 'package:fahrenheit/screens/EventToday/Bloc/AllEventCubit.dart';
import 'package:fahrenheit/screens/MainScreen/MainScreen.dart';
import 'package:fahrenheit/screens/auth_ui/GetStarted/GetStarted.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:home_widget/home_widget.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:workmanager/workmanager.dart';

/// Used for Background Updates using Workmanager Plugin
void callbackDispatcher() {
  HomeWidget.saveWidgetData(
    'title',
    'Updated from Background',
  );
  Workmanager().executeTask((taskName, inputData) {
    return Future.wait<bool>([
      HomeWidget.saveWidgetData<Widget>(
        'message',
        Container(
          width: 200,
          height: 300,
          child: CachedNetworkImage(
            imageUrl:
                "https://www.apple.com/ac/structured-data/images/knowledge_graph_logo.png",
          ),
        ),
        // '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
      ),
      HomeWidget.updateWidget(
        name: 'YetiTechDigitalTicket',
        iOSName: 'YetiTechDigitalTicket',
        androidName: "YetiTechDigitalTicket",
      ),
    ]).then((value) {
      print(value);
      return !value.contains(false);
    });
  });
}

/// Called when Doing Background Work initiated from Widget
void backgroundCallback(Uri data) async {
  print("One");
  print(data);
  if (data.host == 'titleclicked') {
    final greetings = [
      'Hello',
      'Hallo',
      'Bonjour',
      'Hola',
      'Ciao',
      '哈洛',
      '안녕하세요',
      'xin chào'
    ];
    final selectedGreeting = greetings[Random().nextInt(greetings.length)];

    await HomeWidget.saveWidgetData<String>('title', selectedGreeting);
    await HomeWidget.updateWidget(
        name: 'YetiTechDigitalTicket', iOSName: 'YetiTechDigitalTicket');
  }
}

String getKhaltiKey() {
  String khaltiKey = "";
  if (kReleaseMode) {
    khaltiKey = 'live_public_key_71b217bd2f5c48449fd95ada7bb1941c';
  } else {
    khaltiKey = "test_public_key_3ccd85ac24764f9081d6b8c546724d58";
  }
  return khaltiKey;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  HomeWidget.setAppGroupId('group.com.yetitech.digitalticket.Digital-Ticket');
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  // HomeWidget.saveWidgetData<Widget>(
  //   'message',
  //   Container(
  //     width: 200,
  //     height: 300,
  //     child: CachedNetworkImage(
  //       imageUrl:
  //           "https://www.apple.com/ac/structured-data/images/knowledge_graph_logo.png",
  //     ),
  //   ),
  // );

  HomeWidget.registerBackgroundCallback(backgroundCallback);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: getKhaltiKey(),
        enabledDebugging: true,
        builder: (context, navKey) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AllEventsCubit>(
                lazy: false,
                create: (context) => AllEventsCubit(),
              ),
              BlocProvider<SessionCubit>(
                create: (context) => SessionCubit(),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              navigatorKey: navKey,
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.transparent,
                  iconTheme: IconThemeData(color: Colors.white),
                  titleTextStyle: GoogleFonts.poppins(
                      fontSize: 23, fontWeight: FontWeight.w600),
                  elevation: 0,
                ),
                scaffoldBackgroundColor: Colors.black,
                primarySwatch: mainPrimaryColor,
                primaryColor: mainColor,
                secondaryHeaderColor: Color(0xff2EBBA1),
                bottomAppBarColor: Color(0xff1F1F1F),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                      color: Colors.white, fontSize: 13, fontFamily: "Sf Pro"),
                  bodyText2: TextStyle(
                      color: Colors.white, fontSize: 10, fontFamily: "SF Pro"),
                  subtitle1: TextStyle(color: Colors.white),
                  subtitle2: TextStyle(color: Colors.white),
                  headline1: TextStyle(
                    fontSize: 25,
                    fontFamily: "SF Pro",
                    color: Color(0xffF6F5FC),
                    fontWeight: FontWeight.normal,
                  ),
                  headline2: TextStyle(
                    fontSize: 18,
                    fontFamily: "SF Pro",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
                    overlayColor: MaterialStateProperty.all(
                        mainPrimaryColor.withOpacity(0.4)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
                    backgroundColor:
                        MaterialStateProperty.all(mainPrimaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                ),
                dividerColor: Colors.white70,
              ),
              home: GetStartedPage(),
            ),
          );
        });
  }
}

Color mainColor = Color(0xff1DAEEF);
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
