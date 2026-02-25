import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emtrack/routes/app_pages.dart';
import 'package:emtrack/utils/secure_storage.dart';

import '../models/preferences_model.dart';
import '../models/country/country_model.dart';
import '../models/country/country_response.dart';
import '../services/preferences_service.dart';

class PreferencesController extends GetxController {
  final PreferencesService service = PreferencesService();

  // 🔹 Country Data
  // RxList<CountryModel> countries = <CountryModel>[].obs;
  // Rx<CountryModel?> selectedCountry = Rx<CountryModel?>(null);

  // 🔹 Dropdown static data
  final measurementSystems = ['Metric', 'Imperial'];
  final pressureUnits = ['PSI', 'KPA', 'Bar'];
  final languages = [
    'English (US/Canada)',
    'English (UK/Australia)',
    'Hindi',
    'Español',
    'Deutsche',
    'Italiano',
  ];
  // 🔹 Selected values
  RxString selectedLanguage = 'English (UK/Australia)'.obs;
  RxString selectedMeasurement = 'Imperial'.obs;
  RxString selectedPressure = 'PSI'.obs;
  //=========

  // Future<void> getCountries() async {
  //   try {
  //     final response = await service.getCountries();
  //     countries.assignAll(response.model ?? []);
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   }
  // }

  // 🔹 Language → Locale mapper
  Locale _mapLanguageToLocale(String language) {
    switch (language) {
      case 'Hindi':
        return const Locale('hi');
      case 'Español':
        return const Locale('es');
      case 'Deutsche':
        return const Locale('de');
      case 'Italiano':
        return const Locale('it');
      default:
        return const Locale('en');
    }
  }

  // 🔹 Update methods
  void updateLanguage(String value) {
    selectedLanguage.value = value;
    Get.updateLocale(_mapLanguageToLocale(value));
    SecureStorage.savePreference('language', value);
  }

  void updateMeasurement(String value) {
    selectedMeasurement.value = value;
    SecureStorage.savePreference('measurement', value);
  }

  void updatePressure(String value) {
    selectedPressure.value = value;
    SecureStorage.savePreference('pressure', value);
  }

  // 🔹 Load saved preferences
  Future<void> _loadSavedPreferences() async {
    final lang = await SecureStorage.getPreference('language');
    if (lang != null) {
      selectedLanguage.value = lang;
      Get.updateLocale(_mapLanguageToLocale(lang));
    }

    final measurement = await SecureStorage.getPreference('measurement');
    if (measurement != null) {
      selectedMeasurement.value = measurement;
    }

    final pressure = await SecureStorage.getPreference('pressure');
    if (pressure != null) {
      selectedPressure.value = pressure;
    }
  }

  // 🔹 Load Country API
  // Future<void> loadCountries() async {
  //   try {
  //     CountryResponse response = await service.getCountries();
  //     countries.assignAll(response.model ?? []);
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to load countries");
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    _loadSavedPreferences();
    // getCountries();
    // loadCountries();
  }

  // 🔹 Save Preferences API
  Future<void> updatePre() async {
    final username = await SecureStorage.getUserName();

    final model = PreferencesModel(
      userId: username,
      updatedBy: username,
      language: selectedLanguage.value,
      measurementSystem: selectedMeasurement.value,
      pressureUnit: selectedPressure.value,
      logoLocation: "",
      updatedDate: DateTime.now(),
      lastAccessedAccountId: 0,
      lastAccessedLocationId: 0,
      lastAccessedAccountName: "",
      lastAccessedLocationName: "",
    );

    try {
      await service.updatePreferences(model);
      Get.snackbar("Success", "Preferences updated");
      Get.offAllNamed(AppPages.HOME);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void cancelPreferences() {
    Get.back();
  }
}
