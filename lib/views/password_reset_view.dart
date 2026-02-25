import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/password_reset_controller.dart';

class PasswordResetView extends StatelessWidget {
  PasswordResetView({super.key});

  final PasswordResetController controller = Get.put(PasswordResetController());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.red),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 🔥 black background
      appBar: AppBar(
        title: const Text(
          "Password Reset",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Reset Your Password",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 25),

                  /// Username
                  TextFormField(
                    controller: usernameController,
                    decoration: inputDecoration("Username"),
                  ),
                  const SizedBox(height: 15),

                  /// Old Password
                  TextFormField(
                    controller: oldPasswordController,
                    obscureText: true,
                    decoration: inputDecoration("Old Password"),
                  ),
                  const SizedBox(height: 15),

                  /// New Password
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: inputDecoration("New Password"),
                  ),
                  const SizedBox(height: 25),

                  /// Button
                  Obx(
                    () => controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.red)
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                controller.resetPassword(
                                  usernameController.text.trim(),
                                  oldPasswordController.text.trim(),
                                  newPasswordController.text.trim(),
                                );
                              },
                              child: const Text(
                                "Reset Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
