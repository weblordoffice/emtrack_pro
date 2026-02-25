import 'dart:convert';

import 'package:emtrack/inspection/vehicle_inspe_model.dart';
import 'package:emtrack/services/api_constants.dart';
import 'package:emtrack/utils/secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VehicleInspeService {
  Future<bool> submitInspection({
    required Map<String, dynamic> vehicleData,
  }) async {
    try {
      // 🔥 Get Cookie Based Headers
      final headers = await SecureStorage.authHeaders();

      final url = Uri.parse(
        "https://emtrackotrapi-staging.azurewebsites.net/api/Inspection/UpdateInspection/",
      );
      print("🟢 PUT URL => $url");
      print("🟢 HEADERS => $headers");
      print("🟢 BODY => ${jsonEncode(vehicleData)}");

      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(vehicleData),
      );

      print("🟡 STATUS => ${response.statusCode}");
      print("🟡 RESPONSE => ${response.body}");

      if (response.statusCode == 200) {
        print("✅ Vehicle Updated Successfully");
        return true;
      } else if (response.statusCode == 401) {
        print("❌ Unauthorized - Cookie expired");
        return false;
      } else {
        print("❌ Failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return false;
    }
  }

  /// Fake API call, always returns true after 1 second
  Future<bool> updateHours(String vehicleId, String hours) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  /// 🔹 GET Inspection Record (Connected With Model)
  Future<VehicleInspectionResponse?> getInspectionRecord(
    String vehicleId,
  ) async {
    try {
      // 🔥 Get Auth Headers (Cookie included)
      final headers = await SecureStorage.authHeaders();

      final url = Uri.parse(
        "${ApiConstants.baseUrl}/api/Inspection/GetInspectionRecordForVehicle/$vehicleId",
      );

      print("🟢 GET URL => $url");
      print("🟢 HEADERS => $headers");

      final response = await http.get(url, headers: headers);

      print("🟡 STATUS => ${response.statusCode}");
      print("🟡 BODY => ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData["didError"] == true) {
          Get.snackbar(
            "Backend Error",
            jsonData["errorMessage"] ?? "Unknown error",
          );
          return null;
        }
        print("✅ Inspection Data Fetched Successfully");

        return VehicleInspectionResponse.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        print("❌ Unauthorized - Cookie expired or not sent");
        return null;
      } else {
        print("❌ Failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return null;
    }
  }
}
