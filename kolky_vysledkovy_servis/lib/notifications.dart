import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kolky_vysledkovy_servis/screens/match_detail_page.dart';
import 'models/match.dart';
import 'dart:async';

class NotificationController {
  static Future<void> initializeNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    InitializationSettings initializationSettings =
        const InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future showMatchNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Match match) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'match_channel_id',
      'match_channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Zápas začína',
      '${match.homeName} vs. ${match.awayName}',
      platformChannelSpecifics,
      payload: match.id.toString(),
    );
  }
}
