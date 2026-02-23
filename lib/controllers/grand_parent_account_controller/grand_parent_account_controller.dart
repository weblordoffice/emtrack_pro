import 'package:emtrack/models/grand_parent_account_model/assign_grand_parent_model.dart';
import 'package:emtrack/models/grand_parent_account_model/grand_parent_account_model.dart';
import 'package:emtrack/services/grand_parent_account_service/grand_parent_account_service.dart';
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
    }
  }

  /// Submit Step-1
  Future<void> createGrandparent() async {
    final model = GrandparentAccountModel(
      accountType: accountType.value,
      grandparentName: grandparentName.value,
    );

    await service.createGrandparent(model);
    next();
  }

  /// Submit Step-2
  Future<void> assignGrandparent() async {
    final model = AssignGrandparentModel(
      parentAccountId: selectedParentId.value,
      grandparentAccountId: selectedGrandparentId.value,
    );

    await service.assignGrandparent(model);
    Get.snackbar("Success", "Grandparent Assigned Successfully");
  }
}
