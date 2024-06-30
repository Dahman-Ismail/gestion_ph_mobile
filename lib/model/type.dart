// model/Type.dart

class Type {
  int? id;
  String name;
  String description;

  Type({
    this.id,
    required this.name,
    this.description = '', // Default empty description
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Name': name,
      'Description': description,
    };
  }

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      id: map['id'],
      name: map['Name'],
      description: map['Description'] ?? '', // Handle null description
    );
  }
}
