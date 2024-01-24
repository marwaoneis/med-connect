import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../api/api_service.dart';
import '../config/request_config.dart';
import '../models/pharmacy_model.dart';

class FindPharmacyWidget extends StatefulWidget {
  const FindPharmacyWidget({super.key});

  @override
  FindPharmacyWidgetState createState() => FindPharmacyWidgetState();
}

class FindPharmacyWidgetState extends State<FindPharmacyWidget> {
  Pharmacy? nearestPharmacy;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _findNearestPharmacy();
  }

  Future<void> _findNearestPharmacy() async {
    try {
      Position position = await _determinePosition();
      nearestPharmacy = await fetchNearestPharmacy(position);
    } catch (e) {
      errorMessage = e.toString();
      print(e);
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<Pharmacy> fetchNearestPharmacy(Position position) async {
    var headers = RequestConfig.getHeaders(context);
    final apiService =
        ApiService(baseUrl: 'http://10.0.2.2:3001', headers: headers);
    final response = await apiService.fetchData(
        'pharmacies/nearest?lat=${position.latitude}&lng=${position.longitude}');
    if (response['_id'] != null && response['username'] != null) {
      return Pharmacy.fromJson(response);
    } else {
      throw Exception('Failed to load data from the server');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text('Error: $errorMessage'));
    }

    if (nearestPharmacy == null) {
      return const Center(child: Text("No nearest pharmacy found."));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Find Pharmacies Near me",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Handle "View all" tap
                },
                child: const Text(
                  'View all >',
                  style: TextStyle(
                      color: Color(0xFF0D4C92),
                      fontSize: 14,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10), // Rounded border radius for the image
                    child: Image.asset(
                      'assets/pharmacy_default.png',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${nearestPharmacy!.username} Pharmacy",
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            // Handle navigation to maps
                          },
                          child: const Text(
                            'View in maps',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
