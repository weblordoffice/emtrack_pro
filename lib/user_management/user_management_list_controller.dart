import 'package:emtrack/user_management/user_management_list_service.dart';
import 'package:emtrack/user_management/user_management_model.dart';
import 'package:get/get.dart';

class UserManagementListController extends GetxController {
  final _service = UserManagementListService();

  RxList<UserManagementModel> users = <UserManagementModel>[].obs;
  RxList<UserManagementModel> filteredUsers = <UserManagementModel>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    loading.value = true;
    final data = await _service.getUsers();
    users.assignAll(data);
    filteredUsers.assignAll(data);
    loading.value = false;
  }

  void search(String value) {
    if (value.isEmpty) {
      filteredUsers.assignAll(users);
    } else {
      filteredUsers.assignAll(
        users.where(
          (u) => u.username.toLowerCase().contains(value.toLowerCase()),
        ),
      );
    }
  }

  void deleteUser(UserManagementModel user) async {
    await _service.deleteUser(user.username);
    users.remove(user);
    filteredUsers.remove(user);
  }
}
