import 'package:flutter/cupertino.dart';
import 'package:my_expenses/model/money.dart';
import 'package:my_expenses/repository/moneyRepositoryImpl.dart';

class MoneyViewModel extends ChangeNotifier {
  MoneyRepositoryImpl moneyRepositoryImpl = MoneyRepositoryImpl();

  DateTime weekEndDate = DateTime.now();
  DateTime weekStartDate = DateTime(
      DateTime.now().year, DateTime.now().month, (DateTime.now().day - 7));

  DateTime monthEndDate = DateTime.now();
  DateTime monthStartDate = DateTime(
      DateTime.now().year, (DateTime.now().month - 1), (DateTime.now().day));

  DateTime yearEndDate = DateTime.now();
  DateTime yearStartDate = DateTime(
      (DateTime.now().year - 1), DateTime.now().month, (DateTime.now().day));

  Future addItem(Money money) async {
    await moneyRepositoryImpl.addMoney(money);
    getItems();
    notifyListeners();
  }

  Future<List<Money>> getItems() {
    return moneyRepositoryImpl.getMoney();
  }

  void deleteItem(int id) {
    moneyRepositoryImpl.deleteMoney(id);
    notifyListeners();
  }

  Future<List<Money>> getMoneyByDate(int? startDate, int? endDate) {
    return moneyRepositoryImpl.getMoneyByDate(startDate, endDate);
  }

  Future<List<Money>> getSumValues() {
    return moneyRepositoryImpl.getSumValues();
  }

  Future<double> getTotalWeek() {
    int intWeekEndDate = weekEndDate.millisecondsSinceEpoch;
    int intWeekStartDate = weekStartDate.millisecondsSinceEpoch;
    return moneyRepositoryImpl.getTotalForWeek(
        intWeekStartDate, intWeekEndDate);
  }

  Future<double> getTotalMonth() {
    int intWeekEndDate = monthEndDate.millisecondsSinceEpoch;
    int intWeekStartDate = monthStartDate.millisecondsSinceEpoch;
    return moneyRepositoryImpl.getTotalForMonth(
        intWeekStartDate, intWeekEndDate);
  }

  Future<double> getTotalYear() {
    int intWeekEndDate = yearEndDate.millisecondsSinceEpoch;
    int intWeekStartDate = yearStartDate.millisecondsSinceEpoch;
    return moneyRepositoryImpl.getTotalForYear(
        intWeekStartDate, intWeekEndDate);
  }

  Future<List<Money>> getTotalForCategory(int? startDate, int? endDate) {
    return moneyRepositoryImpl.getTotalForCategory(startDate, endDate);
  }

  Future editMoney(Money money){
    return moneyRepositoryImpl.editMoney(money);
  }
}
