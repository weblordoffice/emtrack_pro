import 'package:emtrack/user_management/user_management_model.dart';

class UserManagementService {
  Future<void> registerUser(UserManagementModel model) async {
    // 🔥 Future API call
    print("📤 SENDING DATA TO API");
    print(model.toJson());

    await Future.delayed(const Duration(seconds: 1));

    print("✅ USER REGISTERED");
  }
}
