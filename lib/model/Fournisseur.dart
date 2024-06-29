class Fournisseur {
  int? id;
  String name;
  String telephone;
  String email;
  String? pays;
  String? ville;
  String? adresse;

  Fournisseur({
    this.id,
    required this.name,
    required this.telephone,
    required this.email,
    this.pays,
    this.ville,
    this.adresse,
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
    };
  }

  factory Fournisseur.fromMap(Map<String, dynamic> map) {
    return Fournisseur(
      id: map['id'],
      name: map['Name'] ?? '',
      telephone: map['Telephone'] ?? '',
      email: map['email'] ?? '',
      pays: map['Pays'],
      ville: map['Ville'],
      adresse: map['Adresse'],
    );
  }
}
