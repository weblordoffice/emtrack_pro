import 'package:emtrack/models/grand_parent_account_model/assign_grand_parent_model.dart';
import 'package:emtrack/models/grand_parent_account_model/grand_parent_account_model.dart';
import 'package:emtrack/routes/app_pages.dart';
import 'package:emtrack/services/grand_parent_account_service/grand_parent_account_service.dart';
import 'package:emtrack/utils/secure_storage.dart';
import 'package:get/get.dart';

class GrandparentAccountController extends GetxController {
  final service = GrandparentAccountService();

  /// Stepper
  RxInt currentStep = 0.obs;
  final int totalSteps = 2;

  /// Step-1 fields
  RxString accountType = 'OWNED'.obs;
  RxString grandparentName = ''.obs;

  /// Step-2 dropdown selections
  RxInt selectedParentId = 0.obs;
  RxInt selectedGrandparentId = 0.obs;

  /// Dummy dropdown data (API se ayega)
  RxList<Map<String, dynamic>> parentAccounts = [
    {"id": 10768, "name": "05 CBA (Cre Rians)"},
  ].obs;

  RxList<Map<String, dynamic>> grandparentAccounts = [
    {"id": 4, "name": "EMTTST_ADMIN Accounts"},
  ].obs;

  /// Navigation
  void next() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    }
  }



  void previous() {
    if (currentStep.value > 0) {
      currentStep.value--;
      grandparentName.value = '';
    }
  }

  /// Submit Step-1
  Future<void> createGrandparent() async {
    final userName = await SecureStorage.getUserName();

    final model = GrandparentAccountModel(
      createdBy: userName.toString(),
      createdDate: DateTime.now().toIso8601String(),
      grandParentAccountName: grandparentName.value,
      isActive: true,
      ownedBy: accountType.value,
      updatedBy: userName.toString(),
      updatedDate: DateTime.now().toIso8601String(),
    );

    final isCreated = await service.createGrandparent(model);
    if (isCreated) {
      next();
    }
  }

  /// Submit Step-2
  Future<void> assignGrandparent() async {
    final model = AssignGrandparentModel(
      userId: selectedParentId.value,
      parentAccountId: selectedParentId.value,
      grandparentAccountId: selectedGrandparentId.value,
    );

    final data = await service.assignGrandparent(model);
    if (data) {
      Get.to(AppPages.HOME);
    }
  }
}
