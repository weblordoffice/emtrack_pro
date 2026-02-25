import 'dart:convert';
import 'package:emtrack/models/password_reset_model.dart';
import 'package:emtrack/services/password_reset_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordResetController extends GetxController {
  final PasswordResetService _apiService = PasswordResetService();

  var isLoading = false.obs;
  var message = "".obs;

  Future<void> resetPassword(
    String username,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      isLoading.value = true;

      PasswordResetModel model = PasswordResetModel(
        username: username,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      final response = await _apiService.resetPassword(model);

      if (response.statusCode == 200) {
        message.value = "Password Reset Successfully";
        Get.back();
        Get.snackbar(
          "Success",
          message.value,
          backgroundColor: Colors.white,
          colorText: Colors.black,
        );
      } else {
        final error = jsonDecode(response.body);
        message.value = error.toString();
        Get.snackbar("Error", message.value);
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
