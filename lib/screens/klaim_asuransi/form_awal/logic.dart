import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/JenisklaimRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/klaim_asuransi/form_awal/state.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/klaimasuransi/InsertformawalService.dart';
import 'package:jmcare/service/klaimasuransi/JenisklaimService.dart';
import 'package:jmcare/storage/storage.dart';

import '../../../model/api/MpmiBaseRespon.dart';
import '../../../model/api/MpmiSubmitClaimRegister.dart';
import '../../../service/klaimasuransi/MpmiClaimRegisterService.dart';

class FormawalLogic extends BaseLogic {

  final FormawalState state = FormawalState();
  var obsLoadingJenisklaim = false.obs;
  var obsJenisklaim = JenisklaimRespon().obs;
  var ddJenisklaim = List<DropdownMenuItem>.empty(growable: true).obs;
  var idxDdJenisklaim = "".obs;
  var realJenisklaim = JenisklaimRespon();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDetail();
    setTgllapor();
    getJenisklaim();
  }

  void submitClaimRegister() async {

    print(state.strTglLapor.replaceAll(" ", "T"));
    print(state.strTglKejadian.replaceAll(" ", "T"));

    if (state.tecTglKejadian!.text.isEmpty || idxDdJenisklaim.value.isEmpty){
      Fungsi.warningToast("Tanggal kejadian dan jenis klaim wajib diisi");
      return;
    }else{
      is_loading.value = true;
      final strToken = await getTokenMpmi();
      final request = MpmiSubmitClaimRegister(
          reportDate: state.strTglLapor.replaceAll(" ", "T"),
          contractNo: state.tecNoKontrak!.text,
          insuredName: state.tecNamaTertanggung!.text,
          policyNo: state.tecNomorPolis!.text,
          coverage: state.tecJenisPertanggungan!.text == "TOTAL LOSS ONLY" ? "TLO" : "ALL",
          dateOfIncident: state.strTglKejadian.replaceAll(" ", "T"),
          claimType: state.tipeKlaim == "KECELAKAAN" ? "C001" : "C002",
          branchName: state.branch_name,
          token: strToken
      );
      final respon = await getService<MpmiClaimRegisterService>()?.submitClaimRegister(request);
      if (respon is MpmibaseError || respon == null){
        Fungsi.errorToast("Error submit claim register");
      }else{
        if (respon.status == "1"){
          Fungsi.suksesToast(respon.message!);
          //kalau submit ke mpmi berhasil, submit ke db jmcare
          submitJMCare();
        }else{
          Get.back();
          Fungsi.errorToast(respon.message!);
        }
      }
      is_loading.value = false;
    }
  }

  void submitJMCare() async {
    print("Submitted");
    is_loading.value = true;
    final auth = await getStorage<LoginRespon>();
    final login_user_id = auth.data!.loginUserId;
    final respon = await getService<Insertformawalservice>()?.insertFormAwal(
        login_user_id!,
        state.strTglLapor,
        state.tecNoKontrak!.text,
        state.branch_id,
        state.tecNamaTertanggung!.text,
        state.tecNomorPolis!.text,
        state.tecJenisPertanggungan!.text,
        state.strTglKejadian,
        state.tipeKlaim,
        idxDdJenisklaim.value,
        "",
        ""
    );
    if (respon is BaseError || respon == null){
      Fungsi.koneksiError();
    }else{
      Get.offAllNamed(Konstan.rute_home);
      Fungsi.suksesToast("Formulir laporan awal berhasil disimpan");
    }
    is_loading.value = false;
  }

  void getJenisklaim() async {
    obsLoadingJenisklaim.value = true;
    final respon = await getService<Jenisklaimservice>()?.getJenisKlaim();
    if (respon is JenisklaimError || respon == null) {
      Fungsi.koneksiError();
    }else{
      obsJenisklaim.value = respon!;
      realJenisklaim.data = respon.data;
      //get array pertama, untuk get nomor kontrak pertama
      //asign pada var idxDdNomorKontrak
      if (realJenisklaim.data!.isNotEmpty){
        final klaimPertama = realJenisklaim.data!.first;
        idxDdJenisklaim.value = klaimPertama.rEASONCODE!;
      }

      //tambahkan ke dropdown
      realJenisklaim.data?.forEach((e) {
        //hanya KEHILANGAN saja yang dimasukkan ke dropdown
        if (e.rEASONCODE == "CL01"){
          ddJenisklaim.add(DropdownMenuItem(
              value: e.rEASONCODE,
              child: Text(e.rEASONDESCR!))
          );
        }
      });

      debugPrint("JNS_KLAIM${state.tipeKlaim}");
      //set dropDown jenis klaim default, apakah KEHILANGAN atau KECELAKAAN
      if (realJenisklaim.data!.isNotEmpty){
        if (state.tipeKlaim == Konstan.tag_kehilangan){
          idxDdJenisklaim.value = "CL01";
        }else{
          idxDdJenisklaim.value = "CL02";
        }
        // update();
      }
    }
    obsLoadingJenisklaim.value = false;
  }

  void setDDJenisklaim(String newValue){
    idxDdJenisklaim.value = newValue;
  }

  void getDetail(){
    state.tecNoKontrak!.text = Get.arguments[Konstan.tag_agreement_no];
    state.tecNamaTertanggung!.text = Get.arguments[Konstan.tag_policy_name];
    state.tecNomorPolis!.text = Get.arguments[Konstan.tag_policy_no];
    state.tecJenisPertanggungan!.text = Get.arguments[Konstan.tag_main_cvg_type_name];
    state.branch_id = Get.arguments[Konstan.tag_branch_id];
    state.tipeKlaim = Get.arguments[Konstan.tag_tipe_klaim];
    state.branch_name = Get.arguments[Konstan.tag_branch_name];
    print(state.branch_name);
  }

  void setTglKejadian(DateTime date){
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    final String formatted = formatter.format(date);
    state.strTglKejadian = formatted;

    final DateFormat formatNormal = DateFormat('dd MMM yyyy hh:mm:ss');
    final String tglNormal = formatNormal.format(date);
    state.tecTglKejadian!.text = tglNormal;
  }

  void setTgllapor(){
    final sekarang = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    final String formatted = formatter.format(sekarang);
    state.strTglLapor = formatted;

    final DateFormat formatNormal = DateFormat('dd MMM yyyy hh:mm:ss');
    state.tecTgllapor!.text = formatNormal.format(sekarang);
  }

  void tapTglKejadian(BuildContext context){
    //get tanggal sekarang
    DateTime now =  DateTime.now();
    DateTime date =  DateTime(now.year, now.month, now.day);
    //tanggal submit tidak boleh dari H+14 dari tanggal kejadian
    DateTime minimal = DateTime(date.year, date.month, date.day - 14);

    DatePicker.showDateTimePicker(context,
      showTitleActions: true,
      minTime: minimal,
      onChanged: (date){
        setTglKejadian(date);
      },
      onConfirm: (date){
        setTglKejadian(date);
      },
      currentTime: DateTime.now(), locale: LocaleType.en
    );
  }
}