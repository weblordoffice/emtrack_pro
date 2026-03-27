import 'package:emtrack/controllers/all_vehicles_controller.dart';
import 'package:emtrack/controllers/home_controller.dart';
import 'package:emtrack/controllers/selected_account_controller.dart';
import 'package:emtrack/controllers/all_tyre_controller.dart';
<<<<<<< HEAD
import 'package:emtrack/utils/secure_storage.dart';
import 'package:flutter/material.dart';
=======
import 'package:emtrack/routes/app_pages.dart';
import 'package:emtrack/utils/secure_storage.dart';
>>>>>>> pratyush
import 'package:get/get.dart';
import '../models/change_account_model.dart';
import '../services/change_account_service.dart';

class ChangeAccountController extends GetxController {
  final service = ChangeAccountService();

  RxBool ownSelected = false.obs;
  RxBool sharedSelected = false.obs;

  RxBool isLoading = false.obs;
<<<<<<< HEAD
  RxnString accountType = RxnString();
=======
  RxnString accountType = RxnString(); // own / shared / null
>>>>>>> pratyush

  RxList<ParentAccountModel> accounts = <ParentAccountModel>[].obs;
  RxList<LocationModel> locations = <LocationModel>[].obs;

  Rx<ParentAccountModel?> selectedAccount = Rx<ParentAccountModel?>(null);
  Rx<LocationModel?> selectedLocation = Rx<LocationModel?>(null);

  @override
  void onInit() {
    super.onInit();
    _init();
  }

<<<<<<< HEAD
  Future<void> _init() async {
    await _restoreRadio();
    await loadParentAccounts();
    await _restoreParentAndLocation();
  }

  Future<void> _restoreRadio() async {
    final own = await SecureStorage.getBool('own_selected');
    final shared = await SecureStorage.getBool('shared_selected');
    ownSelected.value = own ?? false;
    sharedSelected.value = shared ?? false;
=======
  /* ---------------- INIT ---------------- */
  Future<void> _init() async {
    await _restoreRadio(); // ✅ radio first
    await loadParentAccounts(); // ✅ load accounts
    await _restoreParentAndLocation(); // ✅ restore after data ready
  }

  /* ---------------- RADIO RESTORE ---------------- */
  Future<void> _restoreRadio() async {
    final own = await SecureStorage.getBool('own_selected');
    final shared = await SecureStorage.getBool('shared_selected');

    ownSelected.value = own ?? false; // 🟢 first install → false
    sharedSelected.value = shared ?? false; // 🟢 first install → false
>>>>>>> pratyush

    final savedType = await SecureStorage.getAccountType();
    if (savedType == 'own' || savedType == 'shared') {
      accountType.value = savedType;
    } else {
<<<<<<< HEAD
      accountType.value = null;
    }
  }

=======
      accountType.value = null; // 🟢 first install
    }
  }

  /* ---------------- LOAD PARENT ACCOUNTS ---------------- */
>>>>>>> pratyush
  Future<void> loadParentAccounts() async {
    try {
      isLoading.value = true;
      accounts.value = await service.fetchParentAccounts();
    } finally {
      isLoading.value = false;
    }
  }

<<<<<<< HEAD
  Future<void> _restoreParentAndLocation() async {
    final savedParentId = await SecureStorage.getParentAccountId();
    if (savedParentId != null && accounts.isNotEmpty) {
      final parent = accounts.firstWhereOrNull(
            (e) => e.parentAccountId.toString() == savedParentId,
      );
=======
  /* ---------------- RESTORE PARENT + LOCATION ---------------- */
  Future<void> _restoreParentAndLocation() async {
    // 🔽 Parent restore
    final savedParentId = await SecureStorage.getParentAccountId();
    if (savedParentId != null && accounts.isNotEmpty) {
      final parent = accounts.firstWhereOrNull(
        (e) => e.parentAccountId.toString() == savedParentId,
      );

>>>>>>> pratyush
      if (parent != null) {
        selectedAccount.value = parent;
        await loadLocations(parent.parentAccountId);
      }
    }

<<<<<<< HEAD
    final savedLocationId = await SecureStorage.getLocationId();
    if (savedLocationId != null && locations.isNotEmpty) {
      selectedLocation.value = locations.firstWhereOrNull(
            (e) => e.locationId.toString() == savedLocationId,
=======
    // 📍 Location restore
    final savedLocationId = await SecureStorage.getLocationId();
    if (savedLocationId != null && locations.isNotEmpty) {
      selectedLocation.value = locations.firstWhereOrNull(
        (e) => e.locationId.toString() == savedLocationId,
>>>>>>> pratyush
      );
    }
  }

<<<<<<< HEAD
  Future<void> loadLocations(int parentAccountId) async {
    locations.clear();
    selectedLocation.value = null;
=======
  /* ---------------- LOAD LOCATIONS ---------------- */
  Future<void> loadLocations(int parentAccountId) async {
    locations.clear();
    selectedLocation.value = null;

>>>>>>> pratyush
    locations.value = await service.fetchLocations(parentAccountId);

    final savedLocationId = await SecureStorage.getLocationId();
    if (savedLocationId != null) {
      selectedLocation.value = locations.firstWhereOrNull(
<<<<<<< HEAD
            (e) => e.locationId.toString() == savedLocationId,
=======
        (e) => e.locationId.toString() == savedLocationId,
>>>>>>> pratyush
      );
    }
  }

<<<<<<< HEAD
  void onAccountChanged(ParentAccountModel? account) async {
    selectedAccount.value = account;
=======
  /* ---------------- ON ACCOUNT CHANGE ---------------- */
  void onAccountChanged(ParentAccountModel? account) async {
    selectedAccount.value = account;

>>>>>>> pratyush
    if (account != null) {
      await SecureStorage.saveParentAccount(
        id: account.parentAccountId.toString(),
        name: account.accountName,
      );
<<<<<<< HEAD
      selectedLocation.value = null;
      locations.clear();
=======

      selectedLocation.value = null;
      locations.clear();

>>>>>>> pratyush
      await loadLocations(account.parentAccountId);
    }
  }

<<<<<<< HEAD
  // ✅ FIXED submit()
  void submit() async {
    if (selectedAccount.value == null || selectedLocation.value == null) {
      Get.snackbar(
        "Error",
        "Please select both account and location",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

    try {
      // 1. Storage mein save karo
      await SecureStorage.saveParentAccount(
        id: selectedAccount.value!.parentAccountId.toString(),
        name: selectedAccount.value!.accountName,
      );
      await SecureStorage.saveLocation(
        id: selectedLocation.value!.locationId.toString(),
        name: selectedLocation.value!.locationName,
      );

      // 2. HomeController in-memory update
      if (Get.isRegistered<HomeController>()) {
        final homeCtrl = Get.find<HomeController>();
        homeCtrl.updateSelectedAccount(
          parentAccountName: selectedAccount.value!.accountName,
          locationName: selectedLocation.value!.locationName,
        );
        homeCtrl.loadTyreCountByAccount();
        homeCtrl.loadVehicleCountByAccount();
      }

      // 3. Baaki controllers refresh
      if (Get.isRegistered<AllVehicleController>()) {
        await Get.find<AllVehicleController>().loadVehicles();
      }
      if (Get.isRegistered<AllTyreController>()) {
        final tyreCtrl = Get.find<AllTyreController>();
        await tyreCtrl.fetchData(
          tyreCtrl.tabs[tyreCtrl.tabController!.index],
        );
      }
      if (Get.isRegistered<SelectedAccountController>()) {
        await Get.find<SelectedAccountController>().refresh();
      }

      // 4. ✅ Get.back(result: true) — HomeView ko signal milega
      Get.back(result: true);

      Get.snackbar(
        "Success",
        "Account & Location updated successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
=======
  /* ---------------- SUBMIT ---------------- */
  void submit() async {
    if (selectedAccount.value == null || selectedLocation.value == null) return;

    /// SAVE STORAGE
    await SecureStorage.saveParentAccount(
      id: selectedAccount.value!.parentAccountId.toString(),
      name: selectedAccount.value!.accountName,
    );

    await SecureStorage.saveLocation(
      id: selectedLocation.value!.locationId.toString(),
      name: selectedLocation.value!.locationName,
    );

    /// UPDATE HOME
    final homeCtrl = Get.find<HomeController>();
    homeCtrl.updateSelectedAccount(
      parentAccountName: selectedAccount.value!.accountName,
      locationName: selectedLocation.value!.locationName,
    );
    homeCtrl.loadTyreCountByAccount();
    homeCtrl.loadVehicleCountByAccount();

    /// REFRESH OTHER SCREENS
    Get.offNamed(AppPages.HOME);

    if (Get.isRegistered<HomeController>()) {
      await Get.find<HomeController>().refreshHome();
    }
    if (Get.isRegistered<AllVehicleController>()) {
      await Get.find<AllVehicleController>().loadVehicles();
    }

    if (Get.isRegistered<AllTyreController>()) {
      final tyreCtrl = Get.find<AllTyreController>();
      await tyreCtrl.fetchData(tyreCtrl.tabs[tyreCtrl.tabController!.index]);
    }

    if (Get.isRegistered<SelectedAccountController>()) {
      await Get.find<SelectedAccountController>().refresh();
    }

    Get.snackbar("Success", "Account & Location updated");
  }
}
>>>>>>> pratyush
