class User {
  int? id;
  String name;
  String email;
  String? emailVerifiedAt;
  String password;
  int roleId;
  String? rememberToken;

  User({
    this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.password,
    required this.roleId,
    this.rememberToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'password': password,
      'RoleId': roleId,
      'remember_token': rememberToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      emailVerifiedAt: map['email_verified_at'],
      password: map['password'],
      roleId: map['RoleId'],
      rememberToken: map['remember_token'],
    );
  }
}