//class for handling notifications
//This class will also expose methods to create/send/cancel notifications.


import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
//1. take an object from  FlutterLocalNotificationsPlugin to use package

  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

//2. initialize the notifications

  Future<void> init() async {
    //1.object Andriod initialization Settings

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/launch_background');

    //2. object IOS initialization Settings
    //requestAlertPermission
    //requestBadgePermission
    //requestSoundPermission
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    //3. object InitializationSettings
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    //5.initialize notifications
    await localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  //4.method
  void _onDidReceiveNotificationResponse(NotificationResponse details) {}

  NotificationDetails notificationDetails()  {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    return  const NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
  }

//////////////////////////////////////////////////use it??
  ///method show immediately notification

  Future<void> showInstantNotification(
      {required int id, required String title, required String body}) async {
    await localNotificationsPlugin.show(
        id, title, body,notificationDetails() );
  }
}
