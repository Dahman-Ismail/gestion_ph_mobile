class Fournisseur {
  int? id;
  String name;
  int telephone;
  String email;
  String pays;
  String ville;
  String adresse;
  String? createdAt;
  String? updatedAt;

  Fournisseur({
    this.id,
    required this.name,
    required this.telephone,
    required this.email,
    required this.pays,
    required this.ville,
    required this.adresse,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Name': name,
      'Telephone': telephone,
      'email': email,
      'Pays': pays,
      'Ville': ville,
      'Adresse': adresse,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Fournisseur.fromMap(Map<String, dynamic> map) {
    return Fournisseur(
      id: map['id'],
      name: map['Name'],
      telephone: map['Telephone'],
      email: map['email'],
      pays: map['Pays'],
      ville: map['Ville'],
      adresse: map['Adresse'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}