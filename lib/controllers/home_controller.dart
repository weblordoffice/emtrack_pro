import 'package:get/get.dart';
import '../models/home_model.dart';
import '../models/statical_model.dart';
import '../services/home_service.dart';
import '../utils/secure_storage.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var username = ''.obs;
  RxBool isCreateOpen = false.obs;

  var homeData = Rxn<HomeModel>();
  var homeCount = Rxn<DashboardModel>();

  // 🔹 GLOBAL CHANGE ACCOUNT DATA
  RxString selectedParentAccountName = ''.obs;
  RxString selectedLocationName = ''.obs;

  RxInt tyreCount = 0.obs;
  RxInt vehicleCount = 0.obs;

  // GETTERS
  String get role => homeData.value?.role ?? "";
  String get parentAccount => homeData.value?.parentAccount ?? "";
  String get location => homeData.value?.location ?? "";
  String get imageUrl => homeData.value?.imageUrl ?? "";

  int get totalTyres => homeData.value?.totalTyres ?? 0;
  int get vehicles => homeData.value?.vehicles ?? 0;
  int get unsynced => homeData.value?.unsyncedInspections ?? 0;
  int get synced => homeData.value?.syncedInspections ?? 0;

  String get lastInspection => homeData.value?.lastInspection ?? "—";
  String get appVersion => homeData.value?.appVersion ?? "1.0";

  @override
  void onInit() {
    super.onInit();
    loadUserName();
    loadSelectedAccountData();
    fetchHome();
    fetchReportDashboardDataHome();
<<<<<<< HEAD
    loadTyreCountByAccount();
    loadVehicleCountByAccount();
=======
    // Remove separate API calls - use dashboard data only
    // loadTyreCountByAccount();
    // loadVehicleCountByAccount();
>>>>>>> pratyush
  }

  // ---------------- LOAD USERNAME ----------------
  // Future<void> loadUserName() async {
  //   final name = await SecureStorage.getUserName();
  //   if (name != null && name.isNotEmpty) {
  //     username.value = name;
  //   }
  // }

  Future<void> loadUserName() async {
    final name = await SecureStorage.getUserProfileName();
    if (name != null && name.isNotEmpty) {
      username.value = name;
    }
  }

  // ---------------- FETCH HOME ----------------
  Future<void> fetchHome() async {
    isLoading.value = true;
    try {
      final response = await HomeService.fetchHomeData(); // ✅ cookie based
      homeData.value = response;
    } catch (e) {
      print("Home fetch error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchReportDashboardDataHome() async {
    isLoading.value = true;
<<<<<<< HEAD
    try {
      final response = await HomeService.fetchReportDashboardHomeData();
      homeCount.value = response;
=======
    print("🔍 HOME CONTROLLER: fetchReportDashboardDataHome called!");
    try {
      final response = await HomeService.fetchReportDashboardHomeData();
      homeCount.value = response;
      print(
        "🔍 HOME CONTROLLER: Dashboard data set - ${response?.totalTiresCount} tires, ${response?.vehicleCount} vehicles",
      );
>>>>>>> pratyush
    } catch (e) {
      print("Home fetch error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------- PULL TO REFRESH ----------------
  Future<void> refreshHome() async {
    await fetchHome();
    await fetchReportDashboardDataHome();
<<<<<<< HEAD
=======
    // Remove separate API calls - use dashboard data only
    // await loadTyreCountByAccount();
    // await loadVehicleCountByAccount();
>>>>>>> pratyush
  }

  // ---------------- SYNC ----------------
  Future<void> syncInspections() async {
    isLoading.value = true;
    try {
      final success = await HomeService.syncInspections(); // ✅ cookie based

      if (success) {
        await fetchHome();
        Get.snackbar(
          "Sync",
          "Sync completed successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Sync",
          "Sync failed!",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------- CREATE MENU ----------------
  void openCreateMenu() => isCreateOpen.value = true;
  void closeCreateMenu() => isCreateOpen.value = false;

  // ---------------- ACCOUNT / LOCATION ----------------
  Future<void> loadSelectedAccountData() async {
    final parentName = await SecureStorage.getParentAccountName();
    final locationName = await SecureStorage.getLocationName();

    if (parentName != null) {
      selectedParentAccountName.value = parentName;
    }
    if (locationName != null) {
      selectedLocationName.value = locationName;
    }
  }

  void updateSelectedAccount({
    required String parentAccountName,
    required String locationName,
  }) {
    selectedParentAccountName.value = parentAccountName;
    selectedLocationName.value = locationName;
  }

  // ---------------- TYRE COUNT ----------------
  Future<void> loadTyreCountByAccount() async {
    try {
      final parentAccountId = await SecureStorage.getParentAccountId();
<<<<<<< HEAD
=======
      print("🔍 HOME CONTROLLER - PARENT ACCOUNT ID: $parentAccountId");
>>>>>>> pratyush
      if (parentAccountId == null) return;

      tyreCount.value = await HomeService.fetchTyreCountByAccount(
        parentAccountId,
      );
<<<<<<< HEAD
=======
      print("🔍 HOME CONTROLLER - FINAL TYRE COUNT: ${tyreCount.value}");
>>>>>>> pratyush
    } catch (e) {
      print("Tyre count error $e");
    }
  }

  // ---------------- VEHICLE COUNT ----------------
  Future<void> loadVehicleCountByAccount() async {
    try {
      final parentAccountId = await SecureStorage.getParentAccountId();
<<<<<<< HEAD
=======
      print(
        "🔍 HOME CONTROLLER - PARENT ACCOUNT ID (VEHICLE): $parentAccountId",
      );
>>>>>>> pratyush
      if (parentAccountId == null) return;

      vehicleCount.value = await HomeService.fetchVehicleCountByAccount(
        parentAccountId,
      );
<<<<<<< HEAD
      print("Total vehicle ${vehicleCount.value}");
=======
      print("🔍 HOME CONTROLLER - FINAL VEHICLE COUNT: ${vehicleCount.value}");
>>>>>>> pratyush
    } catch (e) {
      print("Vehicle count error $e");
    }
  }
}
