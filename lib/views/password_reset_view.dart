import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/password_reset_controller.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final c = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            stepHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => c.currentStep.value == 0 ? _stepOne() : _stepTwo(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= STEP 1 =================

  Widget _stepOne() {
    return Form(
      key: c.formKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "For security purposes, please input your username and password to proceed.",
          ),
          const SizedBox(height: 20),

          TextFormField(
            controller: c.usernameController,
            decoration: const InputDecoration(
              labelText: "Username",
              border: OutlineInputBorder(),
            ),
            validator: (v) => v == null || v.isEmpty ? "Enter username" : null,
          ),

          const SizedBox(height: 15),

          TextFormField(
            controller: c.passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password (optional)",
              border: OutlineInputBorder(),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: Get.back,
                child: const Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: c.sendtokenPassword,
                child: const Text("SUBMIT"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= STEP 2 =================

  Widget _stepTwo() {
    return Form(
      key: c.formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "A unique token has been sent to your email. Please enter it below:",
          ),
          const SizedBox(height: 20),

          TextFormField(
            controller: c.tokenController,
            decoration: const InputDecoration(
              labelText: "Token Code",
              border: OutlineInputBorder(),
            ),
            validator: (v) => v == null || v.isEmpty ? "Enter token" : null,
          ),

          const SizedBox(height: 20),

          const Text(
            "Password must be at least 6 characters with uppercase, lowercase and special character.",
            style: TextStyle(fontSize: 13),
          ),

          const SizedBox(height: 15),

          TextFormField(
            controller: c.newPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "New Password",
              border: OutlineInputBorder(),
            ),
            validator: (v) {
              if (v == null || v.length < 6) {
                return "Minimum 6 characters";
              }
              return null;
            },
          ),

          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: c.goBack,
                child: const Text("BACK", style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                onPressed: c.resetPassword,
                child: const Text("RESET PASSWORD"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget stepHeader() {
    final c = Get.find<ResetPasswordController>();

    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            _stepCircle(0, "Verify Account", c),
            _stepLine(0, c),
            _stepCircle(1, "Reset Password", c),
          ],
        ),
      ),
    );
  }

  Widget _stepCircle(int step, String title, ResetPasswordController c) {
    bool isActive = c.currentStep.value == step;
    bool isCompleted = c.currentStep.value > step;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted
                  ? Colors.green
                  : isActive
                  ? Colors.blue
                  : Colors.grey.shade300,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : Text(
                      "${step + 1}",
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepLine(int step, ResetPasswordController c) {
    return Expanded(
      child: Container(
        height: 2,
        color: c.currentStep.value > step ? Colors.green : Colors.grey.shade300,
      ),
    );
  }
}
