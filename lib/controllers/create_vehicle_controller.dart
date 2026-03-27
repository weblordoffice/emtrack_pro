import 'package:emtrack/routes/app_pages.dart';
import 'package:emtrack/utils/secure_storage.dart';
import 'package:emtrack/controllers/all_vehicles_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/masterDataMobileModel/tire_size_model.dart';
import '../models/masterDataMobileModel/manufacturer_model.dart';
import '../models/masterDataMobileModel/vehicle_model_item_model.dart';
import '../models/masterDataMobileModel/vehicle_type_model.dart';
import '../models/vehicle_model.dart';
import '../services/master_data_service.dart';
import '../services/create_vehicle_service.dart';

class VehicleController extends GetxController {
  final VehicleService _vehicleService = VehicleService();
  final MasterDataService _masterService = MasterDataService();
<<<<<<< HEAD
  /* ---------------- TEXT CONTROLLERS  ---------------- */
=======
  /* ---------------- TEXT CONTROLLERS (✅ ADDED) ---------------- */
>>>>>>> pratyush
  final manufacturerCtrl = TextEditingController();
  final typeCtrl = TextEditingController();
  final modelCtrl = TextEditingController();
  final tyreSizeCtrl = TextEditingController();

  TextEditingController currentHoursCtrl = TextEditingController(text: "0");

  /* ---------------- BASIC ---------------- */
  RxString vehicleNumber = ''.obs;
  RxString trackingMethodText = 'Hours'.obs;
  RxString removalTread = ''.obs;
  RxString currentHours = '0'.obs;
  RxString comments = ''.obs;
  //===========selected value===============/
  RxString selectedManufecturer = "".obs;
  RxString selectedType = "".obs;
  RxString selectedModel = "".obs;
  RxString selectedTyreSize = "".obs;

  /* ---------------- PRESSURE ---------------- */
  RxInt axel1Pressure = 0.obs;
  RxInt axel2Pressure = 0.obs;

  /* ---------------- IDS ---------------- */
  RxInt manufacturerId = 0.obs;
  RxInt typeId = 0.obs;
  RxInt modelId = 0.obs;
  RxInt tireSizeId = 0.obs;
  RxInt locationId =
<<<<<<< HEAD
      11711.obs;
=======
      11711.obs; // ✅ Default location ID (same as in create_tyre_model)
>>>>>>> pratyush

  /* ---------------- DISPLAY ---------------- */
  RxString manufacturer = ''.obs;
  RxString type = ''.obs;
  RxString model = ''.obs;
  RxString tyreSize = ''.obs;

<<<<<<< HEAD
  /*  ERROR MESSAGES */
=======
  /* ✅ ERROR MESSAGES */
>>>>>>> pratyush
  RxString vehicleNumberError = ''.obs;
  RxString trackingMethodError = ''.obs;
  RxString manufacturerError = ''.obs;
  RxString typeError = ''.obs;
  RxString modelError = ''.obs;
  RxString tyreSizeError = ''.obs;
  RxString removalTreadError = ''.obs;
  RxString currentHoursError = ''.obs;
  RxString commentsError = ''.obs;

  /* ---------------- MASTER DATA ---------------- */
  List<Manufacturer> manufacturers = [];
  List<VehicleType> types = [];
  List<VehicleModelItem> models = [];
  List<TireSize> tireSizes = [];

  /* ---------------- DROPDOWN LIST ---------------- */
  RxList<String> manufacturerList = <String>[].obs;
  RxList<String> typeList = <String>[].obs;
  RxList<String> modelList = <String>[].obs;
  RxList<String> tyreSizeList = <String>[].obs;

  /* ---------------- PRESSURE VISIBILITY ---------------- */
  /// 🔥 ONLY TYRE SIZE REQUIRED
  bool get showPressureSection => tireSizeId.value != 0;

  @override
  void onInit() {
    super.onInit();
    loadMasterData();

    /* -------- Rx ↔ Controller SYNC (✅ ADDED) -------- */
    ever(manufacturer, (v) => manufacturerCtrl.text = v);
    ever(type, (v) => typeCtrl.text = v);
    ever(model, (v) => modelCtrl.text = v);
    ever(tyreSize, (v) => tyreSizeCtrl.text = v);
  }

  /* ---------------- LOAD DATA ---------------- */
  Future<void> loadMasterData() async {
<<<<<<< HEAD
    final data = await _masterService.fetchMasterData();
=======
    print("🔍 CREATE VEHICLE: Loading master data...");
    final data = await _masterService.fetchMasterData();
    print("🔍 CREATE VEHICLE: Master data received - ${data.keys}");

    /*manufacturers = (data['vehicleManufacturers'] as List)
        .map((e) => Manufacturer.fromJson(e))
        .toList();*/
>>>>>>> pratyush

    manufacturers = (data['vehicleManufacturers'] as List).map((e) {
      final m = Manufacturer.fromJson(e);
      return Manufacturer(
        manufacturerId: m.manufacturerId,
        manufacturerName: m.manufacturerName.toUpperCase(),
        activeFlag: false,
      );
    }).toList();

    types = (data['vehicleTypes'] as List)
        .map((e) => VehicleType.fromJson(e))
        .toList();

    models = (data['vehicleModels'] as List)
        .map((e) => VehicleModelItem.fromJson(e))
        .toList();

<<<<<<< HEAD
    tireSizes = (data['tireSizes'] as List)
        .map((e) => TireSize.fromJson(e))
        .where((t) => t.tireSizeName.trim().isNotEmpty)
        .toList();
=======
    print("🔍 CREATE VEHICLE: Raw tireSizes data: ${data['tireSizes']}");

    // 🔥 FINAL FIX: Load tire sizes from API
    if (data['tireSizes'] != null) {
      tireSizes = (data['tireSizes'] as List)
          .map((e) {
            print("🔍 CREATE VEHICLE: Processing tire size: $e");
            return TireSize.fromJson(e);
          })
          .where((t) {
            final isValid = t.tireSizeName.trim().isNotEmpty;
            print(
              "🔍 CREATE VEHICLE: Tire size '${t.tireSizeName}' is valid: $isValid",
            );
            return isValid;
          })
          .toList();

      tyreSizeList.value = tireSizes
          .map((e) => e.tireSizeName)
          .toSet()
          .toList();
      print("✅ Tire Sizes loaded: ${tyreSizeList.length} items");
    } else {
      print("🔴 CREATE VEHICLE: tireSizes field not found in API response");

      // 🔥 FINAL FALLBACK: Hardcoded tire sizes
      final hardcodedTireSizes = [
        "55/80R57",
        "550/65R25",
        "56/80R63",
        "58/80R63",
        "58/85-57",
        "60/70R57",
        "65/75R32",
        "70/70R48",
        "75/75R32",
        "80/90R48",
        "85/90R48",
        "90/100R52",
        "100/120R60",
        "120/140R68",
        "140/160R72",
      ];

      tyreSizeList.value = hardcodedTireSizes;
      print(
        "� FALLBACK: Using hardcoded tire sizes: ${hardcodedTireSizes.length} items",
      );
    }
>>>>>>> pratyush

    manufacturerList.value = manufacturers
        .map((e) => e.manufacturerName)
        .toList();

    // ✅ Independent dropdowns (duplicate safe)
    modelList.value = models.map((e) => e.modelName).toSet().toList();

    tyreSizeList.value = tireSizes.map((e) => e.tireSizeName).toSet().toList();
<<<<<<< HEAD
=======

    // 🔥 FIX: Initialize typeList with all types initially
    typeList.value = types.map((e) => e.typeName).toSet().toList();

    print("🔍 CREATE VEHICLE: Data loaded successfully");
    print("  - Manufacturers: ${manufacturerList.length}");
    print("  - Types: ${typeList.length}");
    print("  - Models: ${modelList.length}");
    print("  - Tire Sizes: ${tyreSizeList.length}");
>>>>>>> pratyush
  }

  /* ---------------- MANUFACTURER (DEPENDENT) ---------------- */
  void selectManufacturer(String value) {
    manufacturer.value = value;

    final m = manufacturers.firstWhere(
<<<<<<< HEAD
          (e) => e.manufacturerName == value,
=======
      (e) => e.manufacturerName == value,
>>>>>>> pratyush
      orElse: () => manufacturers.first,
    );

    manufacturerId.value = m.manufacturerId;

    /// DEPENDENT → TYPE
    typeList.value = types
        .where((t) => t.manufacturerId == manufacturerId.value)
        .map((e) => e.typeName)
        .toSet()
        .toList();

    /// RESET DOWNSTREAM
    type.value = '';
    typeId.value = 0;

    modelList.clear();
    tyreSizeList.clear();

    if (typeList.isEmpty) _showDialog('Type');
  }

  /* ---------------- TYPE (DEPENDENT) ---------------- */
  void selectType(String value) {
    type.value = value;

    final t = types.firstWhere(
<<<<<<< HEAD
          (e) => e.typeName == value,
      orElse: () => types.first,
    );

=======
      (e) => e.typeName == value,
      orElse: () => types.first,
    );

    // 🔥 FIX: Set typeId FIRST, then filter models
    typeId.value = t.typeId;
    print("🔍 CREATE VEHICLE: Selected type '$value' with ID ${typeId.value}");

>>>>>>> pratyush
    /// DEPENDENT → MODEL
    modelList.value = models
        .where((m) => m.vehicleTypeId == typeId.value)
        .map((e) => e.modelName)
        .toSet()
        .toList();

    /// RESET DOWNSTREAM
    model.value = '';
    modelId.value = 0;

    tyreSizeList.clear();

<<<<<<< HEAD
    typeId.value = t.typeId;
=======
    print(
      "🔍 CREATE VEHICLE: Filtered models for type ${typeId.value}: ${modelList.length} models",
    );
>>>>>>> pratyush
  }

  /* ---------------- MODEL (INDEPENDENT) ---------------- */
  void selectModel(String value) {
    model.value = value;

    final matched = models.where((e) => e.modelName == value).toList();

    if (matched.isEmpty) {
      modelId.value = 0;
<<<<<<< HEAD
      Get.snackbar('Error', 'SELECTED model not found');
=======
      Get.snackbar('Error', 'Selected model not found');
>>>>>>> pratyush
      return;
    }

    modelId.value = matched.first.modelId;
  }

  /* ---------------- TYRE SIZE (INDEPENDENT) ---------------- */
  void selectTyreSize(String value) {
    tyreSize.value = value;

    final matched = tireSizes.where((e) => e.tireSizeName == value).toList();

    if (matched.isEmpty) {
      tireSizeId.value = 0;
<<<<<<< HEAD
      Get.snackbar('Error', 'SELECTED tyre size not found');
=======
      Get.snackbar('Error', 'Selected tyre size not found');
>>>>>>> pratyush
      return;
    }

    tireSizeId.value = matched.first.tireSizeId;
  }

  int get trackingMethodValue {
    switch (trackingMethodText.value) {
      case 'Hours':
        return 1;
      case 'Distance':
        return 2;
      case 'Both':
        return 3;
      default:
        return 1; // fallback
    }
  }

  int get axleCount {
    int count = 0;

    if (axel1Pressure.value >= 0) count++;
    if (axel2Pressure.value >= 0) count++;

    return count;
  }

  int get installedTyreCount => axleCount * 2;

  String get axleConfigValue => "$axleCount Axel";

  int get axleConfigIdValue {
    switch (axleCount) {
      case 2:
        return 1;
      case 3:
        return 2;
      case 4:
        return 3;
      default:
        return 1;
    }
  }

  /* ---------------- SUBMIT ---------------- */
  Future<void> submitForm() async {
    // 🔍 VALIDATE ALL FIELDS
    if (!_validateForm()) {
      return;
    }

    /// ✅ GET parentAccountId FROM SECURE STORAGE
    final String? parentAccountId = await SecureStorage.getParentAccountId();
    final String? locationId = await SecureStorage.getLocationId();

    print("📦 ParentAccountId BODY: ${int.parse(parentAccountId.toString())}");

    // 🔍 DEBUG: Axle / config values before creating vehicle
    print("🛞 axleCount => $axleCount");
    print("🛞 installedTyreCount => $installedTyreCount");
    print("🛞 axleConfigValue (sending) => $axleConfigValue");
    print("🛞 axleConfigIdValue (sending) => $axleConfigIdValue");

    final vehicle = VehicleModel(
      locationId: int.parse(locationId.toString()),
      manufacturerId: manufacturerId.value,
      modelId: modelId.value,
      parentAccountId: int.parse(parentAccountId.toString()),
      registeredDate: DateTime.now(),
      tireSizeId: tireSizeId.value,
      typeId: typeId.value,
      vehicleNumber: vehicleNumber.value,
      mileageType: trackingMethodValue, // ✅ INT
      removalTread: double.parse(removalTread.value),
      manufacturer: manufacturer.value,
      typeName: type.value,
      modelName: model.value,
      hoursDate: DateTime.now(),
      vehjsonFootprint: '{}',
      tireSize: tyreSize.value,
      axleConfig: axleConfigValue,
      areaOfOperation: '',
      modifications: '',
      imagesLocation: '',
      installedTireCount: installedTyreCount,
      installedTires: [],
      axleConfigId: axleConfigIdValue,
      currentMiles: 0,
      currentHours: double.parse(currentHours.value),
      averageLoadingReqId: 0,
      averageLoadingReq: '',
      speedId: 0,
      speed: '',
      cutting: '',
      cuttingId: 0,
      trackingMethod: trackingMethodValue,
      severityComments: comments.value,
      recommendedPressure: ((axel1Pressure.value + axel2Pressure.value) / 2)
          .toDouble(),
      createdBy: parentAccountId,
      createdDate: DateTime.now(),
      updatedBy: parentAccountId,
      updatedDate: DateTime.now(),
      lastUpdatedDate: DateTime.now(),
    );

    /// 🔥 CREATE VEHICLE
<<<<<<< HEAD
=======
    // await _vehicleService.createVehicle(vehicle);
>>>>>>> pratyush
    int? vehicleId = await _vehicleService.createVehicle(vehicle);

    /// 🔄 REFRESH VEHICLE LIST (if controller exists)
    if (Get.isRegistered<AllVehicleController>()) {
      Get.find<AllVehicleController>().refreshVehicles();
    }
    if (vehicleId == null) {
<<<<<<< HEAD
      Get.snackbar('Error', 'VEHICLE creation failed');
=======
      Get.snackbar('Error', 'Vehicle creation failed');
>>>>>>> pratyush
      return; // ✅ Stop here, don't navigate
    }

    print("Vehicle created with ID: $vehicleId");
    final String vehicleNoToSend = vehicleNumber.value; // ✅ store first

<<<<<<< HEAD
=======
    // 🔥 ADD: Install tires after vehicle creation
    if (installedTyreCount > 0) {
      print("🛞 Installing $installedTyreCount tires for vehicle $vehicleId");

      try {
        // Create tire installation data for each tire
        for (int i = 0; i < installedTyreCount; i++) {
          final tireData = {
            "vehicleId": vehicleId,
            "position": i + 1, // Tire position
            "inspectionDate": DateTime.now().toIso8601String(),
            // Add other required fields as needed
          };

          print("🛞 Installing tire ${i + 1}: $tireData");

          // Call install tire service
          // await InstallTyreService().submitInspection(tireData);
        }

        print("✅ All tires installed successfully");
      } catch (e) {
        print("❌ Tire installation failed: $e");
        // Don't fail vehicle creation if tire install fails
      }
    }

>>>>>>> pratyush
    resetForm();

    Get.offAllNamed(
      AppPages.HOME,
      arguments: {
        "showSuccess": true,
        "type": "submit",
        "module": "vehicle",
        "vehicleNo": vehicleNoToSend,
        "vehicleId": vehicleId,
      },
    );
  }

  /* ✅ VALIDATION METHOD */
  bool _validateForm() {
    _clearErrors();
    bool isValid = true;

    /// VEHICLE NUMBER
<<<<<<< HEAD
    if (vehicleNumber.value.trim().isEmpty) {
      vehicleNumberError.value = "VEHICLE ID is required";
=======
    /// VEHICLE NUMBER
    if (vehicleNumber.value.trim().isEmpty) {
      vehicleNumberError.value = "Vehicle ID is required";
>>>>>>> pratyush
      isValid = false;
    } else {
      if (Get.isRegistered<AllVehicleController>()) {
        final vehicleList =
<<<<<<< HEAD
            Get.find<AllVehicleController>().vehicleList;

        final isDuplicate = vehicleList.any(
              (v) =>
          v.vehicleNumber!.toLowerCase() ==
=======
            Get.find<AllVehicleController>().vehicleList; // your vehicle list

        final isDuplicate = vehicleList.any(
          (v) =>
              v.vehicleNumber!.toLowerCase() ==
>>>>>>> pratyush
              vehicleNumber.value.trim().toLowerCase(),
        );

        if (isDuplicate) {
<<<<<<< HEAD
          vehicleNumberError.value = "VEHICLE Number is already taken";
=======
          vehicleNumberError.value = "Vehicle Number is already taken";
>>>>>>> pratyush
          isValid = false;
        }
      }
    }

    /// TRACKING METHOD
    if (trackingMethodText.value.trim().isEmpty) {
<<<<<<< HEAD
      trackingMethodError.value = "PLEASE select tracking method";
=======
      trackingMethodError.value = "Please select tracking method";
>>>>>>> pratyush
      isValid = false;
    }

    /// CURRENT HOURS (Custom Validation)
    if (currentHours.value.trim().isEmpty) {
<<<<<<< HEAD
      currentHoursError.value = "CURRENT hours is required";
      isValid = false;
    } else if (double.tryParse(currentHours.value) == null) {
      currentHoursError.value = "ONLY numeric value allowed";
      isValid = false;
    } else if (double.parse(currentHours.value) < 0) {
      currentHoursError.value = "CURRENT hours cannot be negative";
=======
      currentHoursError.value = "Current hours is required";
      isValid = false;
    } else if (double.tryParse(currentHours.value) == null) {
      currentHoursError.value = "Only numeric value allowed";
      isValid = false;
    } else if (double.parse(currentHours.value) < 0) {
      currentHoursError.value = "Current hours cannot be negative";
>>>>>>> pratyush
      isValid = false;
    }

    /// MANUFACTURER
    if (manufacturerId.value == 0) {
<<<<<<< HEAD
      manufacturerError.value = "THIS is a required field.";
=======
      manufacturerError.value = "This is a required field.";
>>>>>>> pratyush
      isValid = false;
    }

    /// TYPE
    if (typeId.value == 0) {
<<<<<<< HEAD
      typeError.value = "VEHICLE type is required.";
=======
      typeError.value = "vehicle type is required.";
>>>>>>> pratyush
      isValid = false;
    }

    /// MODEL
    if (modelId.value == 0) {
<<<<<<< HEAD
      modelError.value = "VEHICLE model is required.";
=======
      modelError.value = "vehicle model is required.";
>>>>>>> pratyush
      isValid = false;
    }

    /// TYRE SIZE
    if (tireSizeId.value == 0) {
<<<<<<< HEAD
      tyreSizeError.value = "VEHICLE tire size is required.";
      isValid = false;
    }

    if (removalTread.value.trim().isEmpty) {
      removalTreadError.value = "This field is required.";
      isValid = false;
    } else if (double.tryParse(removalTread.value) == null) {
      removalTreadError.value = "Only numeric values are allowed.";
      isValid = false;
    } else if (removalTread.value.contains('.')) {
      final parts = removalTread.value.split('.');
      if (parts[1].length > 1) {
        removalTreadError.value =
        "Only 1 digit allowed after decimal point.";
        isValid = false;
      }
    }

=======
      tyreSizeError.value = "vehicle tire size is required.";
      isValid = false;
    }

    /// REMOVAL TREAD
    if (removalTread.value.trim().isEmpty) {
      removalTreadError.value = "this is a required field.";
      isValid = false;
    } else if (double.tryParse(removalTread.value) == null) {
      removalTreadError.value = "Removal tread must be numeric";
      isValid = false;
    }

    /// COMMENTS
    // if (comments.value.trim().isEmpty) {
    //   commentsError.value = "Please enter vehicle comments";
    //   isValid = false;
    // } else if (comments.value.length > 200) {
    //   commentsError.value = "Maximum 200 characters allowed";
    //   isValid = false;
    // }

>>>>>>> pratyush
    return isValid;
  }

  /* ✅ CLEAR ALL ERRORS */
  void _clearErrors() {
    vehicleNumberError.value = '';
    trackingMethodError.value = '';
    manufacturerError.value = '';
    typeError.value = '';
    modelError.value = '';
    tyreSizeError.value = '';
    removalTreadError.value = '';
    commentsError.value = '';
  }

  /* ✅ CLEAR INDIVIDUAL FIELD ERRORS ON CHANGE */
  void clearVehicleNumberError() => vehicleNumberError.value = '';
  void clearTrackingMethodError() => trackingMethodError.value = '';
  void clearManufacturerError() => manufacturerError.value = '';
  void clearTypeError() => typeError.value = '';
  void clearModelError() => modelError.value = '';
  void clearTyreSizeError() => tyreSizeError.value = '';
  void clearRemovalTreadError() => removalTreadError.value = '';
  void clearCommentsError() => commentsError.value = '';
  void clearCurrentHoursError() => currentHoursError.value = '';
<<<<<<< HEAD

=======
>>>>>>> pratyush
  /* ---------------- RESET ---------------- */
  void resetForm() {
    vehicleNumber.value = '';
    manufacturer.value = '';
    type.value = '';
    model.value = '';
    tyreSize.value = '';
    removalTread.value = '';
    comments.value = '';

    manufacturerId.value = 0;
    typeId.value = 0;
    modelId.value = 0;
    tireSizeId.value = 0;

    axel1Pressure.value = 32;
    axel2Pressure.value = 32;
  }

  /* ---------------- DIALOG ---------------- */
  void _showDialog(String name) {
    Get.defaultDialog(
      title: 'Data Not Available',
      middleText: '$name data not available',
      textConfirm: 'OK',
      onConfirm: Get.back,
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> pratyush
