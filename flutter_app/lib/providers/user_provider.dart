import 'package:flutter/cupertino.dart';
import '../tools/request.dart';

class UserProvider with ChangeNotifier {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? password;
  String? phone;
  String? address;
  DateTime? dateOfBirth;
  String? gender;
  Map? additionalInfo;

  Future<void> getUser(String id, BuildContext context) async {
    try {
      final response =
          await sendRequest(route: "/patients/$id", context: context);

      if (response["message"] != null) {
        throw Exception(response["message"]);
      }

      firstName = response["firstName"];
      lastName = response["lastName"];
      username = response["username"];
      password = response["password"];
      email = response["email"];
      phone = response["phone"];
      address = response["address"];
      dateOfBirth = response["dateOfBirth"];
      gender = response["gender"];
      additionalInfo = response["additionalInfo"];

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
