import 'package:emtrack/routes/app_pages.dart';
import 'package:emtrack/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/tyre_model.dart';
import '../services/tyre_service.dart';
import '../inspection/edit_vehicle_inspection_view.dart';
import '../views/tyre_view.dart';

class SearchInstallTireController extends GetxController {
  final TyreService service = TyreService();

  /// 🔄 Loader
  final RxBool isLoading = false.obs;

  /// 📦 API data (Only Inventory)
  final RxList<TyreModel> allTyres = <TyreModel>[].obs;

  /// 👁 Visible (Search filtered)
  final RxList<TyreModel> visibleTyres = <TyreModel>[].obs;

  /// 🔍 Search text
  final RxString searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInventoryTyres();
  }

  // ==================================================
  // 📡 FETCH INVENTORY TYRES ONLY
  // ==================================================
  Future<void> fetchInventoryTyres() async {
    try {
      isLoading.value = true;

      final parentAccountId = await SecureStorage.getParentAccountId();

      if (parentAccountId == null || parentAccountId.isEmpty) {
        Get.snackbar("Error", "Parent account not selected");
        return;
      }

      final tyres = await service.getTyresByAccount(int.parse(parentAccountId));

      // 🔥 FILTER ONLY INVENTORY
      final inventoryTyres = tyres.where(
        (t) => (t.dispositionName ?? '').toLowerCase().trim() == "inventory",
      );

      allTyres.assignAll(inventoryTyres);
      visibleTyres.assignAll(inventoryTyres);

      print("✅ Inventory Tyres Loaded => ${visibleTyres.length}");
    } catch (e) {
      print("❌ Error: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ==================================================
  // 🔍 SEARCH FILTER
  // ==================================================
  void onSearch(String value) {
    searchText.value = value;

    if (value.trim().isEmpty) {
      visibleTyres.assignAll(allTyres);
      return;
    }

    final query = value.toLowerCase();

    visibleTyres.assignAll(
      allTyres.where((t) {
        return (t.tireSerialNo ?? '').toLowerCase().contains(query) ||
            (t.sizeName ?? '').toLowerCase().contains(query) ||
            (t.vehicleNumber ?? '').toLowerCase().contains(query) ||
            (t.manufacturerName ?? '').toLowerCase().contains(query);
      }).toList(),
    );

    print("🔎 Search Result => ${visibleTyres.length}");
  }

  // ==================================================
  // 📌 BOTTOM SHEET
  // ==================================================
  void openBottomSheet(TyreModel tyre) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Center(child: Text('View')),
              onTap: () {
                Get.back();
                Get.to(() => TyreView(), arguments: tyre.tireId);
              },
            ),
            ListTile(
              title: const Center(child: Text('Edit')),
              onTap: () {
                Get.back();
                Get.toNamed(AppPages.EDIT_TIRE_SCREEN, arguments: tyre.tireId);
              },
            ),
            ListTile(
              title: const Center(child: Text('Clone')),
              onTap: () {
                Get.back();
                Get.toNamed(AppPages.CREATE_TYRE);
              },
            ),
          ],
        ),
      ),
    );
  }
}
