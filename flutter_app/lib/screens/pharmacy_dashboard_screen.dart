import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../models/medication_order_model.dart';
import '../models/medicine_model.dart';
import '../providers/auth_provider.dart';
import '../widgets/footer.dart';
import '../widgets/no_glow_scroll.dart';
import '../widgets/top_bar_with_background.dart';

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
  Future<Map<String, dynamic>> pharmacyData = Future.value({});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pharmacyId = Provider.of<Auth>(context, listen: false).getUserId;
      if (pharmacyId != null) {
        setState(() {
          pharmacyData = _fetchPharmacyData(pharmacyId);
          totalMedicines = _fetchTotalMedicines(pharmacyId);
          medicineGroups = _fetchMedicineGroups(pharmacyId);
          totalOrders = _fetchTotalOrders(pharmacyId);
          frequentlyBoughtItem = _fetchFrequentlyBoughtItem(pharmacyId);
        });
      }
    });
  }

  Future<Map<String, dynamic>> _fetchPharmacyData(String pharmacyId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final data = await apiService.fetchData('pharmacies/$pharmacyId');
    print('Fetched pharmacy data: $data');
    return data;
  }

  Future<int> _fetchTotalMedicines(String pharmacyId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final response =
        await apiService.fetchData('medicines/bypharmacy/$pharmacyId');
    List<Medicine> medicines = List<Medicine>.from(
      response.map((x) => Medicine.fromJson(x)),
    );
    return medicines.length;
  }

  Future<int> _fetchMedicineGroups(String pharmacyId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final response =
        await apiService.fetchData('medicines/bypharmacy/$pharmacyId');

    if (response is! List) {
      throw 'Expected list of medicines, got: $response';
    }

    final allMedicineDetails = response
        .expand((medicine) => (medicine['medicineDetails'] as List))
        .toList();

    final uniqueGroups =
        allMedicineDetails.map((detail) => detail['group']).toSet();

    return uniqueGroups.length;
  }

  Future<int> _fetchTotalOrders(String pharmacyId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final response =
        await apiService.fetchData('medication-orders/pharmacy/$pharmacyId');

    List<MedicationOrder> orders = List<MedicationOrder>.from(
      response.map((x) => MedicationOrder.fromJson(x)),
    );
    print("orders: $response");
    return orders.length;
  }

  Future<String> _fetchFrequentlyBoughtItem(String pharmacyId) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);

    try {
      final response = await apiService
          .fetchData('medication-orders/frequentItem/$pharmacyId');

      if (response != null && response['name'] != null) {
        print("Frequently Bought Item: ${response['name']}");
        return response['name'];
      } else {
        // Handle null or missing 'name' key
        print("No frequently bought item found or name is null");
        return 'N/A';
      }
    } catch (e) {
      print('Caught an exception: $e');
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: pharmacyData,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final String username = snapshot.data?['username'] ?? 'N/A';

            return Scaffold(
              body: Column(
                children: <Widget>[
                  TopBarWithBackground(
                    leadingContent: CircleAvatar(
                      child: Text(
                        username[0].toUpperCase(),
                        style: const TextStyle(color: Color(0xFF0D4C92)),
                      ),
                    ),
                    titleContent: Text(
                      'Welcome $username',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    trailingContent: IconButton(
                      icon: SvgPicture.asset(
                        'assets/notification_icon.svg',
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: NoGlowScrollWrapper(
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: -4,
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                      color: Colors.grey, width: 1),
                                ),
                                margin: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'Inventory',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // TODO: Navigate to configuration
                                            },
                                            child: const Text(
                                              'Go to Configuration',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: _buildStatisticCounter(
                                                    totalMedicines,
                                                    'Total no of Medicines')),
                                            const VerticalDivider(),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: _buildStatisticCounter(
                                                    medicineGroups,
                                                    'Medicine Groups')),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _buildDashboardCard(
                              'Total no of Orders', totalOrders),
                          _buildDashboardCard(
                              'Frequently Bought Item', frequentlyBoughtItem,
                              isItemName: true),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Footer(
                onHomeTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PharmacyDashboard()),
                  );
                },
                onAppointmentTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PharmacyDashboard()),
                  );
                },
                onChatTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PharmacyDashboard()),
                  );
                },
                onProfileTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PharmacyDashboard()),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildDashboardCard(String title, Future<dynamic> futureData,
      {bool isItemName = false}) {
    return FutureBuilder<dynamic>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return ListTile(
            title: Text(title),
            subtitle: isItemName ? null : const Text('Tap to see details'),
            trailing:
                Text(isItemName ? snapshot.data : snapshot.data.toString()),
            onTap: () {},
          );
        }
      },
    );
  }

  Widget _buildStatisticCounter(Future<int> counter, String label) {
    return FutureBuilder<int>(
      future: counter,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0), // Add vertical padding
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${snapshot.data ?? 'N/A'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 22.0,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
