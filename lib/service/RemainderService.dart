import 'package:fahrenheit/screens/EventDetail/Model/Tickets.dart';
import 'package:fahrenheit/screens/MyTickets/MyTicket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Remender {
  void selectNotification(String payload, BuildContext context) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => MyTicket()),
    );
  }

  setRemender(BuildContext context) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: (_, __, ___, ____) {
      print("One");
    });
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {
      selectNotification(payload, context);
    });

    final bool result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(
      badgeNumber: 1,
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    tz.initializeTimeZones();
    final nep = tz.getLocation("Asia/Kathmandu");
    var tx = tz.TZDateTime.now(nep);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);
    print(tx.toString());
    DateTime dateTime = DateTime.now();
    tz.TZDateTime.parse(nep, dateTime.toString());

    var time =
        tz.TZDateTime.parse(nep, dateTime.toString()).add(Duration(seconds: 8));
    print(time);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      "Remainder",
      "Its time for you Event",
      tz.TZDateTime.now(nep).add(Duration(seconds: 8)),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
    // flutterLocalNotificationsPlugin.show(
    //   1,
    //   "Remainder",
    //   "Its time for you Event",
    //   platformChannelSpecifics,
    //   payload: "Happy",
    // );

    print("Ok");
  }
}
