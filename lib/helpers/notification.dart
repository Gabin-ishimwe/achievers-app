import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationClass {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'task_notification_channel', 'Task Notifications',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker'),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOsSettings = DarwinInitializationSettings();
    var settings =
        InitializationSettings(android: androidSettings, iOS: iOsSettings);

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) async {
        // final payload = response.notification.payload;
        print('received a notification $response');
        // onNotifications.add(payload);
      },

      // (payload) async {
      //   print('received a notification $payload');
      //   onNotifications.add(payload as String?);
      // },
    );

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      print('location: $locationName');
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static void showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload_data,
    required DateTime scheduledDate,
  }) async =>
      {
        print('$id, $title, $body, $payload_data, $scheduledDate'),
        _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await _notificationDetails(),
          payload: payload_data,
          androidScheduleMode: AndroidScheduleMode.inexact,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        )
      };
}
