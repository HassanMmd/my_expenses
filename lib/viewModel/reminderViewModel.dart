import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_expenses/model/reminder.dart';
import 'package:my_expenses/repository/reminderRepositoryImpl.dart';

import '../services/reminderAndNotifications.dart';

class ReminderViewModel extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationService notificationService = NotificationService();
  ReminderRepositoryImpl reminderRepositoryImpl = ReminderRepositoryImpl();

  Future addReminder(Reminder reminder) async {
    int id = await reminderRepositoryImpl.addReminder(reminder);
    await notificationService.scheduleNotifications(
        id: id, title: 'Note', body: reminder.description, time: reminder.date);
    notifyListeners();
  }

  Future<List<Reminder>> gerReminders() async {
    return await reminderRepositoryImpl.getReminder();
  }

  void deleteItem(int id) async {
    reminderRepositoryImpl.deleteReminder(id);
    await flutterLocalNotificationsPlugin.cancel(id);

    notifyListeners();
  }
}
