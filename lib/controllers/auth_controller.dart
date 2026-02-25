import 'package:emtrack/models/user_models.dart';
import 'package:get/get.dart';
import 'package:emtrack/routes/app_pages.dart';
import '../services/auth_service.dart';
import '../utils/secure_storage.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final showPassword = false.obs;
  final user = Rxn<UserModel>();
  final errorMessage = ''.obs;

  Future<UserModel?> login(String username, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final UserModel? user = await AuthService.login(username, password);

      if (user == null) {
        errorMessage.value = "Invalid username or password";
        return null;
      }
      await SecureStorage.saveUserName(username);
      await SecureStorage.saveToken("logged_in");
      Get.offAllNamed(AppPages.HOME);
      return user;
    } catch (e) {
      errorMessage.value = "Something went wrong";
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await SecureStorage.clearToken();
    user.value = null;
    Get.offAllNamed(AppPages.LOGIN);
  }
}
