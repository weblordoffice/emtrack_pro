import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yokohama_emtrack/routes/app_pages.dart';
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
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Vehicle ID (show vehicleNumber when available, else vehicleId)
                                Row(
                                  children: [
                                    const Text(
                                      'Vehicle ID: ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      tyre.vehicleNumber?.isNotEmpty == true
                                          ? tyre.vehicleNumber!
                                          : (tyre.vehicleId != null
                                              ? '#${tyre.vehicleId}'
                                              : '-'),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                // Serial (number)
                                Row(
                                  children: [
                                    const Text(
                                      'Serial: ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Expanded(
                                      child: Text(
                                        tyre.tireSerialNo ?? '-',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                // Size and Type on same line
                                Row(
                                  children: [
                                    Text(
                                      'Size: ',
                                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                                    ),
                                    Text(
                                      '${tyre.sizeName ?? '-'}  •  ',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Type: ',
                                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                                    ),
                                    Expanded(
                                      child: Text(
                                        tyre.typeName ?? '-',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Text(
                                      'Status: ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      tyre.tireStatusName ?? '-',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Material(
        color: Colors.transparent,
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => Get.toNamed(AppPages.CREATE_TYRE),
          borderRadius: BorderRadius.circular(24),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              'assets/svgImage/NewTire.svg',
              height: 56,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  String formatNum(num? value) {
    if (value == null) return "0";
    return value % 1 == 0 ? value.toInt().toString() : value.toString();
  }
}
