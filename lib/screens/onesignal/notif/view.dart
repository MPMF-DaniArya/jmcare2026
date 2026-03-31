import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/helper/Warna.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/onesignal/notif/logic.dart';
import 'package:jmcare/screens/onesignal/notif/state.dart';

class OnesignalnotifScreen extends StatelessWidget {
  const OnesignalnotifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnesignalnotifLogic logic = Get.put(OnesignalnotifLogic());
    final OnesignalnotifState state = Get.find<OnesignalnotifLogic>().state;

    return GetBuilder<OnesignalnotifLogic>(
        assignId: true,
        builder: (logic) {
          return JmcareBarScreen(
            title: "Notifikasi",
            body: Obx(() => logic.is_loading.value
                ? Komponen.getLoadingWidget()
                : (logic.obsRowCount.value == 0)
                    ? Komponen.getTidakAdaData()
                    : RefreshIndicator(
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: logic.obsNotifRespon.value.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final itemNotif =
                                  logic.obsNotifRespon.value.data![index];
                              final bool isUnread = itemNotif.isRead == '0';

                              return InkWell(
                                onTap: () {
                                  logic.isReadNotifikasi(
                                      itemNotif.id!, itemNotif);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            width: 5,
                                            color: isUnread
                                                ? Warna.hijau
                                                : Colors.grey.shade300,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: isUnread
                                                          ? Warna.hijau
                                                              .withOpacity(0.1)
                                                          : Colors
                                                              .grey.shade100,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      isUnread
                                                          ? Icons
                                                              .notifications_active_rounded
                                                          : Icons
                                                              .notifications_none_rounded,
                                                      color: isUnread
                                                          ? Warna.hijau
                                                          : Colors.grey,
                                                      size: 24,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                itemNotif
                                                                        .judulNotif ??
                                                                    "-",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight: isUnread
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .w600,
                                                                  fontSize: 16,
                                                                  color: isUnread
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .black87,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          itemNotif.isi ?? "-",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: isUnread
                                                                ? Colors.black87
                                                                : Colors.grey
                                                                    .shade600,
                                                            fontSize: 13,
                                                            height: 1.4,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .access_time_rounded,
                                                              size: 14,
                                                              color: Colors.grey
                                                                  .shade500,
                                                            ),
                                                            const SizedBox(
                                                                width: 4),
                                                            Text(
                                                              itemNotif
                                                                      .createDate ??
                                                                  "-",
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        onRefresh: () async {
                          logic.getNotif();
                        })),
          );
        });
  }
}
