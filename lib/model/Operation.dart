class Operation {
  int? id;
  double TotalPrice;
  String date;

  Operation({this.id, required this.TotalPrice, required this.date});

  Map<String, dynamic> toMap() {
    return {'id': id, 'TotalPrice': TotalPrice, 'date': date};
  }

  factory Operation.fromMap(Map<String, dynamic> map) {
    return Operation(
        id: map['id'], TotalPrice: map['TotalPrice'], date: map['date']);
  }
}
