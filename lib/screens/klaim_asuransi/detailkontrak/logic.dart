import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/AgreementinscoRespon.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/klaim_asuransi/detailkontrak/state.dart';
import 'package:get/get.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/klaimasuransi/AgreementinscoService.dart';
import 'package:flutter/material.dart';
import 'package:jmcare/service/klaimasuransi/CheckclaimavailableService.dart';

class DetailAgreementinscoLogic extends BaseLogic {

  final DetailAgreementinscoState state = DetailAgreementinscoState();
  var agrInsco = AgreementinscoRespon().obs;
  var realInsco = AgreementinscoRespon();
  var jmlRow = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    state.agreement_no = Get.arguments[Konstan.tag_detail];
    state.branch_name = Get.arguments[Konstan.tag_branch_name];
    debugPrint(state.branch_name);
    getDetail();
  }

  Future<bool?> dialogKlaim(BuildContext context, int index) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('KLAIM ASURANSI'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Klaim apakah yang ingin Anda ajukan?'),
              ],
            ),
          ),
          actions: <Widget>[
            // TextButton(
            //   child: const Text('KECELAKAAN',style: TextStyle(color: Colors.green)),
            //   onPressed: () {
            //     Navigator.of(context).pop(false);
            //   },
            // ),

            //untuk saat ini insco cuma handle KEHILANGAN saja
            //jadi yang muncul cuma button KEHILANGAN
            //button KECELAKAAN di-hidden (lihat diatasnya)
            TextButton(
              child: const Text('KEHILANGAN', style: TextStyle(color: Colors.green),),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void execDialogKlaim(BuildContext context, int index){
    dialogKlaim(context, index).then((value){
      if (value != null){
        final data = agrInsco.value.data![index];
        if (value!){
          //kalau pilih KEHILANGAN
          if (data.mAINCVGTYPENAME == "TOTAL LOSS ONLY"){
            print("Officexcode " + data.oFFICECODE!);
            // Get.offAndToNamed(Konstan.rute_klaimasuransi_kontak_insco);
            Get.offAndToNamed(
                Konstan.rute_klaimasuransi_formawal,
                arguments: {
                  Konstan.tag_agreement_no: data.aGRMNTNO,
                  Konstan.tag_contract_stat: data.cONTRACTSTAT,
                  Konstan.tag_insco_branch_name: data.iNSCOBRANCHNAME,
                  Konstan.tag_main_cvg_type_name: data.mAINCVGTYPENAME,
                  Konstan.tag_policy_name: data.pOLICYNAME,
                  Konstan.tag_policy_no: data.pOLICYNO,
                  Konstan.tag_branch_id: data.oFFICECODE,
                  Konstan.tag_tipe_klaim: Konstan.tag_kehilangan,
                  Konstan.tag_branch_name: state.branch_name
                }
            );
          }else{
            Get.offAndToNamed(Konstan.rute_klaimasuransi_kontak_insco);
          }
        }else{
          //pilih KECELAKAAN
          if (data.mAINCVGTYPENAME == "TOTAL LOSS ONLY"){
            print("Officexcode " + data.oFFICECODE!);
            Get.offAndToNamed(
                Konstan.rute_klaimasuransi_formawal,
                arguments: {
                  Konstan.tag_agreement_no: data.aGRMNTNO,
                  Konstan.tag_contract_stat: data.cONTRACTSTAT,
                  Konstan.tag_insco_branch_name: data.iNSCOBRANCHNAME,
                  Konstan.tag_main_cvg_type_name: data.mAINCVGTYPENAME,
                  Konstan.tag_policy_name: data.pOLICYNAME,
                  Konstan.tag_policy_no: data.pOLICYNO,
                  Konstan.tag_branch_id: data.oFFICECODE,
                  Konstan.tag_tipe_klaim: Konstan.tag_kecelakaan,
                  Konstan.tag_branch_name: state.branch_name
                }
            );
          }else{
            Get.offAndToNamed(Konstan.rute_klaimasuransi_kontak_insco);
          }
        }
      }
    });
  }

  void getDetail() async {
    is_loading.value = true;

    final respon = await getService<Agreementinscoservice>()?.getAgreementInsco(state.agreement_no);
    if (respon is AgreementinscoError || respon == null){
      Fungsi.koneksiError();
      jmlRow.value = 0;
    }else{
      agrInsco.value = respon!;
      realInsco.data = respon!.data!;
      jmlRow.value = realInsco!.data!.length;
    }
    is_loading.value = false;
  }

  void filter() {
    if (state.tecSearch!.text.isEmpty ||
        state.tecSearch!.text.length == 0) {
      agrInsco.value.data = realInsco.data;
      jmlRow.value = realInsco.data!.length;
    } else {
      var tmp = realInsco.data;
      var filtered = tmp!
          .where((x) => x.pOLICYNO!
          .toLowerCase()
          .contains(state.tecSearch!.text.toLowerCase()))
          .toList();
      agrInsco.value.data = filtered;
      jmlRow.value = agrInsco.value.data!.length;
    }
  }

}