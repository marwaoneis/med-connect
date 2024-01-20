import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/no_glow_scroll.dart';

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

  List<String> groups = ['Group 1', 'Group 2', 'Group 3'];

  void _saveMedicine() {
    if (_formKey.currentState!.validate()) {
      print('Name: ${nameController.text}');
      print('ID: ${idController.text}');
      print('Group: $selectedGroup');
      print('Quantity: ${quantityController.text}');
      print('How to Use: ${howToUseController.text}');
      print('Side Effects: ${sideEffectsController.text}');
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
                  label: 'Medicine ID',
                  child: TextFormField(
                    controller: idController,
                    decoration: const InputDecoration(
                        hintText: 'Enter medicine ID',
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter medicine ID';
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
                const SizedBox(height: 20),
                SizedBox(
                  width: 200, // Set the button's width
                  height: 40, // Set the button's height
                  child: ElevatedButton(
                    onPressed: _saveMedicine,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE93B81), // Button color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // The border radius of the button
                      ),
                      padding:
                          EdgeInsets.zero, // Reset default padding if necessary
                    ),
                    child: const Text(
                      'Save Details',
                      style: TextStyle(
                          fontSize: 18), // Adjust font size if necessary
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
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey[400]!), // Set the border color here
            borderRadius:
                BorderRadius.circular(10), // Set the border radius here
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: child,
          ),
        ),
      ],
    );
  }
}
