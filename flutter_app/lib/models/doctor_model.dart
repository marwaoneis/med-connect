class Doctor {
  String username;
  String firstName;
  String lastName;
  String email;
  String address;
  String phone;
  String gender;
  String specialization;
  int yearsOfExperience;
  double appointmentPrice;
  Timing timing;
  String role;

  Doctor({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.phone,
    required this.gender,
    required this.specialization,
    required this.yearsOfExperience,
    required this.appointmentPrice,
    required this.timing,
    this.role = "Doctor", // Default value set as "Doctor"
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      gender: json['gender'],
      specialization: json['specialization'],
      yearsOfExperience: json['yearsOfExperience']?.toInt() ?? 0,
      appointmentPrice: (json['appointmentPrice'] as num).toDouble(),
      timing: Timing.fromJson(json['timing']),
      role: json['role'] ?? "Doctor",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      // Do not include the password in the toJson for security reasons.
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'phone': phone,
      'gender': gender,
      'specialization': specialization,
      'yearsOfExperience': yearsOfExperience,
      'appointmentPrice': appointmentPrice,
      'timing': timing.toJson(),
      'role': role,
    };
  }
}

class Timing {
  String startTime;
  String endTime;
  String daysOfOperation;

  Timing({
    required this.startTime,
    required this.endTime,
    required this.daysOfOperation,
  });

  factory Timing.fromJson(Map<String, dynamic> json) {
    return Timing(
      startTime: json['startTime'],
      endTime: json['endTime'],
      daysOfOperation: json['daysOfOperation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'daysOfOperation': daysOfOperation,
    };
  }
}
