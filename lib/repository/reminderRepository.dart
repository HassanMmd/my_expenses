import 'package:my_expenses/model/reminder.dart';

abstract class ReminderRepository {
  Future<int> addReminder(Reminder reminder);

  Future<int> deleteReminder(int id);

  Future<List<Reminder>> getReminder();
}
