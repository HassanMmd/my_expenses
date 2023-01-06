class Reminder {
  int? id;
  String? description;
  DateTime date;

  Reminder(this.description, this.date, {this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'Date': date.millisecondsSinceEpoch,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      map['description'],
      DateTime.fromMillisecondsSinceEpoch(map['Date']),
      id: map['id'],
    );
  }
}
