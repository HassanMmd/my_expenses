import 'package:my_expenses/model/reminder.dart';
import 'package:my_expenses/repository/reminderRepository.dart';
import 'package:my_expenses/services/dataBase.dart';
import 'package:my_expenses/services/reminderAndNotifications.dart';
import 'package:sqflite/sqflite.dart';

class ReminderRepositoryImpl implements ReminderRepository {

  Database db = DataBaseHelper.database!;

  @override
  Future<int> addReminder(Reminder reminder) async {
    int id= await db.insert('reminder', reminder.toMap());
    return id;
  }
  //


  @override
  Future<List<Reminder>> getReminder() async {
    var remindersList = await db.query('reminder');
    var reminder = remindersList.map((e) => Reminder.fromMap(e));
    return reminder.toList();
  }

  @override
  Future<int> deleteReminder(int id) async {
    return await db.delete('reminder', where: 'id=?', whereArgs: [id]);
  }
}
