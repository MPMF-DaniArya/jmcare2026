import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/riwayat_status_pengajuan/state.dart';
import 'package:jmcare/screens/pengkiniandata/screens/riwayat_status_pengajuan/widgets/history_card.dart';

import 'logic.dart';

class RiwayatStatusPengajuan extends StatelessWidget {
  const RiwayatStatusPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final RiwayatStatusPengajuanLogic logic =
        Get.put(RiwayatStatusPengajuanLogic());

    return JmcareBarScreen(
        title: 'Riwayat Status',
        body: Padding(
          padding: const EdgeInsetsGeometry.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter Berdasarkan Status',
                      style: textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: logic.state.categories.map(
                          (category) {
                            return Padding(
                              padding: const EdgeInsetsGeometry.only(right: 8)
                                  .add(const EdgeInsetsGeometry.only(top: 8)),
                              child: Obx(
                                () {
                                  final isSelected =
                                      logic.selectedCategory.value == category;

                                  return GestureDetector(
                                    onTap: () => logic.changeCategory(category),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        category,
                                        style: textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsGeometry.only(top: 16),
                  child: Obx(
                    () {
                      final data = logic.filterredHistory;

                      if (data.isEmpty) {
                        return Center(
                          child: Text(
                            'Data tidak ditemukan',
                            style: textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return HistoryCard(data: data[index]);
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
