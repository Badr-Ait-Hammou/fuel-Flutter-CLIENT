class TransactionData {
  final int id;
  final String type;
  final double price;
  final double totale;
  final double litre;
  final DateTime date;

  TransactionData({
    required this.id,
    required this.type,
    required this.price,
    required this.totale,
    required this.litre,
    required this.date,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      id: json['id'],
      type: json['type'],
      price: json['price'],
      totale: json['totale'],
      litre: json['litre'],
      date: DateTime.parse(json['date']),
    );
  }
  @override
  String toString() {
    return 'TransactionData{id: $id, amount: $price, date: $date,total:$totale,litre:$litre}';
  }
}