class Type {
  int? id; // Nullable integer for id
  String name; // Required, non-nullable
  String description; // Required, non-nullable

  Type({
    this.id,
    required this.name,
    required this.description,
  });

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      id: map['id'], // Assuming id is correctly provided as int in the map
      name: map['name'] ?? '', // Handle null with default value
      description: map['description'] ?? '', // Handle null with default v
      // name: map['name'] as String, // Required field
      // description: map['description'] as String, // Required field
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}