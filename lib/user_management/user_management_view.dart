import 'package:emtrack/color/app_color.dart';
import 'package:emtrack/user_management/user_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserManagementView extends StatelessWidget {
  final c = Get.put(UserManagementController());
  UserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("User", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: BackButton(color: Colors.white),
      ),
      body: Stack(
        children: [
          Obx(
            () => Column(
              children: [
                _stepHeader(),
                Expanded(child: _stepBody()),
              ],
            ),
          ),

          Obx(() {
            if (!c.isLoading.value) return const SizedBox();

            return const Center(
              child: CircularProgressIndicator(color: AppColors.secondary),
            );
          }),
        ],
      ),
    );
  }

  Widget _stepHeader() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _stepCircle(0, "login info"),
          _stepCircle(1, "personal detail"),
          _stepCircle(2, "user preference"),
        ],
      ),
    );
  }

  Widget _stepCircle(int step, String title) {
    final bool isCompleted = step < c.currentStep.value;
    final bool isCurrent = step == c.currentStep.value;

    Color circleColor;
    Widget child;

    if (isCompleted) {
      circleColor = Colors.green;
      child = const Icon(Icons.check, color: Colors.white, size: 18);
    } else if (isCurrent) {
      circleColor = Colors.yellow.shade900;
      child = Text("${step + 1}", style: const TextStyle(color: Colors.white));
    } else {
      circleColor = Colors.grey;
      child = Text("${step + 1}", style: const TextStyle(color: Colors.white));
    }

    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: circleColor,
              child: child,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                color: isCompleted
                    ? Colors.green
                    : isCurrent
                    ? Colors.yellow.shade900
                    : Colors.grey,
              ),
            ),
          ],
        ),
        _arrow(step),
      ],
    );
  }

  Widget _stepBody() {
    switch (c.currentStep.value) {
      case 0:
        return _loginInfo();
      case 1:
        return _personalDetail();
      default:
        return _preferences();
    }
  }

  Widget _loginInfo() {
    return Form(
      key: c.loginFormKey,
      child: _form([
        _text(
          "Username",
          c.usernameC,
          validator: (v) {
            final usernameRegex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]{3,19}$');

            if (v == null || v.isEmpty) {
              return "Username required";
            }
            if (!usernameRegex.hasMatch(v)) {
              return "Invalid username";
            }
            return null;
          },
        ),

        _text(
          "Password",
          c.passwordC,
          obscure: true,
          validator: (v) {
            if (v == null || v.isEmpty) {
              return "Password required";
            }
            if (v.length < 6) {
              return "Min 6 characters";
            }
            return null;
          },
        ),

        _dropdown("User Role", c.roles, c.role),
      ]),
    );
  }

  Widget _personalDetail() {
    final nameRegex = RegExp(r'^[A-Za-z ]{2,}$');

    return Form(
      key: c.personalFormKey,
      child: _form([
        _text(
          "First Name",
          c.firstNameC,
          validator: (v) {
            if (!nameRegex.hasMatch(v ?? "")) {
              return "Invalid first name";
            }
            return null;
          },
        ),

        _text(
          "Email",
          c.emailC,
          validator: (v) {
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
            if (!emailRegex.hasMatch(v ?? "")) {
              return "Invalid email";
            }
            return null;
          },
        ),

        _text(
          "Middle Name",
          c.middleNameC,
          validator: (v) {
            if (v!.isNotEmpty && !nameRegex.hasMatch(v)) {
              return "Invalid middle name";
            }
            return null;
          },
        ),

        _text(
          "Phone",
          c.phoneC,
          validator: (v) {
            final phoneRegex = RegExp(r'^[6-9]\d{9}$');
            if (!phoneRegex.hasMatch(v ?? "")) {
              return "Invalid phone number";
            }
            return null;
          },
        ),

        _text(
          "Last Name",
          c.lastNameC,
          validator: (v) {
            if (!nameRegex.hasMatch(v ?? "")) {
              return "Invalid last name";
            }
            return null;
          },
        ),

        _dropdown("Country", c.countries, c.country),
      ]),
    );
  }

  Widget _preferences() {
    return Form(
      key: c.preferenceFormKey,
      child: _form([
        _dropdown("Language", c.languages, c.language),
        _dropdown("Measurement", c.measurements, c.measurement),
        _dropdown("Pressure Unit", c.pressureUnits, c.pressureUnit),
      ]),
    );
  }

  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          /// 🔹 PREVIOUS
          if (c.currentStep.value > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: c.previous,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(
                    color: Colors.red, // 🔴 border color
                    width: 1, // optional
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    // ✅ border radius 10
                  ),
                ),
                child: const Text(
                  "PREVIOUS",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),

          if (c.currentStep.value > 0) const SizedBox(width: 12),

          /// 🔹 NEXT / CREATE
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (c.formKey.currentState!.validate()) {
                  c.currentStep.value == 2 ? c.submit() : c.next();
                }
              },

              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // ✅ border radius 10
                ),
              ),
              child: Text(
                c.currentStep.value == 2 ? "CREATE" : "NEXT",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _form(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: c.formKey,
        child: ListView(
          children: [...children, const SizedBox(height: 10), _buttons()],
        ),
      ),
    );
  }

  Widget _text(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,

        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _dropdown(String label, List<String> items, RxString value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Obx(
        () => DropdownButtonFormField<String>(
          initialValue: value.value.isEmpty ? null : value.value,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),

          // ✅ VALIDATION
          validator: (v) {
            if (v == null || v.isEmpty) {
              return 'Please select one';
            }
            return null;
          },

          items: items
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),

          onChanged: (v) => value.value = v ?? '',
        ),
      ),
    );
  }

  Widget _arrow(int step) {
    if (step == c.totalSteps - 1) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: step < c.currentStep.value ? Colors.green : Colors.grey,
      ),
    );
  }
}
