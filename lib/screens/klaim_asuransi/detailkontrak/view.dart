import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/klaim_asuransi/detailkontrak/logic.dart';
import 'package:jmcare/screens/klaim_asuransi/detailkontrak/state.dart';

class DetailAgreementinscoScreen extends StatelessWidget {
  const DetailAgreementinscoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailAgreementinscoLogic logic = Get.put(DetailAgreementinscoLogic());
    final DetailAgreementinscoState state = Get.find<DetailAgreementinscoLogic>().state;

    return GetBuilder<DetailAgreementinscoLogic>
      (
      assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Detail Kontrak",
            body: Obx(
                    () => logic.is_loading.value
                          ? Komponen.getLoadingWidget()
                          : Column(
                              children: [
                                TextField(
                                  onChanged: (s){
                                    logic.filter();
                                  },
                                  controller: state.tecSearch,
                                  decoration: InputDecoration(
                                    hintText: "Cari nomor asuransi",
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.search),
                                      onPressed: () {
                                        logic.filter();
                                      },
                                    ),
                                  ),
                                ),

                                const Padding(padding: EdgeInsets.only(top: 10)),

                                logic.agrInsco.value.data!.isEmpty || logic.agrInsco.value.data == null || logic.agrInsco.value == null || logic.agrInsco.value.data == null
                                    ? Center(child: Komponen.getTidakAdaData(),)
                                    : Expanded(
                                    child: ListView.separated(
                                        separatorBuilder: (context,index){
                                          return const Padding(padding: EdgeInsets.only(top: 10));
                                        },
                                        itemCount: logic.jmlRow.value,
                                        itemBuilder: (context,index){
                                          return InkWell(
                                            child: Komponen.cardAgreementInsco(logic.agrInsco.value.data![index]),
                                            onTap: (){
                                              logic.execDialogKlaim(context, index);
                                            },
                                          ) ;
                                        }
                                    )
                                )
                              ],
                            )
            ),
          );
        }
    );
  }
}
