class Category {
  int? id;
  String name;
  String description;

  Category({this.id, required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Name': name,
      'Description': description,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['Name'],
      description: map['Description'],
    );
  }
}