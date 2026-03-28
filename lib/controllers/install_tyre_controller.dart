import 'dart:convert';
import 'package:emtrack/inspection/vehicle_inspe_controller.dart';
import 'package:emtrack/models/install_tyre_model.dart';
import 'package:emtrack/services/install_tyre_service.dart';
import 'package:emtrack/services/master_data_service.dart';
import 'package:emtrack/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/tyre_model.dart';
import '../services/tyre_service.dart';

class InstallTyreController extends GetxController {
  final RxBool isSubmitting = false.obs;
  final RxBool isInitialLoading = false.obs;

  final service = InstallTyreService();
  final tyreService = TyreService();
  final picker = ImagePicker();
  final MasterDataService _masterService = MasterDataService();

  Rx<InstallTireModel> model = InstallTireModel().obs;

  // Wear Conditions
  final wearConditionsList = <String>[].obs;
  final wearConditionsIdList = <int>[].obs;
  final RxInt selectedWearConditionsId = 0.obs;
  final wearConditionsId = TextEditingController();

  // Casing Conditions
  final casingConditionList = <String>[].obs;
  final casingConditionIdList = <int>[].obs;
  final RxInt selectedCasingConditionId = 0.obs;
  final casingConditionsId = TextEditingController();

  // Disposition
  final dispositionList = <String>[].obs;
  final dispositionIdList = <int>[].obs;
  final RxInt installedDispositionId = 0.obs;

  final RxString vehicleNumber = "".obs;
  RxList<TyreModel> tyreList = <TyreModel>[].obs;
  RxDouble avgTread = 0.0.obs;

  final commentsController = TextEditingController();
  final previousCommentController = TextEditingController(
    text: "List Of Previous Comments",
  );

  @override
  void onInit() {
    super.onInit();

    commentsController.text = model.value.comments ?? "";

    final args = Get.arguments ?? {};
    print("install tire args => $args");

    final int vehicleId = args["vehicleId"] ?? 0;
    vehicleNumber.value = args["vehicleNumber"] ?? "";
    final String wheelPosition = args["wheelPosition"] ?? "";
    final int tireId = args["tireId"] ?? 0;
    final String serialNo = args["serialNo"] ?? "";

    // Model prefill
    model.update((m) {
      m!.vehicleId = vehicleId;
      m.wheelPosition = wheelPosition;
      m.tireId = tireId;
      m.tireSerialNo = serialNo;
      m.currentTreadDepth = 0.0;
    });

    print("INIT vehicleId => $vehicleId");
    print("INIT wheelPosition => $wheelPosition");
    print("INIT tireId => $tireId");

    loadMasterData();
    loadTyres(tireId);
  }

  // ✅ Counters — Air Pressure
  void incAir() => model.update((m) => m!.currentPressure++);
  void decAir() => model.update((m) {
    if (m!.currentPressure > 0) m.currentPressure--;
  });

  // ✅ Outside Tread
  void incOutside() => model.update((m) {
    m!.outsideTread++;
    _calcAverage(m);
  });

  void decOutside() => model.update((m) {
    if (m!.outsideTread > 0) m.outsideTread--;
    _calcAverage(m);
  });

  // ✅ Inside Tread
  void incInside() => model.update((m) {
    m!.insideTread++;
    _calcAverage(m);
  });

  void decInside() => model.update((m) {
    if (m!.insideTread > 0) m.insideTread--;
    _calcAverage(m);
  });

  // ✅ Average Calculation
  void _calcAverage(InstallTireModel m) {
    final outside = m.outsideTread;
    final inside = m.insideTread;
    final avg = (outside + inside) / 2;
    m.currentTreadDepth = double.parse(avg.toStringAsFixed(2));
  }

  // ✅ Load Master Data
  Future<void> loadMasterData() async {
    try {
      final data = await _masterService.fetchMasterData();
      print("Master api data => $data");

      // Wear Conditions
      wearConditionsList.assignAll(
        (data['wearConditions'] as List)
            .map((e) => e['wearConditionName'].toString().toUpperCase())
            .toSet()
            .toList(),
      );
      wearConditionsIdList.assignAll(
        (data['wearConditions'] as List)
            .map((e) => e['wearConditionId'] as int)
            .toSet()
            .toList(),
      );

      // Casing Conditions
      casingConditionList.assignAll(
        (data['casingCondition'] as List)
            .map((e) => e['casingConditionName'].toString().toUpperCase())
            .toSet()
            .toList(),
      );
      casingConditionIdList.assignAll(
        (data['casingCondition'] as List)
            .map((e) => e['casingConditionId'] as int)
            .toSet()
            .toList(),
      );

      if (wearConditionsIdList.isNotEmpty) {
        selectedWearConditionsId.value = wearConditionsIdList.first;
      }
      if (casingConditionIdList.isNotEmpty) {
        selectedCasingConditionId.value = casingConditionIdList.first;
      }

      // Dispositions
      dispositionList.assignAll(
        (data['tireDispositions'] as List)
            .map((e) => e['dispositionName'].toString().toUpperCase())
            .toList(),
      );
      dispositionIdList.assignAll(
        (data['tireDispositions'] as List)
            .map((e) => e['dispositionId'] as int)
            .toList(),
      );

      // Find "Installed" disposition ID
      for (var d in data['tireDispositions']) {
        if (d['dispositionName'].toString().toLowerCase() == "installed") {
          installedDispositionId.value = d['dispositionId'];
          break;
        }
      }

      print("✅ Installed Disposition ID => ${installedDispositionId.value}");
    } catch (e) {
      print("❌ Master Data Error: $e");
      Get.snackbar("Error", "Failed to load master data: $e");
    }
  }

  // ✅ Load Tyre by ID
  Future<void> loadTyres(int tireId) async {
    isInitialLoading.value = true;
    try {
      final tyres = await tyreService.getTyresById(tireId);
      print("SERVICE RESULT => $tyres");

      tyreList.clear();
      tyreList.addAll(tyres);

      if (tyreList.isNotEmpty) {
        final outside = tyreList.first.outsideTread ?? 0.0;
        final inside = tyreList.first.insideTread ?? 0.0;
        final pressure = tyreList.first.currentPressure ?? 28.0;

        double avg;
        if (outside != 0 && inside != 0) {
          avg = (outside + inside) / 2;
        } else {
          avg = outside != 0 ? outside : inside;
        }

        avgTread.value = double.parse(avg.toStringAsFixed(2));

        // ✅ Model mein set karo taaki UI aur submit dono sync rahein
        model.update((m) {
          m!.currentTreadDepth = avgTread.value;
          m.outsideTread = outside;
          m.insideTread = inside;
          m.currentPressure = pressure;
        });
      }
    } catch (e) {
      print("❌ Error loading tyres: $e");
    } finally {
      isInitialLoading.value = false;
    }
  }

  // ✅ Submit
  Future<void> submit() async {
    if (isSubmitting.value) return;
    isSubmitting.value = true;

    try {
      final parentAccountIdStr = await SecureStorage.getParentAccountId();
      final locationIdStr = await SecureStorage.getLocationId();
      final cookie = await SecureStorage.getCookie();

      if (cookie == null || cookie.isEmpty) {
        Get.snackbar("Error", "Session expired. Please login again.");
        return;
      }

      final parentAccountId = int.tryParse(parentAccountIdStr ?? '') ?? 0;
      final locationId = int.tryParse(locationIdStr ?? '') ?? 0;

      final m = model.value;

      // ✅ Validations
      if (parentAccountId == 0 || locationId == 0) {
        Get.snackbar("Error", "Invalid Account or Location");
        return;
      }
      if (m.tireId == null || m.tireId == 0) {
        Get.snackbar("Error", "Tire ID is missing");
        return;
      }
      if (m.vehicleId == null || m.vehicleId == 0) {
        Get.snackbar("Error", "Vehicle ID is missing");
        return;
      }
      if (installedDispositionId.value == 0) {
        Get.snackbar("Error", "Installed Disposition not found");
        return;
      }
      if (selectedWearConditionsId.value == 0) {
        Get.snackbar("Validation", "Please select Wear Condition");
        return;
      }
      if (selectedCasingConditionId.value == 0) {
        Get.snackbar("Validation", "Please select Casing Condition");
        return;
      }

      // ✅ model.value se values lo — UI changes reflect honge
      final outsideTread = m.outsideTread;
      final insideTread = m.insideTread;
      final currentTread = m.currentTreadDepth ??
          double.parse(((outsideTread + insideTread) / 2).toStringAsFixed(2));
      final currentPressure = m.currentPressure;

      Map<String, dynamic> payload = {
        "action": "Install",
        "inspectionDate": "2026-02-13T08:11:30Z",
        "locationId": locationId,
        "parentAccountId": parentAccountId,
        "vehicleId": m.vehicleId,
        "tireId": m.tireId,
        "tireSerialNo": m.tireSerialNo ?? (tyreList.isNotEmpty ? tyreList.first.tireSerialNo : "") ?? "",
        "originalTread": tyreList.isNotEmpty ? (tyreList.first.originalTread ?? 140.0) : 140.0,
        "outsideTread": outsideTread,      // ✅ model se (UI se)
        "insideTread": insideTread,        // ✅ model se (UI se)
        "currentTreadDepth": currentTread, // ✅ calculated average
        "currentPressure": currentPressure, // ✅ model se (UI se)
        "casingConditionId": selectedCasingConditionId.value,
        "wearConditionId": selectedWearConditionsId.value,
        "comments": (m.comments ?? '').isNotEmpty ? m.comments : "No comments",
        "dispositionId": installedDispositionId.value,
        "wheelPosition": m.wheelPosition?.trim() ?? "",
      };

      print("🚀 SUBMITTING PAYLOAD:");
      print(jsonEncode(payload));

      final success = await service.submitInspection(payload);

      if (success) {
        // ✅ Vehicle inspection refresh
        try {
          final vehicleCtrl = Get.find<VehicleInspeController>();
          await vehicleCtrl.fetchInspectionData();
        } catch (_) {
          // Controller mil nahi toh bhi chalega
        }

        Get.back();
        Get.back();
        Get.snackbar(
          "Success",
          "Tyre Installed Successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("❌ Submit Error: $e");
      Get.snackbar(
        "Error",
        "Failed to install tire: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    commentsController.dispose();
    previousCommentController.dispose();
    wearConditionsId.dispose();
    casingConditionsId.dispose();
    super.onClose();
  }
}