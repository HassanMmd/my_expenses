import 'package:my_expenses/model/money.dart';
import 'package:my_expenses/repository/moneyRepository.dart';
import 'package:my_expenses/services/dataBase.dart';
import 'package:sqflite/sqflite.dart';

class MoneyRepositoryImpl implements MoneyRepository {
  Database db = DataBaseHelper.database!;

  @override
  Future<int> addMoney(Money money) async {
    return await db.insert('money', money.toMap());
  }

  @override
  Future<int> deleteMoney(int id) async {
    return await db.delete('money', where: 'id=?', whereArgs: [id]);
  }

  @override
  Future<List<Money>> getMoney() async {
    var listOfMoney = await db.rawQuery('''
   select money.*,category.name from money left join category on money.categoryId = category.id;
   
   ''');
    var money = listOfMoney.map((e) => Money.fromMap(e));
    return money.toList();
  }

  @override
  Future<List<Money>> getMoneyByDate(int? startDate, int? endDate) async {
    var listOfMoneyByDate = await db.rawQuery('''

select money.*,category.name from money left join category on money.categoryId = category.id WHERE date BETWEEN $startDate AND $endDate;
    ''');
    var money = listOfMoneyByDate.map((e) => Money.fromMap(e));
    return money.toList();
  }

  // SELECT *, SUM(amount)AS "totalAmount" FROM money GROUP BY categoryId;
  @override
  Future<List<Money>> getSumValues() async {
    var sum = await db.rawQuery('''

  
  select money.*,SUM(money.amount)AS "totalAmount", category.name from money left join category on money.categoryId = category.id GROUP BY categoryId;
    ''');
    var sumList = sum.map((e) => Money.fromMap(e));
    return sumList.toList();
  }

  @override
  Future<double> getTotalForWeek(int startDate, int endDate) async {
    var totalWeek = await db.rawQuery('''
    SELECT SUM(money.amount)AS "totalWeek" FROM money WHERE date BETWEEN $startDate AND $endDate;
    ''');
    if (totalWeek.first['totalWeek'] == null) {
      return 0.0;
    } else {
      return totalWeek.first['totalWeek'] as double;
    }
  }

  @override
  Future<double> getTotalForMonth(int startDate, int endDate) async {
    var totalMonth = await db.rawQuery('''
    SELECT SUM(money.amount)AS "totalMonth" FROM money WHERE date BETWEEN $startDate AND $endDate;
    ''');
    if (totalMonth.first['totalMonth'] == null) {
      return 0.0;
    } else {
      return totalMonth.first['totalMonth'] as double;
    }
  }

  @override
  Future<double> getTotalForYear(int startDate, int endDate) async{
    var totalYear = await db.rawQuery('''
    SELECT SUM(money.amount)AS "totalMonth" FROM money WHERE date BETWEEN $startDate AND $endDate;
    ''');
    if (totalYear.first['totalMonth'] == null) {
      return 0.0;
    } else {
      return totalYear.first['totalMonth'] as double;
    }
  }

  @override
  Future<List<Money>> getTotalForCategory(int? startDate,int? endDate) async{
    var total = await db.rawQuery('''

  
  SELECT money.*, SUM(money.amount)AS "totalAmount" , category.name from money left join category on money.categoryId = category.id WHERE date BETWEEN $startDate AND $endDate GROUP BY categoryId;
    ''');
    var totalList = total.map((e) => Money.fromMap(e));
    return totalList.toList();

  }

  @override
  Future<int> editMoney(Money money) async{
    return await db.update('money',money.toMap(), where: 'id=?',whereArgs: [money.id]);
  }


}
