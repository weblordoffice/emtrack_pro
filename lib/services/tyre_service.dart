import 'dart:convert';
import 'package:emtrack/models/tyre_model.dart';
import 'package:emtrack/models/tyre_responsive_model.dart';
import 'package:emtrack/services/api_constants.dart';
import 'package:emtrack/services/global_logout_handler.dart';
import 'package:emtrack/utils/secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TyreService {
  // 🔹 GET BY ID URL
  static String get _getByIdUrl =>
      "${ApiConstants.baseUrl + ApiConstants.getTyresByAccount}/";

  /// Fetch tyre by ID
  Future<List<TyreModel>> getTyresByAccount(int accountId) async {
    try {
      print("🔥 TyreService.getTyreById called with ID: $accountId");

      // ✅ Read cookie
      final cookie = await SecureStorage.getCookie();
      if (cookie == null || cookie.isEmpty) {
        print("⚠️ Cookie not found or empty");
        throw Exception("Session expired. Please login again.");
      }
      print("📦 Using cookie: $cookie");

      // ✅ Prepare URL
      final url = Uri.parse("$_getByIdUrl$accountId");
      print("🌐 Request URL: $url");

      // ✅ Send GET request
      final response = await http.get(
        url,
        headers: {"Accept": "application/json", "Cookie": cookie},
      );

      print("STATUS => ${response.statusCode}");
      print("BODY => ${response.body}");

      // ✅ Success
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        // 🔹 Parse response into model
        final tyreResponse = TyreResponseModel.fromJson(decoded);
        print("Decoded TyreResponseModel: $tyreResponse");

        // 🔹 Check API-level error
        if (tyreResponse.didError) {
          print("❌ API Error: ${tyreResponse.errorMessage}");
          throw Exception(tyreResponse.errorMessage ?? "API returned an error");
        }

        print(
          "✅ Tyres fetched successfully, count: ${tyreResponse.model.length}",
        );
        return tyreResponse.model;
      }

      // ✅ Unauthorized
      if (response.statusCode == 401 || response.statusCode == 403) {
        print("⚠️ Unauthorized access");
        print("🔐 SESSION EXPIRED");
        Get.find<GlobalLogoutHandler>().forceLogout();
        return [];
      }

      // ✅ Other errors
      print("❌ Failed to fetch tyre: ${response.statusCode}");
      throw Exception(
        "Failed to fetch tyre: ${response.statusCode} => ${response.body}",
      );
    } catch (e, stacktrace) {
      // ✅ Catch all exceptions and print stacktrace for debugging
      print("🔥 Exception in TyreService.getTyreById:");
      print(e);
      print(stacktrace);
      rethrow; // Propagate exception to caller
    }
  }
}
