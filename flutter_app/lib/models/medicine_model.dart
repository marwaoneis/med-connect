class Medicine {
  final String id;
  final String name;
  final String description;
  final String sideEffects;
  final String group;
  final String pharmacyName;
  final int stockLevel;
  final double price;

  Medicine({
    required this.id,
    required this.name,
    required this.description,
    required this.sideEffects,
    required this.group,
    required this.pharmacyName,
    required this.stockLevel,
    required this.price,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['_id'],
      name: json['medicineDetails']['name'],
      description: json['medicineDetails']['description'],
      sideEffects: json['medicineDetails']['sideEffects'],
      group: json['medicineDetails']['group'],
      pharmacyName: json['pharmacyName'],
      stockLevel: json['stockLevel'],
      price: json['price'].toDouble(),
    );
  }
}
