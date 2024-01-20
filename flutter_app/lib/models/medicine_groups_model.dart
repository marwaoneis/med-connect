import 'medicine_model.dart';

class MedicineGroup {
  final String groupName;
  final List<Medicine> medicines;

  MedicineGroup({
    required this.groupName,
    required this.medicines,
  });

  int get numberOfMedicines => medicines.length;

  List<String> get medicineDetails => medicines
      .map((medicine) =>
          medicine.medicineDetails.map((detail) => detail.name).join(', '))
      .toList();

  factory MedicineGroup.fromMedicines(
      String groupName, List<Medicine> medicines) {
    return MedicineGroup(groupName: groupName, medicines: medicines);
  }
}
