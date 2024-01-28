import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/no_glow_scroll.dart';

import '../tools/request.dart';

class AddMedicineScreen extends StatefulWidget {
  final String pharmacyId;

  const AddMedicineScreen({super.key, required this.pharmacyId});

  @override
  AddMedicineScreenState createState() => AddMedicineScreenState();
}

class AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController howToUseController = TextEditingController();
  TextEditingController sideEffectsController = TextEditingController();
  String? selectedGroup;
  TextEditingController priceController = TextEditingController();

  List<String> groups = [
    'Analgesics',
    'Antibiotics',
    'Antidepressants',
    'Antihistamines',
    'Antipsychotics',
    'Antivirals',
    'Bronchodilators',
    'Diuretics',
    'Hormones',
    'Statins',
    'Anticoagulants',
    'Immunosuppressants',
    'Calcium Channel Blockers'
  ];

  void _saveMedicine() async {
    if (_formKey.currentState!.validate()) {
      var medicineData = {
        'name': nameController.text,
        'description': howToUseController.text,
        'sideEffects': sideEffectsController.text,
        'group': selectedGroup,
        'stockLevel': int.tryParse(quantityController.text) ?? 0,
        'price':
            double.tryParse(priceController.text) ?? 0.0, // parsing to double
      };

      final String route = '/medicines/bypharmacy/${widget.pharmacyId}';

      try {
        final response = await sendRequest(
          route: route,
          method: "POST",
          load: medicineData,
          context: context,
        );

        if (response != null && response['error'] == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Medicine added successfully')),
          );
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to add medicine: ${response['error']}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NoGlowScrollWrapper(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildInputField(
                  label: 'Medicine Name',
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        hintText: 'Enter Medicine Name',
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter medicine name';
                      }
                      return null;
                    },
                  ),
                ),
                _buildInputField(
                  label: 'Medicine Group',
                  child: DropdownButtonFormField(
                    value: selectedGroup,
                    items: groups.map((String group) {
                      return DropdownMenuItem(
                        value: group,
                        child: Text(group),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGroup = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                        hintText: '-- Select Group --',
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500)),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a group';
                      }
                      return null;
                    },
                  ),
                ),
                _buildInputField(
                  label: 'Quantity in Number',
                  child: TextFormField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                        hintText: 'Enter medicine quantity',
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500)),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter quantity';
                      }
                      return null;
                    },
                  ),
                ),
                _buildInputField(
                  label: 'How to Use',
                  child: TextFormField(
                    controller: howToUseController,
                    decoration: const InputDecoration(
                        hintText: 'Enter how to use the medicine',
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500)),
                    maxLines: 3,
                  ),
                ),
                _buildInputField(
                  label: 'Side Effects',
                  child: TextFormField(
                    controller: sideEffectsController,
                    decoration: const InputDecoration(
                        hintText: 'Enter side effects',
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500)),
                    maxLines: 3,
                  ),
                ),
                _buildInputField(
                  label: 'Price',
                  child: TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      hintText: 'Enter price',
                      border: InputBorder.none,
                      // Remove labelStyle if you don't need label inside the field
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the price';
                      }
                      // Add more validation logic if required
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 180,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _saveMedicine,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE93B81),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        'Save Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            child: child,
          ),
        ),
      ],
    );
  }
}
