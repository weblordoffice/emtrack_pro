import 'package:emtrack/user_management/user_management_model.dart';

class UserManagementListService {
  /// GET USERS
  Future<List<UserManagementModel>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      UserManagementModel(
        username: "ppppp",
        password: "kjshfkldsf",
        role: "kjshfkldsf",
        firstName: "kjshfkldsf",
        middleName: "kjshfkldsf",
        lastName: "kjshfkldsf",
        email: "kjshfkldsf",
        phone: "kjshfkldsf",
        country: "kjshfkldsf",
        language: "kjshfkldsf",
        measurement: "kjshfkldsf",
        pressureUnit: "kjshfkldsf",
      ),

      UserManagementModel(
        username: "jhhjfklsjskl",
        password: "kjshfkldsf",
        role: "kjshfkldsf",
        firstName: "kjshfkldsf",
        middleName: "kjshfkldsf",
        lastName: "kjshfkldsf",
        email: "kjshfkldsf",
        phone: "kjshfkldsf",
        country: "kjshfkldsf",
        language: "kjshfkldsf",
        measurement: "kjshfkldsf",
        pressureUnit: "kjshfkldsf",
      ),
    ];
  }

  /// DELETE USER
  Future<void> deleteUser(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
