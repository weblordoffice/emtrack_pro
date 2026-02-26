import 'package:emtrack/routes/app_pages.dart';
import 'package:emtrack/services/api_constants.dart';
import 'package:emtrack/services/api_service.dart';
import 'package:emtrack/user_management/user_management_model.dart';
import 'package:emtrack/utils/secure_storage.dart';
import 'package:get/get.dart';

import '../models/country/country_model.dart';

class UserManagementService {
  Future<void> registerUser(UserManagementModel model) async {
    try {
      final createuserResponse = await ApiService.postApi(
        endpoint: ApiConstants.createUser,
        body: {
          "email": model.email,
          "password": model.password,
          "username": model.username,
        },
      );

      print(createuserResponse);

      final createUserProfileResponse = await ApiService.postApi(
        endpoint: ApiConstants.createUserProfile,
        body: {
          "userId": model.username,
          "firstName": model.firstName,
          "middleName": model.middleName,
          "lastName": model.lastName,
          "userRole": model.role,
          "updatedDate": DateTime.now().toIso8601String(),
          "phoneNumber": model.phone,
          "countryCode": model.country,
        },
      );

      print(createUserProfileResponse);

      final parentAccountId = await SecureStorage.getParentAccountId();
      final parentAccountName = await SecureStorage.getParentAccountName();
      final locationId = await SecureStorage.getLocationId();
      final locationName = await SecureStorage.getLocationName();
      final createUserPreferenceResponse = await ApiService.postApi(
        endpoint: ApiConstants.createUserPreference,
        body: {
          "lastAccessedAccountId": parentAccountId,
          "lastAccessedAccountName": parentAccountName,
          "lastAccessedLocationId": locationId,
          "lastAccessedLocationName": locationName,
          "logoLocation": '',
          "updatedBy": model.username,
          "updatedDate": DateTime.now().toIso8601String(),
          "userId": model.username,
          "userLanguage": model.language,
          "userMeasurementSystemValue": model.measurement,
          "userPressureUnit": model.pressureUnit,
        },
      );

      print(createUserPreferenceResponse);

      final assignroleResponse = await ApiService.postApi(
        endpoint: ApiConstants.assignRole,
        body: {"username": model.username, "roleName": model.role},
      );

      print(assignroleResponse);
      if (assignroleResponse["message"] != null) {
        Get.offAllNamed(AppPages.HOME);
      }
    } catch (e) {
      print("❌ Registration Failed: $e");
    }
  }

  Future<List<CountryModel>> countryList() async {
    final response = await ApiService.getApi(
      endpoint: ApiConstants.getCountryList,
    );

    if (response['model'] != null && response['model'].length > 0) {
      return response['model']
          .map<CountryModel>((e) => CountryModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load country list");
    }
  }

  Future<List<String>> getUserRole() async {
    final response = await ApiService.getApi(
      endpoint: ApiConstants.getRoleList,
    );

    if (response != null && response.length > 0) {
      List<String> roles = List<String>.from(response);
      return roles;
    } else {
      throw Exception("Failed to load country list");
    }
  }
}
