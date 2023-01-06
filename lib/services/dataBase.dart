import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  DataBaseHelper._();

  static DataBaseHelper instance = DataBaseHelper._();
  static Database? database;

  static initDatabase() async {
    var path = await getDatabasesPath();
    database =
        await openDatabase(path + 'money.db', version: 22, onCreate: (db, i) async{
    await  db.execute('''
      CREATE TABLE money (id INTEGER PRIMARY KEY ,amount REAL ,text TEXT, date INTEGER,categoryId INTEGER);
      
       ''');
   await db.execute('''
    CREATE TABLE category (id INTEGER PRIMARY KEY, name TEXT );
    ''');

   await db.execute('''
   CREATE TABLE reminder (id INTEGER PRIMARY KEY, description TEXT, Date INTEGER);
   
   ''');
    });
  }
}
