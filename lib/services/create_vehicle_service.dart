import 'dart:convert';
import 'package:emtrack/services/api_constants.dart';
import 'package:emtrack/services/global_logout_handler.dart';
import 'package:emtrack/utils/secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/vehicle_model.dart';

class VehicleService {
  /// CREATE VEHICLE (with Cookie)
  Future<int?> createVehicle(VehicleModel vehicle) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/api/Vehicle/Create');

    final cookie = await SecureStorage.getCookie();
    if (cookie == null || cookie.isEmpty) {
      throw Exception('Unauthorized: No cookie found.');
    }

    final body = jsonEncode(vehicle.toJson());
    print("📤 REQUEST BODY: $body");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Cookie': cookie},
        body: body,
      );
      if (response.statusCode == 401 || response.statusCode == 403) {
        print("🔐 SESSION EXPIRED");
        Get.find<GlobalLogoutHandler>().forceLogout();
        return null;
      }
      print("📡 RESPONSE STATUS: ${response.statusCode}");
      print("📥 RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResp = jsonDecode(response.body);

        if (jsonResp['didError'] == false) {
          // 🔥 THIS IS YOUR VEHICLE ID
          return jsonResp['insertedId'] as int;
        }

        throw Exception(jsonResp['errorMessage'] ?? 'Unknown error');
      }

      throw Exception('Server error ${response.statusCode}');
    } catch (e) {
      print("🚨 VEHICLE CREATE EXCEPTION: $e");
      return null;
    }
  }
}
