import 'package:my_expenses/model/money.dart';

abstract class MoneyRepository {

  Future<int> addMoney(Money money);
  Future<List<Money>> getMoney();
  Future<int> deleteMoney(int id);
  Future<List<Money>> getMoneyByDate(int? startDate,int? endDate);
  Future<List<Money>> getSumValues();
  Future<double> getTotalForWeek(int startDate,int endDate);
  Future<double> getTotalForMonth(int startDate,int endDate);
  Future<double> getTotalForYear(int startDate,int endDate);
  Future<List<Money>> getTotalForCategory(int? startDate,int? endDate);
  Future<int> editMoney(Money money);
}