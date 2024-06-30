class Operation {
  int? id;
  double TotalPrice;

  Operation({
    this.id,
    required this.TotalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'TotalPrice': TotalPrice,
    };
  }

  factory Operation.fromMap(Map<String, dynamic> map) {
    return Operation(
      id: map['id'],
      TotalPrice: map['TotalPrice'],
    );
  }
}