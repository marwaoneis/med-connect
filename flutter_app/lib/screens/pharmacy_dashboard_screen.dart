import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class PharmacyDashboard extends StatefulWidget {
  const PharmacyDashboard({super.key});

  @override
  PharmacyDashboardState createState() => PharmacyDashboardState();
}

class PharmacyDashboardState extends State<PharmacyDashboard> {
  late Future<int> totalMedicines;
  late Future<int> medicineGroups;
  late Future<int> totalOrders;
  late Future<String> frequentlyBoughtItem;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pharmacyId = Provider.of<Auth>(context, listen: false).getUserId;
      if (pharmacyId != null) {
        setState(() {
          totalMedicines = _fetchTotalMedicines(pharmacyId);
          medicineGroups = _fetchMedicineGroups(pharmacyId);
          totalOrders = _fetchTotalOrders(pharmacyId);
          frequentlyBoughtItem = _fetchFrequentlyBoughtItem(pharmacyId);
        });
      }
    });
  }

  Future<int> _fetchTotalMedicines(String pharmacyId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final medicines =
        await apiService.fetchData('medicines/bypharmacy/$pharmacyId');
    return medicines.length;
  }

  Future<int> _fetchMedicineGroups(String pharmacyId) async {
    // This function should call an API endpoint that returns distinct groups of medicines
    // For now, it's not clear how your API handles this, so this is a placeholder
    return 0;
  }

  Future<int> _fetchTotalOrders(String pharmacyId) async {
    // This function should call an API endpoint that returns orders for the pharmacy
    // Placeholder for now as the orders endpoint is not provided
    return 0;
  }

  Future<String> _fetchFrequentlyBoughtItem(String pharmacyId) async {
    // This function should call an API endpoint that returns the most frequently bought item
    // Placeholder for now as the logic for determining this is not provided
    return 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Pharmacy Name'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Handle navigation to menu or other actions
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          // ... other widgets
          _buildDashboardCard('Total no of Medicines', totalMedicines),
          _buildDashboardCard('Medicine Groups', medicineGroups),
          _buildDashboardCard('Total no of Orders', totalOrders),
          _buildDashboardCard('Frequently Bought Item', frequentlyBoughtItem,
              isItemName: true),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(String title, Future<dynamic> futureData,
      {bool isItemName = false}) {
    return FutureBuilder<dynamic>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // If the future is complete and no errors occurred, display the data
          return ListTile(
            title: Text(title),
            subtitle: isItemName ? null : Text('Tap to see details'),
            trailing:
                Text(isItemName ? snapshot.data : snapshot.data.toString()),
            onTap: () {
              // Handle tap
            },
          );
        }
      },
    );
  }
}

class RequestConfig {
  static getHeaders(BuildContext context) {
    // Return the headers required for the API
    return {};
  }
}

class ApiService {
  final String baseUrl;
  final Map<String, String> headers;

  ApiService({required this.baseUrl, required this.headers});

  Future<dynamic> fetchData(String endpoint) async {
    // Implement your logic to fetch data from the backend
    // Placeholder for now
    return [];
  }
}
