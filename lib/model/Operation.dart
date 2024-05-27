class Operation {
  int? id;
  int userId;
  int produitId;
  String nom;
  double totalPrice;

  Operation({
    this.id,
    required this.userId,
    required this.produitId,
    required this.nom,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'UserId': userId,
      'ProduitId': produitId,
      'Nom': nom,
      'TotalPrice': totalPrice,
    };
  }

  factory Operation.fromMap(Map<String, dynamic> map) {
    return Operation(
      id: map['id'],
      userId: map['UserId'],
      produitId: map['ProduitId'],
      nom: map['Nom'],
      totalPrice: map['TotalPrice'],
    );
  }
}