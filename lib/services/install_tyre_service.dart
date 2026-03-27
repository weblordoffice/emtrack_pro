import 'dart:convert';
import 'package:emtrack/services/api_constants.dart';
import 'package:http/http.dart' as http;
import '../utils/secure_storage.dart';

class InstallTyreService {
  Future<bool> submitInspection(Map<String, dynamic> data) async {
    try {
      final cookie = await SecureStorage.getCookie();
      print("🔐 INSTALL COOKIE => $cookie");
<<<<<<< HEAD
=======
      print("🔐 ORIGINAL DATA: $data");
>>>>>>> pratyush

      if (cookie == null || cookie.isEmpty) {
        throw Exception("Session expired. Please login again.");
      }

<<<<<<< HEAD
      if (data.containsKey("inspectionDate") &&
          data["inspectionDate"] is DateTime) {
        data["inspectionDate"] =
            '${(data["inspectionDate"] as DateTime).toUtc().toIso8601String().split('.').first}Z';
      }

=======
      // 🔥 FIX: Remove problematic fields that cause index errors
      final cleanData = Map<String, dynamic>.from(data);
      cleanData.remove("inspectionId");
      cleanData.remove("removalReasonId");
      cleanData.remove("inspectionDate"); // Remove if causing issues

      // 🔥 FIX: Add proper date formatting
      if (data.containsKey("inspectionDate") &&
          data["inspectionDate"] is DateTime) {
        cleanData["inspectionDate"] =
            '${(data["inspectionDate"] as DateTime).toUtc().toIso8601String().split('.').first}Z';
      }

      // 🔥 ADD: Ensure all required fields exist
      final requiredFields = ["tireId", "vehicleId", "position"];
      for (final field in requiredFields) {
        if (!cleanData.containsKey(field)) {
          print("🔴 MISSING FIELD: $field");
        } else {
          print("✅ FIELD PRESENT: $field = ${cleanData[field]}");
        }
      }

      print("🔐 CLEAN DATA: $cleanData");
      print("🔐 JSON ENCODED: ${jsonEncode(cleanData)}");

>>>>>>> pratyush
      final url = Uri.parse(
        "${ApiConstants.baseUrl}/api/Inspection/InstallTire",
      );
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Cookie": cookie,
      };

      final response = await http.put(
        url,
        headers: headers,
<<<<<<< HEAD
        body: jsonEncode(data),
      );
      // 🔥 Temporary test fix
      data.remove("inspectionId");
      data.remove("removalReasonId");
=======
        body: jsonEncode(cleanData),
      );
>>>>>>> pratyush

      print("📡 STATUS: ${response.statusCode}");
      print("📥 BODY: ${response.body}");

<<<<<<< HEAD
=======
      // 🔥 FINAL DEBUG: Parse response and identify exact issue
      try {
        final responseBody = response.body;
        print("🔍 RESPONSE BODY LENGTH: ${responseBody.length}");
        print(
          "🔍 RESPONSE BODY START: ${responseBody.substring(0, responseBody.length > 500 ? 500 : responseBody.length)}",
        );

        if (responseBody.contains("IndexOutOfRangeException")) {
          print("🔴 INDEX ERROR FOUND IN RESPONSE!");
          print("🔴 ISSUE: Backend array index out of bounds");
          print("🔴 SOLUTION: Check data being sent to backend");
        }

        if (responseBody.contains("didError") &&
            responseBody.contains("true")) {
          print("🔴 BACKEND ERROR: didError = true");
          final errorMatch = RegExp(
            r'"errorMessage":"([^"]+)"',
          ).firstMatch(responseBody);
          if (errorMatch != null) {
            print("🔴 BACKEND MESSAGE: ${errorMatch.group(1)}");
          }
        }
      } catch (e) {
        print("🔴 RESPONSE PARSING ERROR: $e");
      }

>>>>>>> pratyush
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded["didError"] == false) return true;
        throw Exception(
          decoded["errorMessage"] ??
              "Backend returned an error without message.",
        );
      }

      if (response.statusCode == 401) {
        await SecureStorage.clearCookie();
        throw Exception("Session expired. Please login again.");
      }

<<<<<<< HEAD
      final fallback = await http.put(
        Uri.parse("${ApiConstants.baseUrl}/api/Inspection/InstallTire"),
        headers: headers,
        body: jsonEncode(data),
      );
      print("RAW JSON => ${jsonEncode(data)}");

      print("📡 RETRY STATUS: ${fallback.statusCode}");
      print("📥 RETRY BODY: ${fallback.body}");

      if (fallback.statusCode == 200) {
        final decoded = jsonDecode(fallback.body);

        if (decoded["didError"] == false) return true;
        throw Exception(
          decoded["errorMessage"] ??
              "Backend returned an error without message.",
        );
      }

=======
>>>>>>> pratyush
      throw Exception(
        "Failed with status code ${response.statusCode}: ${response.reasonPhrase}",
      );
    } catch (e) {
      print("❌ Install Tire API Error: $e");
      rethrow;
    }
  }
}
