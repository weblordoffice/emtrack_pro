import 'package:emtrack/create_tyre/create_tyre_screen.dart';
import 'package:emtrack/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/all_tyre_controller.dart';
import '../color/app_color.dart';

class AllTyresView extends StatelessWidget {
  AllTyresView({super.key});

  /// ✅ CONTROLLER INJECTION (MAIN FIX)
  final AllTyreController controller = Get.put(AllTyreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tires'),
        centerTitle: true,
        leading: const BackButton(color: AppColors.primary),
      ),
      body: Column(
        children: [
          // 🔍 SEARCH
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: controller.onSearch,
              decoration: const InputDecoration(
                hintText: 'Filter Tires',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
              ),
            ),
          ),

          // 📑 TAB BAR
          TabBar(
            controller: controller.tabController,
            isScrollable: true,
            indicatorColor: AppColors.buttonDanger,
            tabAlignment: TabAlignment.start,
            labelColor: AppColors.buttonDanger,
            unselectedLabelColor: AppColors.primary,
            tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
          ),

          // 📦 TAB VIEW + LIST
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: controller.tabs.map((_) {
                return Obx(() {
                  // 🔄 LOADING
                  if (controller.isLoading.value &&
                      controller.allTyres.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // ❌ EMPTY
                  if (controller.visibleTyres.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No Data To Display',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    );
                  }

                  // ✅ LIST
                  return ListView.builder(
                    itemCount: controller.visibleTyres.length,
                    itemBuilder: (_, i) {
                      final tyre = controller.visibleTyres[i];

                      return GestureDetector(
                        onTap: () => controller.openBottomSheet(tyre),
                        child: Card(
                          color: Colors.red.shade50.withOpacity(0.9),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          shape: RoundedSuperellipseBorder(
                            side: const BorderSide(
                              color: Colors.red, // border color
                              width: 1, // border width
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              tyre.tireSerialNo ?? "-",
                              style: const TextStyle(
                                color: AppColors.buttonDanger,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Vehicle Id:',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '#${tyre.vehicleId ?? '-'}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Size: ',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          ' ${tyre.sizeName ?? '-'}  ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          'Type:',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          ' ${tyre.typeName ?? '-'}',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Status: ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      tyre.tireStatusName ?? " ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                const Icon(
                                  Icons.settings,
                                  color: AppColors.buttonDanger,
                                  size: 34,
                                ),

                                Text(
                                  "${formatNum(tyre.currentTreadDepth)}/${formatNum(tyre.percentageWorn)}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                });
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _createTireFAB(),
    );
  }

  Widget _createTireFAB() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 🟡 CREATE NEW VEHICLE BUTTON
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow.shade800,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomLeft: Radius.circular(40),
                topRight: Radius.circular(40), // nukila effect
                bottomRight: Radius.circular(0),
              ),
            ),
          ),
          onPressed: () {
            Get.toNamed(AppPages.CREATE_TYRE);
          },
          child: const Text(
            'Create New Tire',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(width: 5),

        // 🔵 FLOATING ICON BUTTON
        FloatingActionButton(
          backgroundColor: Colors.blue.shade900,
          shape: const CircleBorder(),
          onPressed: () {
            Get.toNamed(AppPages.CREATE_TYRE);
          },
          child: const Icon(
            Icons.car_crash_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  String formatNum(num? value) {
    if (value == null) return "0";
    return value % 1 == 0 ? value.toInt().toString() : value.toString();
  }
}
