import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
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
  late Future<Map<String, dynamic>> pharmacyData;

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
    return FutureBuilder<Map<String, dynamic>>(
      future: pharmacyData,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final String firstName = snapshot.data?['firstName'] ?? 'N/A';

            return Scaffold(
              body: Column(
                children: <Widget>[
                  TopBarWithBackground(
                    leadingContent: CircleAvatar(
                      child: Text(
                        firstName[0],
                        style: const TextStyle(color: Color(0xFF0D4C92)),
                      ),
                    ),
                    titleContent: Text(
                      'Welcome $firstName',
                      style: const TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                      child: SingleChildScrollView(
                        child: ListView(
                          children: <Widget>[
                            _buildDashboardCard(
                                'Total no of Medicines', totalMedicines),
                            _buildDashboardCard(
                                'Medicine Groups', medicineGroups),
                            _buildDashboardCard(
                                'Total no of Orders', totalOrders),
                            _buildDashboardCard(
                                'Frequently Bought Item', frequentlyBoughtItem,
                                isItemName: true),
                          ],
                        ),
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
            subtitle: isItemName ? null : Text('Tap to see details'),
            trailing:
                Text(isItemName ? snapshot.data : snapshot.data.toString()),
            onTap: () {},
          );
        }
      },
    );
  }
}
