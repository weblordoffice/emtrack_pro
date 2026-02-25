import 'dart:convert';
import 'package:emtrack/edit_tyre/edit_tyre_model.dart';
import 'package:emtrack/services/api_constants.dart';
import 'package:emtrack/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

class EditTyreService {
  // ================= UPDATE TYRE =================
  static Future<void> updateTyre(EditTyreModel model) async {
    try {
      final cookie = await SecureStorage.getCookie();

      if (cookie == null || cookie.isEmpty) {
        throw Exception("Session expired. Please login again.");
      }

      final url = "${ApiConstants.baseUrl}/api/Tire";
      print("🟢 UPDATE API => $url");
      //final body = model.toJson();
      // ✅ Step 1: Convert to Map
      final Map<String, dynamic> bodyMap = model.toJson();

      // ✅ Step 2: Remove unwanted fields
      bodyMap.remove("tireId");
      bodyMap.remove("vehicleId");
      bodyMap.remove("mountedRimId");

      // ✅ Step 3: Encode after removing
      final body = jsonEncode(bodyMap);

      print("🟡 REQUEST BODY => $body");

      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Cookie": cookie,
        },
        body: body,
      );

      print("🔵 STATUS => ${response.statusCode}");
      print("🔵 BODY => ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      }

      if (response.statusCode == 401) {
        await SecureStorage.clearCookie();
        throw Exception("Session expired. Please login again.");
      }

      throw Exception("Failed to update tyre");
    } catch (e) {
      print("🔴 UPDATE ERROR => $e");
      rethrow;
    }
  }

  // ================= GET BY ID (already working) =================
  static Future<EditTyreModel> getTyreById(int tireId) async {
    final cookie = await SecureStorage.getCookie();

    final url = "${ApiConstants.baseUrl}/api/Tire/GetById/$tireId";

    print("🟢 GET Tyre URL => $url"); // 🔹 Debug URL

    final response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json", "Cookie": cookie!},
    );

    print("🟡 RESPONSE STATUS => ${response.statusCode}"); // 🔹 HTTP status
    print("🟡 RESPONSE BODY => ${response.body}"); // 🔹 Full response

    final decoded = jsonDecode(response.body);
    print("🔵 DECODED JSON => $decoded"); // 🔹 decoded map

    final modelJson = decoded['model'];
    print("🔵 MODEL JSON => $modelJson"); // 🔹 sirf model part

    final tyreModel = EditTyreModel.fromJson(modelJson);
    print(
      "🔵 TyreModel after fromJson => ${tyreModel.toJson()}",
    ); // 🔹 final model check

    return tyreModel;
  }
}
