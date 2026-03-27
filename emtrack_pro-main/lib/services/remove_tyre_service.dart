import 'dart:convert';
import 'package:yokohama_emtrack/models/masterDataMobileModel/Tire_remove_reason_model.dart';
import 'package:yokohama_emtrack/models/masterDataMobileModel/tire_desposition_model.dart';
import 'package:yokohama_emtrack/models/masterDataMobileModel/master_model.dart';
import 'package:yokohama_emtrack/services/api_constants.dart';
import 'package:yokohama_emtrack/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

class RemoveTyreService {
  // ==========================================================
  // ✅ SUBMIT REMOVE TYRE (Cookie-based auth)
  // ==========================================================
  Future<bool> submitRemoveTyre(Map<String, dynamic> data) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/api/Inspection/RemoveTire");
    final cookies = await SecureStorage.getCookie(); // ✅ get cookie

    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        if (cookies != null && cookies.isNotEmpty) "Cookie": cookies,
      },
      body: jsonEncode([data]),
    );

    print("📦 REMOVE TYRE PAYLOAD => $data");
    print("📡 RESPONSE => ${response.body}");

    if (response.statusCode == 200) return true;

    throw Exception(
      "Failed to remove tyre. StatusCode: ${response.statusCode}",
    );
  }

  // ==========================================================
  // ✅ GET MASTER DATA (Cookie-based auth)
  // ==========================================================
  Future<MasterModel?> getMasterData() async {
    try {
      final url = Uri.parse(
        "${ApiConstants.baseUrl}/api/MasterData/GetMasterDataMobile",
      );

      // ✅ Get cookie from secure storage
      final cookies = await SecureStorage.getCookie();
      if (cookies == null || cookies.isEmpty) {
        print("No cookie found. Please login first!");
        return null;
      }
      print("🌍 MASTER API URL => $url");
      print("🍪 COOKIE => $cookies");

      // ✅ Set headers with cookie
      final headers = {"Content-Type": "application/json", "Cookie": cookies};

      // 🔹 Make GET request
      final response = await http.get(url, headers: headers);
      print("📡 STATUS CODE => ${response.statusCode}");
      print("📦 BODY => ${response.body}");

      // 🔹 Check status code first
      if (response.statusCode != 200) {
        print("Failed to load master data: ${response.statusCode}");
        print("Response body: ${response.body}");
        return null;
      }

      // 🔹 Parse JSON safely
      final data = json.decode(response.body);

      if (data is Map<String, dynamic> && data["model"] != null) {
        return MasterModel.fromJson(data["model"]);
      } else {
        print("Unexpected data structure");
        return null;
      }
    } catch (e) {
      print("Failed to load master data: $e");
      return null;
    }
  }

  // ==========================================================
  // ✅ GET REMOVAL REASONS
  // ==========================================================
  Future<List<TireRemovalReason>> getRemovalReason() async {
    final master = await getMasterData();
    if (master == null) return [];
    return master.tireRemovalReasons;
  }

  // ==========================================================
  // ✅ GET DISPOSITIONS
  // ==========================================================
  Future<List<TireDisposition>> getDispositions() async {
    final master = await getMasterData();
    if (master == null) return [];
    return master.tireDispositions;
  }
}
