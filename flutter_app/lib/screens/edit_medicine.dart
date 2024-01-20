import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

class EditMedicineScreen extends StatefulWidget {
  final Medicine medicine;
  final String pharmacyId;

  const EditMedicineScreen({
    super.key,
    required this.medicine,
    required this.pharmacyId,
  });

  @override
  EditMedicineScreenState createState() => EditMedicineScreenState();
}

class EditMedicineScreenState extends State<EditMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _idController;
  late TextEditingController _groupController;
  late TextEditingController _quantityController;
  late TextEditingController _usageController;
  late TextEditingController _sideEffectsController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.medicine.medicineDetails.first.name);
    _idController = TextEditingController(text: widget.medicine.id);
    _groupController = TextEditingController(
        text: widget.medicine.medicineDetails.first.group);
    _quantityController =
        TextEditingController(text: widget.medicine.stockLevel.toString());
    _usageController = TextEditingController(
        text: widget.medicine.medicineDetails.first.description);
    _sideEffectsController = TextEditingController(
        text: widget.medicine.medicineDetails.first.sideEffects);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _groupController.dispose();
    _quantityController.dispose();
    _usageController.dispose();
    _sideEffectsController.dispose();
    super.dispose();
  }

  void _saveMedicine() async {
    if (_formKey.currentState!.validate()) {
      print('Save medicine with the following details:');
      print('Name: ${_nameController.text}');
      print('ID: ${_idController.text}');
      print('Group: ${_groupController.text}');
      print('Quantity: ${_quantityController.text}');
      print('Usage: ${_usageController.text}');
      print('Side Effects: ${_sideEffectsController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Medicine Details'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Medicine Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter medicine name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: 'Medicine ID'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter medicine ID';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _saveMedicine,
                  child: const Text('Save Details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
