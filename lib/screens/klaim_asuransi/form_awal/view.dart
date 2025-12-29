import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/klaim_asuransi/form_awal/logic.dart';
import 'package:jmcare/screens/klaim_asuransi/form_awal/state.dart';

class FormawalScreen extends StatelessWidget {
  const FormawalScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final FormawalLogic logic = Get.put(FormawalLogic());
    final FormawalState state = Get.find<FormawalLogic>().state;

    return GetBuilder<FormawalLogic>(
        assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Form Laporan Awal",
            body:
              Obx(() => logic.is_loading.value
                ? Komponen.getLoadingWidget()
                : Form(
                  key: state.formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        enabled: false,
                        controller: state.tecTgllapor,
                        decoration: const InputDecoration(
                          labelText: "Tanggal lapor",
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        controller: state.tecNoKontrak,
                        decoration: const InputDecoration(
                          labelText: "Nomor kontrak",
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        controller: state.tecNamaTertanggung,
                        decoration: const InputDecoration(
                          labelText: "Nama tertanggung",
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        controller: state.tecNomorPolis,
                        decoration: const InputDecoration(
                          labelText: "Nomor polis asuransi",
                        ),
                      ),
                      TextFormField(
                        enabled: false,
                        controller: state.tecJenisPertanggungan,
                        decoration: const InputDecoration(
                          labelText: "Jenis pertanggungan",
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: state.tecTglKejadian,
                        onTap: () => logic.tapTglKejadian(context),
                        decoration: const InputDecoration(
                          labelText: "Tanggal dan jam kejadian",
                        ),
                      ),
                      logic.obsLoadingJenisklaim.value
                          ? const LinearProgressIndicator()
                          : DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  labelText: "Jenis klaim"
                              ),
                              value: logic.idxDdJenisklaim.value,
                              items: logic.ddJenisklaim.value,
                              onChanged: (newValue){
                                logic.setDDJenisklaim(newValue);
                              }) ,
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ElevatedButton(
                          onPressed: () {
                            logic.submitClaimRegister();
                            // logic.submitJMCare();
                          },
                          child: const Text(
                            "Submit"
                          )
                      )
                    ],
                  ),
                ),
              )
          );
        }
    );
  }
}
