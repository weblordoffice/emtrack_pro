import 'package:yokohama_emtrack/color/app_color.dart';
import 'package:yokohama_emtrack/controllers/all_vehicles_controller.dart';
import 'package:yokohama_emtrack/inspection/vehicle_inspe_view.dart';
import 'package:yokohama_emtrack/views/create_vehicle_view.dart';
import 'package:yokohama_emtrack/views/Edit_vehicle.dart';
import 'package:yokohama_emtrack/views/vehicle_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllVehicleListView extends StatelessWidget {
  AllVehicleListView({super.key});

  final controller = Get.put(AllVehicleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Vehicles'), centerTitle: true),
      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: controller.onSearch,
              decoration: InputDecoration(
                hintText: 'Filter Vehicles',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () => _openFilterBottomSheet(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
              ),
            ),
          ),

          // 📋 LIST
          Expanded(
            child: Obx(() {
              // 🔴 NO DATA CASE
              if (controller.filteredList.isEmpty &&
                  controller.isFilterApplied.value) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 50, color: Colors.red),
                      SizedBox(height: 8),
                      Text('No data available'),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.filteredList.length,
                itemBuilder: (context, index) {
                  final vehicle = controller.filteredList[index];
                  return _vehicleCard(vehicle);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Material(
        color: Colors.transparent,
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => Get.to(() => CreateVehicleView()),
          borderRadius: BorderRadius.circular(24),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              'assets/svgImage/CreateVehicle.svg',
              height: 56,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  // 🚘 VEHICLE CARD (always show a default vehicle icon)
  Widget _buildVehicleImage(String? imageUrl) {
    // `assetNumber` is not a URL; it’s just an identifier.
    // Use the bundled PNG so we don’t run into Svg parsing/asset lookup issues.
    return Image.asset(
      'assets/images/IMG_Default.png',
      height: 80,
      width: 80,
      fit: BoxFit.contain,
    );
  }

  Widget _vehicleCard(vehicle) {
    return GestureDetector(
      onTap: () => _openActionBottomSheet(vehicle),
      child: Card(
        color: Colors.red.shade50.withOpacity(0.8),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.red, // border color
            width: 1, // border width
          ),

          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${vehicle.vehicleNumber ?? ''}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          Text("Make: ${vehicle.manufacturerName} "),
                          // Text(
                          //   vehicle.manufacturer ?? "",
                          //   style: TextStyle(
                          //     color: AppColors.primary,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Model: "),
                          Text(
                            vehicle.modelName ?? "",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Axel: "),
                          Text(
                            " ${vehicle.axleConfig ?? 0}",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Vehicle image: use URL if valid, else default SVG (no "Icon Unavailable")
                  _buildVehicleImage(vehicle.assetNumber),
                ],
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  vehicle.typeName ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ⬇️ CARD ACTION BOTTOM SHEET
  void _openActionBottomSheet(dynamic vehicle) {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Center(
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => VehicleInspeView(),
                    arguments: vehicle.vehicleId,
                  );
                },
                child: Text('Inspect', style: TextStyle(color: Colors.red)),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Center(
              child: InkWell(
                onTap: () {
                  Get.to(() => VehicleView(), arguments: vehicle.vehicleId);
                },
                child: Text('View', style: TextStyle(color: Colors.red)),
              ),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Get.to(() => UpdateVehicleView(), arguments: vehicle.vehicleId);
            },
            title: Center(
              child: Text('Edit', style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  void _openFilterBottomSheet() {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// 🔽 TYPE DROPDOWN
            Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Type:"),
                  SizedBox(height: 11),
                  DropdownButtonFormField<String>(
                    initialValue: controller.selectedType.value.isEmpty
                        ? null
                        : controller.selectedType.value,
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      border: OutlineInputBorder(),
                    ),
                    items: ['LOADER', 'ATEST2']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      controller.selectedType.value = value ?? '';
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// 🔽 MAKE DROPDOWN
            Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Make:"),
                  SizedBox(height: 11),
                  DropdownButtonFormField<String>(
                    initialValue: controller.selectedMake.value.isEmpty
                        ? null
                        : controller.selectedMake.value,
                    decoration: const InputDecoration(
                      labelText: 'Make',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Volvo', 'ATEST1']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      controller.selectedMake.value = value ?? '';
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// 🔽 MODEL DROPDOWN
            Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Model:"),
                  SizedBox(height: 11),
                  DropdownButtonFormField<String>(
                    initialValue: controller.selectedModel.value.isEmpty
                        ? null
                        : controller.selectedModel.value,
                    decoration: const InputDecoration(
                      labelText: 'Model',
                      border: OutlineInputBorder(),
                    ),
                    items: ['L150H', 'other']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      controller.selectedModel.value = value ?? '';
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ✅ APPLY
            InkWell(
              onTap: () {
                controller.applyFilter();
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.buttonDanger,
                ),
                child: Center(
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            /// ❌ CANCEL
            Center(
              child: TextButton(
                onPressed: () {
                  controller.clearFilter();
                  Get.back();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppColors.buttonDanger,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}
