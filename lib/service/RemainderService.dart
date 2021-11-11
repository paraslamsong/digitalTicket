import 'package:fahrenheit/screens/MyTickets/MyTicket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  setRemender(BuildContext context, {DateTime date}) async {
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
    print(result);

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "alarm notification",
      "alarm notification",
      icon: "@mipmap/ic_launcher",
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.max,
      fullScreenIntent: true,
    );

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(
      badgeNumber: 1,
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    tz.initializeTimeZones();

    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    try {
      flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "Remainder",
        "Its time for you Event",
        tz.TZDateTime.from(date, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        payload: "Hello",
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (err) {
      Fluttertoast.showToast(msg: err);
    }
  }
}
