class Role {
  int? id;
  String role;
  String guardName;

  Role({
    this.id,
    required this.role,
    required this.guardName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Role': role,
      'guard_name': guardName,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'],
      role: map['Role'],
      guardName: map['guard_name'],
    );
  }
}