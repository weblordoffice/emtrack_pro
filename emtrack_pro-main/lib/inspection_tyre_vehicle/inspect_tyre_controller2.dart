import 'package:yokohama_emtrack/models/inspect_tyre_model.dart';
import 'package:yokohama_emtrack/services/inspect_tyre_service.dart';
import 'package:yokohama_emtrack/views/remove_tyre_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InspectTyreController2 extends GetxController {
  final service = InspectTyreService();
  final picker = ImagePicker();
  final RxBool isHot = false.obs;
  Rx<InspectTyreModel> model = InspectTyreModel().obs;

  // 🔹 Counters
  void incAir() => model.update((m) {
    m!.airPressure = (m.airPressure ?? 0) + 1;
  });

  void decAir() => model.update((m) {
    m!.airPressure = ((m.airPressure ?? 0) - 1).clamp(0, 999);
  });

  // 🔹 Outside Tread
  void incOutside() => model.update((m) {
    m!.outsideTread++;
    _calcAverage(m);
  });

  void decOutside() => model.update((m) {
    if (m!.outsideTread > 0) m.outsideTread--;
    _calcAverage(m);
  });

  // 🔹 Inside Tread
  void incInside() => model.update((m) {
    m!.insideTread++;
    _calcAverage(m);
  });

  void decInside() => model.update((m) {
    if (m!.insideTread > 0) m.insideTread--;
    _calcAverage(m);
  });
  // 🧮 Average Calculation
  void _calcAverage(InspectTyreModel m) {
    m.averageTread = ((m.outsideTread + m.insideTread) / 2).toStringAsFixed(2);
  }

  // 📷 Upload Image
  Future<void> pickImage(ImageSource source) async {
    final img = await picker.pickImage(source: source);
    if (img != null) {
      model.update((m) => m!.images.add(img.path));
    }
  }

  // ❌ Remove Tyre
  void removeTyre() {
    model.value = InspectTyreModel();
    Get.to(() => RemoveTyreView());
  }

  // ✅ Submit
  Future<void> submit() async {
    await service.submitInspection({
      "airPressure": model.value.airPressure,
      "outsideTread": model.value.outsideTread,
      "insideTread": model.value.insideTread,
      "comments": model.value.comments,
      "images": model.value.images,
    });

    Get.snackbar("Success", "Inspection Submitted");
  }
}
