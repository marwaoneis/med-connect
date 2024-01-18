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
                        padding: const EdgeInsets.only(top: 15.0),
                        children: <Widget>[
                          // Inventory Card
                          _buildInfoCard(
                            title: 'Inventory',
                            buttonLabel: 'Go to Configuration',
                            futureCount1: totalMedicines,
                            label1: 'Total no of Medicines',
                            futureCount2: medicineGroups,
                            label2: 'Medicine Groups',
                            onTapButton: () {
                              // TODO: Handle navigation
                            },
                          ),

                          // Orders Card
                          _buildInfoCard(
                            title: 'Orders',
                            buttonLabel: 'View Orders',
                            futureCount1: totalOrders,
                            label1: 'Total no of Orders',
                            futureCount2: frequentlyBoughtItem,
                            label2: 'Frequently Bought Item',
                            isItemName: true,
                            onTapButton: () {
                              // TODO: Handle navigation
                            },
                          ),
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

  Widget _buildInfoCard({
    required String title,
    required String buttonLabel,
    required Future<dynamic> futureCount1,
    required String label1,
    required Future<dynamic> futureCount2,
    required String label2,
    bool isItemName = false,
    VoidCallback? onTapButton,
  }) {
    return Padding(
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
            side: const BorderSide(color: Colors.grey, width: 1),
          ),
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    TextButton(
                      onPressed: onTapButton,
                      child: Text(
                        buttonLabel,
                        style: const TextStyle(
                            fontSize: 15, color: Color(0xFF0D4C92)),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _buildStatisticCounter(futureCount1, label1)),
                      const VerticalDivider(),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: _buildStatisticCounter(futureCount2, label2,
                              isItemName: isItemName)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticCounter(Future<dynamic> futureData, String label,
      {bool isItemName = false}) {
    return FutureBuilder<dynamic>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String dataText =
              isItemName ? snapshot.data ?? 'N/A' : snapshot.data.toString();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dataText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 5,
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
