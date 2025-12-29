import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/klaim_asuransi/document_checklist/logic.dart';
import 'package:jmcare/screens/klaim_asuransi/document_checklist/state.dart';

class DocumentchecklistScreen extends StatelessWidget {
  const DocumentchecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DocumentchecklistLogic logic = Get.put(DocumentchecklistLogic());
    final DocumentchecklistState state = Get.find<DocumentchecklistLogic>().state;

    return GetBuilder<DocumentchecklistLogic>(
        assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Cek Daftar Dokumen",
            body: Obx(
                    ()=> logic.is_loading.value
                        ? Komponen.getLoadingWidget()
                        : logic.jmlRow.value == 0
                          ? Komponen.getTidakAdaData()
                          : Column(
                            children: [
                              const Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text("Anda harus melengkapi dokumen berikut untuk proses klaim. Jika Anda sudah melengkapi dan mengirim dokumen asli ke kantor cabang, silakan cek daftar di bawah.",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16
                                      ),),
                                  )
                              ),
                              logic.obsLoadDocChecklist.value ? const LinearProgressIndicator() : Container(),
                              Expanded(child: ListView.builder(
                                itemCount: logic.jmlRow.value,
                                itemBuilder: (context, index){

                                  return Visibility(
                                      visible: logic.obsDropdown.value.data![index].enabled ?? false,
                                      child: CheckboxListTile(
                                          enabled: logic.obsDropdown.value.data![index].enabled ?? false,
                                          value: logic.obsDropdown.value.data![index].selected ?? false,
                                          title: Text(logic.obsDropdown.value.data![index].titleDropdown!),
                                          onChanged: (newValue) {
                                            logic.handleCheckbox(index,newValue!);
                                          }
                                      )
                                  );
                                },
                              )),
                              logic.jmlRow.value > 0
                                  ? ElevatedButton(
                                  onPressed: (){
                                    // logic.submitDocumentChecklist();
                                    logic.submitJMCare();
                                  },
                                  child: const Text("Submit")
                              )
                                  :Container()
                            ],
                          )
            ),
          );
        }
    );
  }
}
