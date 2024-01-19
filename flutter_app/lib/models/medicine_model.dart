class MedicineDetails {
  final String name;
  final String description;
  final String sideEffects;
  final String group;

  MedicineDetails(
      {required this.name,
      required this.description,
      required this.sideEffects,
      required this.group});

  factory MedicineDetails.fromJson(Map<String, dynamic> json) {
    return MedicineDetails(
      name: json['name'],
      description: json['description'],
      sideEffects: json['sideEffects'],
      group: json['group'],
    );
  }
}

class Medicine {
  final String id;
  final String pharmacyId;
  final List<MedicineDetails> medicineDetails;
  final int stockLevel;
  final double price;

  Medicine({
    required this.id,
    required this.pharmacyId,
    required this.medicineDetails,
    required this.stockLevel,
    required this.price,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['_id'], // This is where you get the ID from the JSON object
      pharmacyId: json['pharmacyId'],
      medicineDetails: List<MedicineDetails>.from(
          json['medicineDetails'].map((x) => MedicineDetails.fromJson(x))),
      stockLevel: json['stockLevel'],
      price: json['price'].toDouble(),
    );
  }
}
