class Produit {
  int? id;
  int fournisseurId;
  String image;
  String name;
  int barCode;
  int quantite;
  double price;
  int discount;
  int categoryId;
  String description;
  String expirrationDate;
  int quantitePiece;

  Produit({
    this.id,
    required this.fournisseurId,
    required this.image,
    required this.name,
    required this.barCode,
    required this.quantite,
    required this.price,
    required this.discount,
    required this.categoryId,
    required this.description,
    required this.expirrationDate,
    required this.quantitePiece,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'FournisseurId': fournisseurId,
      'Image': image,
      'Name': name,
      'BarCode': barCode,
      'Quantite': quantite,
      'Price': price,
      'Discount': discount,
      'CategoryId': categoryId,
      'Description': description,
      'ExpirrationDate': expirrationDate,
       'QuantitePiece': quantitePiece,
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
      price: map['Price'],
      discount: map['Discount'],
      categoryId: map['CategoryId'],
      description: map['Description'],
      expirrationDate: map['ExpirrationDate'],
      quantitePiece: map['QuantitePiece'],
    );
  }
}