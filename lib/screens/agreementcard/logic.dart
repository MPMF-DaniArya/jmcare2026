import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/AgreementcardRespon.dart';
import 'package:jmcare/screens/agreementcard/state.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/service/AgreementcardService.dart';
import 'package:jmcare/service/Service.dart';

class AgreementcardLogic extends BaseLogic {
  final AgreementcardState state = AgreementcardState();
  var agreementCard = AgreementcardRespon().obs;

  @override
  void onInit() {
    super.onInit();
    getAgreementCard();
  }

  void getAgreementCard() async {
    is_loading.value=true;
    final detail = Get.arguments['detail'];
    state.agreementID = detail;
    final agreementRespon = await getService<AgreementcardService>()?.getAgreementCard(state.agreementID.toString());
    if (agreementRespon is AgreementcardError || agreementRespon == null){
      Fungsi.errorToast("Gagal mengambil data agreement card!");
    }else{
      agreementCard.value = agreementRespon!;
      debugPrint("detail " + detail.toString());
      debugPrint("hasil " + agreementRespon!.toString());
    }
    is_loading.value=false;
  }

  List<DataRow> getRows() {
    List<DataRow> hasil = List<DataRow>.empty(growable: true);
    DataRow dataRow;
    int counter = 0;

    this.agreementCard.value.data!.forEach((d) {
      dataRow = DataRow(
        selected: (counter % 2 == 0 ? true : false),
        cells: <DataCell>[
          DataCell( Center(child: Text(d.iNSTSEQNO.toString(), textAlign: TextAlign.center,),)),
          DataCell(Text(d.dUEDT.toString())),
          DataCell(Align(alignment: Alignment.centerRight, child: Text(Fungsi.thousandSeparator(int.parse(d.iNSTAMT!.round().toString()))))),
          DataCell(Text(d.iNSTPAIDDATE.toString())),
          DataCell(Align(alignment: Alignment.centerRight,child: Text(Fungsi.thousandSeparator(int.parse(d.iNSTPAIDAMT!.round().toString()))))),
          DataCell(Align(alignment: Alignment.centerRight, child: Text(Fungsi.thousandSeparator(int.parse(d.lCINSTPAIDAMT!.round().toString()))))),
          DataCell(Align(alignment: Alignment.centerRight, child: Text(Fungsi.thousandSeparator(int.parse(d.lCDAY.toString()))))),
          const DataCell(Text("")),
          const DataCell(Text(""))
        ],
      );
      hasil.add(dataRow);
      counter += 1;
    });
    return hasil;
  }

  List<DataColumn> getColumns(){
    return  [
      DataColumn(label: Text("Angsuran Ke", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black ))),
      DataColumn(label: Text("Jatuh Tempo", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black ))),
      DataColumn(label: Text("Angsuran", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black ))),
      DataColumn(label: Text("Tgl Bayar", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black ))),
      DataColumn(label: Text("Jumlah Bayar", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black ))),
      DataColumn(label: Text("Denda", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black ))),
      DataColumn(label: Text("LC Days", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black ))),
      DataColumn(label: Text("Tipe Pembayaran", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black ))),
      DataColumn(label: Text("No. TTR", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black ))),
    ];
  }

}