import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/klaim_asuransi/upload_sttlp/logic.dart';
import 'package:jmcare/screens/klaim_asuransi/upload_sttlp/state.dart';

class UploadsttlpScreen extends StatelessWidget {
  const UploadsttlpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UploadsttlpLogic logic = Get.put(UploadsttlpLogic());
    final UploadsttlpState state = Get.find<UploadsttlpLogic>().state;

    return GetBuilder<UploadsttlpLogic>(
      assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Surat Tanda Terima Laporan Polisi",
            body: Obx(
                    () => logic.is_loading.value
                        ? Komponen.getLoadingWidget()
                        : ListView(
                            children: [
                              Row(
                                children: [
                                  OutlinedButton(onPressed: (){
                                    logic.pickFile();
                                  }, child: const Text("Pilih file...")),
                                  const Padding(padding: EdgeInsets.only(left: 20)),
                                  const Text("Silakan pilih file STTLP", textAlign: TextAlign.center,),
                                ],
                              ),
                              const Divider(),
                              const Padding(padding: EdgeInsets.only(bottom: 30)),
                              state.result != null
                                  ? Stack(
                                      children: [
                                        const Align(alignment: Alignment.topCenter, child: Icon(Icons.file_copy_outlined, size: 80, color: Colors.green,),),
                                        Align(alignment: Alignment.topCenter,
                                          child: SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: Align(alignment: Alignment.bottomLeft,
                                              child: Text(state.fileExtension.toUpperCase(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                ),
                                              ),
                                            )
                                        ),),
                                      ],
                                    )
                                  : Container(),

                              state.result != null
                                  ? Column(children: [
                                      const Divider(),
                                      ElevatedButton(
                                          onPressed: () {
                                            logic.submitJMCare();
                                          },
                                          child: const Text("Submit"))
                                    ],)
                                  : Container(),

                            ],
                          ),
            )
          );
        });
  }
}
