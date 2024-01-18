class MedicationOrder {
  final String patientId;
  final String pharmacyId;
  final String prescriptionId;

  MedicationOrder({
    required this.patientId,
    required this.pharmacyId,
    required this.prescriptionId,
  });

  factory MedicationOrder.fromJson(Map<String, dynamic> json) {
    return MedicationOrder(
      patientId: json['patientId'],
      pharmacyId: json['pharmacyId'],
      prescriptionId: json['prescriptionId'],
    );
  }
}
