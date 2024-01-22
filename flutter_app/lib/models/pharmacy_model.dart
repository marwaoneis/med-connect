class Pharmacy {
  final String username;
  final String address;
  final String phone;
  final List<double>?
      location; // Representing location as [longitude, latitude]

  Pharmacy({
    required this.username,
    required this.address,
    required this.phone,
    this.location,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      username: json['username'],
      address: json['address'],
      phone: json['phone'],
      location: json['location'] != null
          ? [
              json['location']['coordinates'][0],
              json['location']['coordinates'][1]
            ]
          : null,
    );
  }
}
