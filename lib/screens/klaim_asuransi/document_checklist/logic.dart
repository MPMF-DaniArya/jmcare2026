import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/DocumentCodeModel.dart';
import 'package:jmcare/model/api/DropdownRespon.dart';
import 'package:jmcare/model/api/MpmiSubmitDocumentChecklist.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/klaim_asuransi/document_checklist/state.dart';
import 'package:jmcare/service/DropdownService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/klaimasuransi/GetDocumentChecklistAsuransiService.dart';
import 'package:jmcare/service/klaimasuransi/UpdatechecklistdocumentService.dart';

import '../../../model/api/MpmiBaseRespon.dart';
import '../../../service/klaimasuransi/MpmiDocumentChecklistService.dart';

class DocumentchecklistLogic extends BaseLogic {

  final DocumentchecklistState state = DocumentchecklistState();
  var obsDropdown = DropdownRespon().obs;
  var jmlRow = 0.obs;
  var obsLoadDocChecklist = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    
    getDetail();
    getDocChecklistFromAsuransi();
  }

  void getDetail(){
    //get id formawal yang dilempar dari Komponen getCardRiwayatFormawal
    //dari screen riwayat form awal
    state.id_formawal = Get.arguments["detail"];
    state.nomor_kontrak = Get.arguments["nomor_kontrak"];
    print("id formawal ${state.id_formawal}");
  }

  void submitDocumentChecklist() async {
    is_loading.value = true;
    final strToken = await getTokenMpmi();

    //collect semua checkbox
    DocumentChecklist r;
    List<DocumentChecklist> result = List<DocumentChecklist>.empty(growable: true);
    for (var e in obsDropdown.value.data!) {
      //pilih hanya yang dicentang aja...
      if (e.selected == true){
        r = DocumentChecklist(
            documentCode: e.idDropdown,
            checked: e.selected ?? false
        );
        result.add(r);
      }
    }

    final request = MpmiSubmitDocumentChecklist(
        contractNo: state.nomor_kontrak,
        documentChecklist: result,
        token: strToken
    );

    debugPrint("request " + jsonEncode(request));

    final respon = await getService<MpmiDocumentChecklistService>()?.submitDocumentChecklist(request);
    if (respon is MpmibaseError || respon == null){
      Fungsi.koneksiError();
    }else{
      if (respon.status == "1"){
        Fungsi.suksesToast(respon.message!);
        submitJMCare();
      }else{
        Fungsi.errorToast(respon.message!);
      }
    }
    is_loading.value = false;
  }
  
  void submitJMCare() async {
    DocumentChecklist r;
    List<DocumentChecklist> result = List<DocumentChecklist>.empty(growable: true);
    for (var e in obsDropdown.value.data!) {
      if (e.selected == true){
        r = DocumentChecklist(
            documentCode: e.idDropdown,
            checked: e.selected ?? false
        );
        result.add(r);
      }
    }

    if (result == "[]" || result.isEmpty){
      Fungsi.warningToast("Setidaknya satu dokumen harus dipilih");
    }else{
      //sebelum submit, harus dipastikan kalau user harus mencentang semua ceklist
      //caranya adalah memastikan jumlah cek insco dengan cek user harus sama length-nya
      //untuk mencari jumlah cek insco adalah dari obsDropdown.value.data!.where((e) => e.enabled == true) seperti ini
      final jmlCek = obsDropdown.value.data!.where((e) => e.enabled == true);
      //untuk mencari jumlah cek user adalah dari variabel result seperti ini
      final jmlCentang = result.where((e) => e.checked == true);
      //kalau user gak centang apa pun
      if (jmlCentang.isEmpty){
        Fungsi.warningToast("Belum ada satu ceklist yang dicentang");
      }else{
        if (jmlCentang.length < jmlCek.length){
          Fungsi.warningToast("Semua ceklist harus dicentang");
        }else{
          //submit semua=================================================
          is_loading.value = true;
          state.arrayChecklistDocument = jsonEncode(result);
          final respon = await getService<UpdatechecklistdocumentService>()?.doUpdate(int.parse(state.id_formawal), state.arrayChecklistDocument);
          if (respon is BaseError || respon == null){
            Fungsi.koneksiError();
          }else{
            Get.offAndToNamed(Konstan.rute_klaimasuransi_riwayat_formawal);
            Fungsi.suksesToast(respon.message!);
          }
          is_loading.value = false;
        }
      }
    }
  }

  void handleCheckbox(int index, bool newValue) {
    obsDropdown.value.data![index].selected = newValue;
    update();
  }

  //fungsi ini dijalanin sesudah hit api get doc checklist dari insco
  //sesudah get semua, nanti dilooping sama checklist insco
  //yang gak ada di checklist insco, enablednya di false,
  //biar gak bisa diklik debitur
  void getDropdownDocChecklist() async {
    is_loading.value = true;
    final respon = await getService<DropdownService>()?.getDropdown("klaim_asuransi", "document_checklist");
    if (respon is DropdownError || respon == null){
      jmlRow.value = 0;
      Fungsi.errorToast("Gagal memproses checklist dokumen");
      debugPrint("ga ada data 01");
    }else{
      //cek dulu apakah variabel dcm null atau ada nilainya gak
      //kalo gak ada, enable semua, biar bisa dicentang
      if (state.dcm == null){
        respon!.data!.forEach((x){
          x.enabled = true;
        });
        jmlRow.value = respon.data!.length;
        debugPrint("masuk 02");
      }else{
        //kalo gak null, tapi kosong
        if (state.dcm.isEmpty){
          respon!.data!.forEach((x){
            x.enabled = true;
          });
          jmlRow.value = respon.data!.length;
          debugPrint("masuk 03");
        }else{
          //looping dulu untuk di-match ke var list dropdowncode
          //ada id dropdown itu di docchecklist insco
          respon!.data!.forEach((x){
            //cari di dcm
            final filter = state.dcm.where((i) => i.documentCode == x.idDropdown);
            //kalo gak ada, disable, biar gak bisa dicentang debitur
            if (filter.isEmpty){
              x.enabled = false;
            }else{
              //kalo ada , enable, biar bisa dicek debitur
              x.enabled = true;
            }
          });
          //asign respon ke variabel obs, biar tampil di listview
          obsDropdown.value = respon!;
          jmlRow.value = respon.data!.length;
          debugPrint("masuk 04");
        }
      }
    }
    is_loading.value = false;
  }


//class ini gunanya buat hit api
//buat get document checklist yang udah ditentukan sama insco
//lihat tabel jmcare.dbo.klaim_asuransi_formlanjutan -> field document_checklist_dari_asuransi
//alasan dibuat api ini adalah
//karena user harus tahu checklist apa saja yang ditentukan sama insco
//misalnya dari insco cuma nentuin doc check listnya => D01, D02, D03 doang...
//lha masalahnya, di page document itu kan nampilin semua master dropdown (dari D01,D02,dst sampat D20)
//kalau debitur centang sembarangan, waktu submit di api insco, bakalan return error
//jadi debitur harus dibuatin filter, checklist dropdown mana aja yang bisa dia centang

  //ini hit api buat get list doc yang ditentuin dari insco
  //lihat tabel jmcare.dbo.klaim_asuransi_formlanjutan -> field document_checklist_dari_asuransi
  //nanti returnnya string kayak gini => [{"DocumentCode":"D01"},{"DocumentCode":"D02"},{"DocumentCode":"D03"},{"DocumentCode":"D04"},{"DocumentCode":"D05"},{"DocumentCode":"D09"}]
  //ini harus di-get dulu sebelum get master dropdown
  void getDocChecklistFromAsuransi() async {
    is_loading.value = true;
    final docChecklist = await getService<GetDocumentChecklistAsuransiService>()!.getDocumentChecklist(state.id_formawal);
    if (docChecklist == null){
      is_loading.value = false;
      state.docChecklistFromAsuransi = "";
      jmlRow.value = 0;
      debugPrint("Tidak ada data checklist");
      return;
    }else{
      if (docChecklist!.code == "200"){
        is_loading.value = false;
        state.docChecklistFromAsuransi = docChecklist!.message ?? "";
        if (state.docChecklistFromAsuransi == ""){
          jmlRow.value = 0;
          debugPrint("Tidak ada data checklist");
        }else{
          //kalau sukses, convert jadi list
          Iterable l = json.decode(state.docChecklistFromAsuransi);
          //ini hasil convertnya
          state.dcm = List<DocumentCodeModel>.from(l.map((model)=> DocumentCodeModel.fromJson(model)));
          //nanti list ini di-compare sama get master dropdown ya...
        }
      }else{
        jmlRow.value = 0;
        debugPrint("Tidak ada data checklist");
        is_loading.value = false;
        state.docChecklistFromAsuransi = "";
      }
    }
    //sesudah hit api buat list docchecklist yang ditentuin insco
    //hit api buat get semua list dropdown/checkbox
    getDropdownDocChecklist();
  }
}