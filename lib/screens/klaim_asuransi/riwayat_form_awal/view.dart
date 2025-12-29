
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/klaim_asuransi/riwayat_form_awal/logic.dart';
import 'package:jmcare/screens/klaim_asuransi/riwayat_form_awal/state.dart';

class RiwayatformawalScreen extends StatelessWidget {
  const RiwayatformawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RiwayatformawalLogic logic = Get.put(RiwayatformawalLogic());
    final RiwayatformawalState state = Get.find<RiwayatformawalLogic>().state;

    return GetBuilder<RiwayatformawalLogic>
      (assignId: true,
       builder: (logic){
          return JmcareBarScreen(
            title: "Status Klaim",
            body: Obx(
                    () => logic.is_loading.value
                        ? Komponen.getLoadingWidget()
                        : logic.rowCount.value == 0
                          ? Center(child: Komponen.getTidakAdaData(),)
                          : ListView.separated(
                              separatorBuilder: (context,index){
                                return const Padding(padding: EdgeInsets.only(top: 30));
                              },
                              itemCount: logic.rowCount.value,
                              itemBuilder: (context,index){
                                return Komponen.getCardRiwayatFormawal(
                                    logic.obsRiwayatformawal.value,
                                    index,
                                    ()=>logic.klikFormlanjut(
                                        logic.obsRiwayatformawal.value.data![index]
                                    ),
                                    ()=>logic.gotoDocumentChecklist(index),
                                    ()=>logic.downloadSuratKeputusan(index)
                                );
                              }
                      )
            ),
          );
        }
    );
  }
}
