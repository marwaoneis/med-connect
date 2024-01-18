class MedicationOrder {
  final String patientId;
  final String pharmacyId;
  final String medicineId;

  MedicationOrder({
    required this.patientId,
    required this.pharmacyId,
    required this.medicineId,
  });

  factory MedicationOrder.fromJson(Map<String, dynamic> json) {
    return MedicationOrder(
      patientId: json['patientId'],
      pharmacyId: json['pharmacyId'],
      medicineId: json['medicineId'],
    );
  }
}
