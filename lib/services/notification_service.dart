import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static const String highChannelId = 'high_importance_channel';
  static const String highChannelName = 'High Importance Notifications';
  static const String highChannelDesc =
      'Channel for important notifications such as recipe of the day.';

  static const String dailyChannelId = 'daily_channel';
  static const String dailyChannelName = 'Daily Notifications';
  static const String dailyChannelDesc =
      'Daily reminder to check recipe of the day.';
  static Future<void> initialize() async {
    tz.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidInit,
    );

    await _plugin.initialize(initSettings);
    const AndroidNotificationChannel highChannel = AndroidNotificationChannel(
      highChannelId,
      highChannelName,
      description: highChannelDesc,
      importance: Importance.high,
    );

    final androidImpl =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImpl?.createNotificationChannel(highChannel);
  }
  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      highChannelId,
      highChannelName,
      channelDescription: highChannelDesc,
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _plugin.show(0, title, body, details);
  }
  static Future<void> scheduleDailyRecipeNotification({
    int hour = 21,
    int minute = 15,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      dailyChannelId,
      dailyChannelName,
      channelDescription: dailyChannelDesc,
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);
    await _plugin.zonedSchedule(
      1,
      'Recipe of the day',
      'Open the app to see today\'s random recipe! 🍲',
      scheduledDate,
      details,
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
