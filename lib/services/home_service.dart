import 'dart:convert';
import 'package:emtrack/models/statical_model.dart';
import 'package:emtrack/services/api_constants.dart';
import 'package:emtrack/services/api_service.dart';
import 'package:emtrack/services/global_logout_handler.dart';
import 'package:emtrack/utils/secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/home_model.dart';

class HomeService {
  /// Fetch dashboard / home data. Send auth token as Bearer.
  static Future<HomeModel?> fetchHomeData() async {
    try {
      final cookie = await SecureStorage.getCookie();

      if (cookie == null || cookie.isEmpty) {
        throw Exception("Session expired. Please login again.");
      }

      final uri = Uri.parse("${ApiConstants.baseUrl}/dashboard");

      print("🔍 DASHBOARD API: $uri");

      final resp = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Cookie": cookie, // ✅ COOKIE AUTH
        },
      );

      print("🔍 DASHBOARD STATUS => ${resp.statusCode}");
      print("🔍 DASHBOARD BODY => ${resp.body}");

      if (resp.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(resp.body);
        final payload = data['data'] ?? data;
        print("🔍 DASHBOARD PAYLOAD => $payload");
        return HomeModel.fromJson(payload as Map<String, dynamic>);
      }

      if (resp.statusCode == 401 || resp.statusCode == 403) {
        await SecureStorage.clearCookie();
        print("🔐 SESSION EXPIRED");
        Get.find<GlobalLogoutHandler>().forceLogout();
        return null;
      }

      return null;
    } catch (e) {
      print('HomeService.fetchHomeData error: $e');
      return null;
    }
  }

  /// optional sync endpoint
  static Future<bool> syncInspections() async {
    try {
      final cookie = await SecureStorage.getCookie();

      if (cookie == null || cookie.isEmpty) {
        throw Exception("Session expired. Please login again.");
      }

      final uri = Uri.parse("${ApiConstants.baseUrl}/inspections/sync");

      final resp = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Cookie": cookie, // ✅ COOKIE AUTH
        },
      );

      print("SYNC STATUS => ${resp.statusCode}");
      print("SYNC BODY => ${resp.body}");

      if (resp.statusCode == 200) {
        return true;
      }

      if (resp.statusCode == 401 || resp.statusCode == 403) {
        await SecureStorage.clearCookie();
        print("🔐 SESSION EXPIRED");
        Get.find<GlobalLogoutHandler>().forceLogout();
        return syncInspections();
      }

      return false;
    } catch (e) {
      print('HomeService.syncInspections error: $e');
      return false;
    }
  }

  static Future<int> fetchTyreCountByAccount(String parentAccountId) async {
    try {
      final cookie = await SecureStorage.getCookie();

      if (cookie == null) return 0;

      final uri = Uri.parse(
        "${ApiConstants.baseUrl}/api/Tire/GetTiresByAccount/$parentAccountId",
      );

      print("🔍 TYRE COUNT API: $uri");
      print("🔍 PARENT ACCOUNT ID: $parentAccountId");

      final resp = await http.get(
        uri,
        headers: {"Content-Type": "application/json", "Cookie": cookie},
      );
      if (resp.statusCode == 401 || resp.statusCode == 403) {
        await SecureStorage.clearCookie();
        print("🔐 SESSION EXPIRED");
        Get.find<GlobalLogoutHandler>().forceLogout();
        return fetchTyreCountByAccount(parentAccountId);
      }
      if (resp.statusCode == 200) {
        final json = jsonDecode(resp.body);
        final List list = json['model'] ?? [];
        print("🔍 TYRE COUNT RESPONSE: ${list.length} tires");
        print("🔍 TYRE RESPONSE BODY: ${resp.body}");
        return list.length; // ✅ TOTAL TYRES
      } else {
        print("Tyre API error ${resp.statusCode}");
        print("Tyre API response: ${resp.body}");
        return 0;
      }
    } catch (e) {
      print("Tyre API exception $e");
      return 0;
    }
  }

  static Future<int> fetchVehicleCountByAccount(String parentAccountId) async {
    try {
      final cookie = await SecureStorage.getCookie();
      if (cookie == null || cookie.isEmpty) return 0;

      // 🔥 Important: double timestamp
      final double timeStamp = 0.0;

      final uri = Uri.parse(
        "${ApiConstants.baseUrl}"
        "/api/Vehicle/GetVehicleByUser/"
        "$parentAccountId/$timeStamp" // ✅ path timestamp
        "?timeStamp=$timeStamp", // ✅ query timestamp
      );

      print("🔍 VEHICLE COUNT API: $uri");
      print("🔍 PARENT ACCOUNT ID: $parentAccountId");

      final resp = await http.get(
        uri,
        headers: {"Accept": "application/json", "Cookie": cookie},
      );

      print("📡 VEHICLE STATUS => ${resp.statusCode}");
      print("📦 VEHICLE BODY => ${resp.body}");

      if (resp.statusCode == 200) {
        final json = jsonDecode(resp.body);

        if (json['didError'] == true) {
          print("Backend Error => ${json['errorMessage']}");
          return 0;
        }

        final List list = json['model'] ?? [];
        print("🔍 VEHICLE COUNT RESPONSE: ${list.length} vehicles");
        return list.length;
      }

      print("❌ Vehicle API error ${resp.statusCode}");
      print("❌ Vehicle API response: ${resp.body}");
      return 0;
    } catch (e) {
      print("🔥 Vehicle API exception => $e");
      return 0;
    }
  }

  static Future<DashboardModel?> fetchReportDashboardHomeData() async {
    print("🔍 HOME SERVICE: fetchReportDashboardHomeData started!");
    final parentAccountId = await SecureStorage.getParentAccountId();
    final getLocationId = await SecureStorage.getLocationId();

    print("🔍 DASHBOARD REPORT API - Parent Account ID: $parentAccountId");
    print("🔍 DASHBOARD REPORT API - Location ID: $getLocationId");

    try {
      final cookie = await SecureStorage.getCookie();
      print("🔍 DASHBOARD REPORT API - Cookie: ${cookie?.substring(0, 20)}...");

      if (cookie == null || cookie.isEmpty) {
        print("🔍 DASHBOARD REPORT API - No cookie found!");
        throw Exception("Session expired. Please login again.");
      }

      print("🔍 DASHBOARD REPORT API - Making POST request...");
      final resp = await ApiService.postApi(
        endpoint: "/api/Report/GetReportDashboardData",
        body: {"accountIds": parentAccountId, "locationIds": getLocationId},
      );

      print("🔍 DASHBOARD REPORT RESPONSE: $resp");

      if (resp['model'] != null) {
        final model = resp["model"];
        print("🔍 DASHBOARD MODEL: $model");
        print("🔍 DASHBOARD MODEL FIELDS:");
        print("  - scrapTireCount: ${model['scrapTireCount']}");
        print("  - tiresInServiceCount: ${model['tiresInServiceCount']}");
        print("  - tiresInInventoryCount: ${model['tiresInInventoryCount']}");
        print("  - vehicleCount: ${model['vehicleCount']}");
        print("  - totalTiresCount: ${model['totalTiresCount']}");

        final dashboardModel = DashboardModel.fromJson(model);
        print(
          "🔍 PARSED DASHBOARD - Total Tires: ${dashboardModel.totalTiresCount}, Vehicles: ${dashboardModel.vehicleCount}",
        );
        return dashboardModel;
      } else {
        print("🔍 DASHBOARD REPORT API - No model in response!");
      }

      if (resp.statusCode == 401 || resp.statusCode == 403) {
        await SecureStorage.clearCookie();
        print("🔐 SESSION EXPIRED");
        Get.find<GlobalLogoutHandler>().forceLogout();
        return null;
      }

      return null;
    } catch (e) {
      print('HomeService.fetchReportDashboardHomeData error: $e');
      return null;
    }
  }
}
