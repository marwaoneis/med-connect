class Pharmacy {
  final String username;
  final String address;
  final String phone;

  Pharmacy(
      {required this.username, required this.address, required this.phone});

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      username: json['username'],
      address: json['address'],
      phone: json['phone'],
    );
  }
}
