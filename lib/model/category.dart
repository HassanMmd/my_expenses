class Category {
  int? id;
  String text;

  Category(this.text, {this.id});

  @override
  bool operator ==(Object other) {
    return (other is Category && other.id == id);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': text,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(map['name'], id: map['id']);
  }
}
