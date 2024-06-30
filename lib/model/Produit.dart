class Produit {
  int? id;
  int fournisseurId;
  String image;
  String name;
  int barCode;
  int quantite;
  double PrixAchat;
  double PrixVente ;
  int discount;
  int categoryId;
  int typeId;
  String description;
  String expirationDate;
  int quantitePiece; // New field

  Produit({
    this.id,
    required this.fournisseurId,
    required this.image,
    required this.name,
    required this.barCode,
    required this.quantite,
    required this.PrixAchat,
    required this.PrixVente,
    required this.discount,
    required this.categoryId,
    required this.typeId,
    required this.description,
    required this.expirationDate,
    required this.quantitePiece, // Initialize in constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'FournisseurId': fournisseurId,
      'Image': image,
      'Name': name,
      'BarCode': barCode,
      'Quantite': quantite,
      'PrixAchat': PrixAchat,
      'PrixVente' : PrixVente ,
      'Discount': discount,
      'CategoryId': categoryId,
      'TypeId': typeId,
      'Description': description,
      'ExpirationDate': expirationDate,
      'QuantitePiece': quantitePiece, // Include quantitePiece in toMap()
    };
  }

  factory Produit.fromMap(Map<String, dynamic> map) {
    return Produit(
      id: map['id'],
      fournisseurId: map['FournisseurId'],
      image: map['Image'],
      name: map['Name'],
      barCode: map['BarCode'],
      quantite: map['Quantite'],
      PrixAchat: map['PrixAchat'],
      PrixVente: map['PrixVente'],
      discount: map['Discount'],
      categoryId: map['CategoryId'],
      typeId: map['TypeId'],
      description: map['Description'],
      expirationDate: map['ExpirationDate'],
      quantitePiece: map['QuantitePiece'], // Initialize quantitePiece in fromMap()
    );
  }
}
