class Money {
  int? id;
  double amount;
  String text;
  DateTime date;
  int? categoryId;
  String? categoryName;
  double? totalAmount;
  double? totalWeek;
  double? totalMonth;
  double? totalYear;

  Money(
    this.amount,
    this.text,
    this.date,
    this.categoryId, {
    this.totalAmount,
    this.totalWeek,
    this.totalMonth,
    this.totalYear,
    this.categoryName,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'text': text,
      'date': date.millisecondsSinceEpoch,
      'categoryId': categoryId,
    };
  }

  factory Money.fromMap(Map<String, dynamic> map) {
    return Money(
      map['amount'],
      map['text'],
      DateTime.fromMillisecondsSinceEpoch(map['date']),
      map['categoryId'],
      id: map['id'],
      categoryName: map['name'],
      totalAmount: map['totalAmount'],
      totalWeek: map['totalWeek'],
      totalMonth: map['totalMonth'],
      totalYear: map['totalYear'],
    );
  }
}
