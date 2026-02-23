import 'package:emtrack/user_management/user_management_model.dart';
import 'package:emtrack/user_management/user_management_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserManagementController extends GetxController {
  final _service = UserManagementService();

  /// Stepper
  RxInt currentStep = 0.obs;
  final int totalSteps = 3;

  /// 🔹 Form Keys
  final formKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final personalFormKey = GlobalKey<FormState>();
  final preferenceFormKey = GlobalKey<FormState>();

  /// 🔹 Text Controllers (DATA SAFE RAHEGA)
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  final firstNameC = TextEditingController();
  final middleNameC = TextEditingController();
  final lastNameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();

  /// Login Info
  RxString username = ''.obs;
  RxString password = ''.obs;
  RxString role = ''.obs;

  /// Personal Details
  RxString firstName = ''.obs;
  RxString middleName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString country = ''.obs;

  /// Preferences
  RxString language = ''.obs;
  RxString measurement = ''.obs;
  RxString pressureUnit = ''.obs;

  /// Dropdown Data
  List<String> roles = ['Admin', 'User'];
  List<String> countries = ['India', 'USA'];
  List<String> languages = ['English', 'Hindi'];
  List<String> measurements = ['Metric', 'Imperial'];
  List<String> pressureUnits = ['PSI', 'BAR'];

  /// Navigation
  void next() {
    if (currentStep.value == 0 && loginFormKey.currentState!.validate()) {
      currentStep.value++;
    } else if (currentStep.value == 1 &&
        personalFormKey.currentState!.validate()) {
      currentStep.value++;
    }
  }

  void previous() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  /// Submit
  Future<void> submit() async {
    final formState = preferenceFormKey.currentState;

    if (formState == null) {
      Get.snackbar("Error", "Form not ready");
      return;
    }

    if (!formState.validate()) return;

    final model = UserManagementModel(
      username: username.value,
      password: password.value,
      role: role.value,
      firstName: firstName.value,
      middleName: middleName.value,
      lastName: lastName.value,
      email: email.value,
      phone: phone.value,
      country: country.value,
      language: language.value,
      measurement: measurement.value,
      pressureUnit: pressureUnit.value,
    );

    await _service.registerUser(model);

    Get.snackbar("Success", "User Created Successfully");
  }

  @override
  void onClose() {
    usernameC.dispose();
    passwordC.dispose();
    firstNameC.dispose();
    middleNameC.dispose();
    lastNameC.dispose();
    emailC.dispose();
    phoneC.dispose();
    super.onClose();
  }
}
