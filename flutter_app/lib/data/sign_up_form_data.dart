class SignUpFormData {
  String firstName = '';
  String lastName = '';
  String username = '';
  String email = '';
  String password = '';
  String phone = '';
  String address = '';
  DateTime? dateOfBirth;
  String gender = '';
  Map? additionalInfo;

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': email,
        'password': password,
        'phone': phone,
        'address': address,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'gender': gender,
        'additionalInfo': additionalInfo,
      };
}
