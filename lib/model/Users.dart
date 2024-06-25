class User {
  int? id;
  String name;
  String email;
  String? emailVerifiedAt;
  String password;
  int roleId;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.password,
    required this.roleId,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'password': password,
      'roleId': roleId,
      'remember_token': rememberToken,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']!= null ? map['id'] as int : null,
      name: map['name'],
      email: map['email'],
      emailVerifiedAt: map['email_verified_at'],
      password: map['password'],
      roleId: map['roleId'] != null ? map['roleId'] as int : 0,
      rememberToken: map['remember_token'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}
