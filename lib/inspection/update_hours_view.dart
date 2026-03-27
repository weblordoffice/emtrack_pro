import 'package:emtrack/color/app_color.dart';
import 'package:emtrack/controllers/selected_account_controller.dart';
import 'package:emtrack/controllers/update_hours_controller.dart';
import 'package:emtrack/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateHoursView extends StatelessWidget {
  UpdateHoursView({super.key});
<<<<<<< HEAD

  final UpdateHoursController updatectrl = Get.put(UpdateHoursController());
  final SelectedAccountController selectedCtrl =
  Get.put(SelectedAccountController());
=======
  final updatectrl = Get.put(UpdateHoursController());
  final UpdateHoursController updatectrl1 = Get.find<UpdateHoursController>();

  final selectedCtrl = Get.put(SelectedAccountController());
>>>>>>> pratyush

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: Colors.white,
=======
>>>>>>> pratyush
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Update Hours",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
<<<<<<< HEAD
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // ─── Selected Account ───
            _label("Selected Parent Account"),
            const SizedBox(height: 4),
            Obx(
                  () => Text(
=======
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _label("Selected parent account"),
              Text(
>>>>>>> pratyush
                "${selectedCtrl.parentAccountName.value} - ${selectedCtrl.locationName.value}",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
<<<<<<< HEAD
            ),

            const SizedBox(height: 20),

            // ─── Vehicle ID ───
            _label("Vehicle ID"),
            const SizedBox(height: 4),
            Obx(
                  () => Text(
                updatectrl.vehicleNumber.value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ─── Last Recorded Date ───
            _label("Last Recorded Date"),
            const SizedBox(height: 10),
            // ✅ FIX: Shows formatted dd/MM/yyyy via formatDate()
            Obx(() => _disabledField(updatectrl.lastRecordedDate.value)),

            const SizedBox(height: 20),

            // ─── Survey Date ───
            _requiredLabel("Survey Date"),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => updatectrl.pickSurveyDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: updatectrl.surveyDateController,
                  decoration: InputDecoration(
                    hintText: "Select Date",
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      color: Colors.red,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
=======
              const SizedBox(height: 20),
              _label("Vehicle ID"),
              Obx(
                () => Text(
                  //    updatectrl.vehicleId.toString(),
                  updatectrl.vehicleNumber.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              _label("Last Recorded Date"),
              const SizedBox(height: 10),
              Obx(() => _disabledField(updatectrl.lastRecordedDate.toString())),
              const SizedBox(height: 20),
              _requiredLabel("Survey Date"),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => updatectrl.pickSurveyDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: updatectrl.surveyDateController,

                    decoration: InputDecoration(
                      hintText: "Select Date",
                      suffixIcon: const Icon(
                        Icons.calendar_month,
                        color: Colors.red,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade50,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _label("Last Recorded Hours"),
              const SizedBox(height: 10),
              _disabledField(
                updatectrl.lastRecordedHours.value.toStringAsFixed(2),
              ),
              const SizedBox(height: 20),
              _requiredLabel("Update hours"),
              const SizedBox(height: 10),
              Obx(
                () => TextField(
                  controller: updatectrl1.updateHoursController,
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    (v) {
                      updatectrl.updateHoursError.value = updatectrl
                          .validateHours();
                    };
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Hours",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade50,
                        width: 1,
                      ),
                    ),
                    errorText: updatectrl.updateHoursError.value,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Obx(
                () => Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.buttonDanger,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: updatectrl.loading.value
                        ? null
                        : () {
                            final err = updatectrl.validateHours();
                            updatectrl.updateHoursError.value = err;

                            if (err != null) return;
                            FocusManager.instance.primaryFocus?.unfocus();

                            AppDialog.showConfirmDialog(
                              title: 'Change Tire Details',
                              message:
                                  'These changes will impact tire hours. \n Do you wish to proceed?',
                              okText: 'Proceed',
                              cancelText: 'Cancel',

                              onOk: () {
                                updatectrl.submitUpdateHours();
                              },
                            );
                            //  _showConfirmDialog(context);
                          },
                    child: Center(
                      child: updatectrl.loading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Update",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
>>>>>>> pratyush
                    ),
                  ),
                ),
              ),
<<<<<<< HEAD
            ),

            const SizedBox(height: 20),

            // ─── Last Recorded Hours ───
            _label("Last Recorded Hours"),
            const SizedBox(height: 10),
            Obx(
                  () => _disabledField(
                updatectrl.lastRecordedHours.value.toStringAsFixed(2),
              ),
            ),

            const SizedBox(height: 20),

            // ─── Update Hours ───
            _requiredLabel("Update Hours"),
            const SizedBox(height: 10),
            Obx(
                  () => TextField(
                controller: updatectrl.updateHoursController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                // ✅ FIX: onChanged now correctly calls validateHours
                onChanged: (v) {
                  updatectrl.updateHoursError.value =
                      updatectrl.validateHours();
                },
                decoration: InputDecoration(
                  hintText: "Enter Hours",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Colors.black, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  errorText: updatectrl.updateHoursError.value,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ─── Update Button ───
            Obx(
                  () => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonDanger,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: updatectrl.loading.value
                      ? null
                      : () {
                    final err = updatectrl.validateHours();
                    updatectrl.updateHoursError.value = err;
                    if (err != null) return;

                    FocusManager.instance.primaryFocus?.unfocus();

                    AppDialog.showConfirmDialog(
                      title: 'Change Tire Details',
                      message:
                      'These changes will impact tire hours.\nDo you wish to proceed?',
                      okText: 'Proceed',
                      cancelText: 'Cancel',
                      onOk: () {
                        updatectrl.submitUpdateHours();
                      },
                    );
                  },
                  child: updatectrl.loading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
=======

              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
>>>>>>> pratyush
                    ),
                  ),
                ),
              ),
<<<<<<< HEAD
            ),

            const SizedBox(height: 16),

            // ─── Cancel ───
            Center(
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
=======
            ],
          ),
>>>>>>> pratyush
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _label(String text) => Text(
    text,
    style: const TextStyle(color: Colors.black54, fontSize: 13),
  );
=======
  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Center(
            child: Text(
              "Change Tire Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: const Text(
            "These changes will impact tire hours.\nDo you wish to proceed?",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel", style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                /// 🔥 Call your API here
                updatectrl.submitUpdateHours();
              },
              child: const Text(
                "Proceed",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _label(String text) =>
      Text(text, style: const TextStyle(color: Colors.black54));
>>>>>>> pratyush

  Widget _requiredLabel(String text) => RichText(
    text: TextSpan(
      text: text,
<<<<<<< HEAD
      style: const TextStyle(color: Colors.black, fontSize: 13),
=======
      style: const TextStyle(color: Colors.black),
>>>>>>> pratyush
      children: const [
        TextSpan(
          text: " *",
          style: TextStyle(color: Colors.red),
        ),
      ],
    ),
  );

<<<<<<< HEAD
=======
  //   bool validateHours() {
  //   double lastHours = updatectrl.lastRecordedHours.value;

  //   double enteredHours =
  //       double.tryParse(updatectrl1.updateHoursController.text) ?? 0;

  //   if (enteredHours <= lastHours) {
  //     Get.snackbar(
  //       "Validation",
  //       "Please enter a value greater than last recorded hours",
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     return false;
  //   }

  //   return true;
  // }

>>>>>>> pratyush
  Widget _disabledField([String? value]) => Container(
    height: 48,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(6),
<<<<<<< HEAD
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Text(
      value ?? "",
      style: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
=======
    ),
    child: Row(
      children: [
        Text(value ?? "", style: const TextStyle(color: Colors.black54)),
      ],
    ),
  );
}
>>>>>>> pratyush
