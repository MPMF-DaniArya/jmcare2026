import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
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
        builder: (logic){
          return JmcareBarScreen(
            title: "Notifikasi",
            body: Obx(
                    () => logic.is_loading.value
                          ? Komponen.getLoadingWidget()
                          : (logic.obsRowCount.value == 0)
                            ? Komponen.getTidakAdaData()
                            : RefreshIndicator(
                              child: ListView.builder(
                                      itemCount: logic.obsRowCount.value,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Card(
                                          child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Row(
                                                  children: [
                                                    const Icon(Icons.notifications, color: Colors.green,),
                                                    const Padding(padding: EdgeInsets.only(left: 10)),
                                                    Expanded(child:
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(logic.obsNotifRespon.value.data![index].judulNotif!,
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18
                                                          ),
                                                        ),

                                                        Text(logic.obsNotifRespon.value.data![index].isi!,
                                                          overflow: TextOverflow.ellipsis,
                                                          softWrap: false,
                                                          maxLines: 5,
                                                        ),
                                                        const Padding(padding: EdgeInsets.only(top: 5)),
                                                        Text(logic.obsNotifRespon.value.data![index].createDate!,
                                                          style: const TextStyle(
                                                              fontStyle: FontStyle.italic,
                                                              color: Colors.grey
                                                          ),
                                                        )
                                                      ],
                                                    ))
                                                  ]
                                              )
                                          ),
                                        );
                                      }
                                  ),
                              onRefresh: () async {
                                logic.getNotif();
                              }
                    )
            ),
          );
        }
    );
  }
}
