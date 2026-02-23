import 'package:emtrack/color/app_color.dart';
import 'package:emtrack/controllers/selected_account_controller.dart';
import 'package:emtrack/controllers/update_hours_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateHoursView extends StatelessWidget {
  UpdateHoursView({super.key});
  final updatectrl = Get.put(UpdateHoursController());
  final UpdateHoursController updatectrl1 = Get.find<UpdateHoursController>();

  final selectedCtrl = Get.put(SelectedAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _label("Selected parent account"),
              Text(
                "${selectedCtrl.parentAccountName.value} - ${selectedCtrl.locationName.value}",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              _label("Vehicle ID"),
              Obx(
                () => Text(
                  updatectrl.vehicleId.toString(),
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
              TextField(
                controller: updatectrl1.updateHoursController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Hours",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade50,
                      width: 1,
                    ),
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
                            updatectrl.submitUpdateHours();
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
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) =>
      Text(text, style: const TextStyle(color: Colors.black54));

  Widget _requiredLabel(String text) => RichText(
    text: TextSpan(
      text: text,
      style: const TextStyle(color: Colors.black),
      children: const [
        TextSpan(
          text: " *",
          style: TextStyle(color: Colors.red),
        ),
      ],
    ),
  );

  Widget _disabledField([String? value]) => Container(
    height: 48,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Text(value ?? "", style: const TextStyle(color: Colors.black54)),
      ],
    ),
  );
}
