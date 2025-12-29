import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/DetailFormLanjutanRequest.dart';
import 'package:jmcare/model/api/FormlanjutRequest.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/klaim_asuransi/form_lanjut/state.dart';
import 'package:jmcare/model/api/FormawalRespon.dart' as far;
import 'package:jmcare/service/klaimasuransi/DetailFormLanjutanService.dart';
import 'package:jmcare/storage/storage.dart';

import '../../../helper/Konstan.dart';
import '../../../model/api/MpmiBaseRespon.dart';
import '../../../model/api/MpmiSubmitClaimDetail.dart';
import '../../../service/Service.dart';
import '../../../service/klaimasuransi/MpmiClaimDetailService.dart';

class FormlanjutLogic extends BaseLogic {

  final FormlanjutState state = FormlanjutState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDetail();
  }

  void getDetail() async {
    state.modelFormAwal = Get.arguments["detail"];
    print("model formawal" + " " + state.modelFormAwal);
    var model = jsonDecode(state.modelFormAwal);
    final formawal = far.Data.fromJson(model);

    state.tecNamaTertanggung!.text = formawal.namaTertanggung!;
    state.tecNamaPelapor!.text = formawal.namaTertanggung!;
    state.tecNomorPolisAsuransi!.text = formawal.nomorPolisAsuransi!;
    state.tecNomorMesin!.text = formawal.nomorMesin!;
    state.tecNomorRangka!.text = formawal.nomorRangka!;
    state.tecTahunPembuatan!.text = formawal.tahunPembuatan!;
    state.tecMerkTipeKendaraan!.text = formawal.merkKendaraan!;
    state.tecNomorPolisi!.text = formawal.nomorPlat!;
    state.tipeKlaim = formawal.tipeKlaim!;
    state.id_form_awal = formawal.id.toString();

    final authStorage = await getStorage<LoginRespon>();
    state.tecAlamatTertanggung!.text = authStorage.data!.alamat!;
    state.tecNomorhpTertanggung!.text = authStorage.data!.noHp!;
    state.tecEmailTertanggung!.text = authStorage.data!.email!;

    state.tecAlamatPelapor!.text = authStorage.data!.alamat!;
    state.tecNomorhpPelapor!.text = authStorage.data!.noHp!;
    state.tecEmailPelapor!.text = authStorage.data!.email!;
    state.tecHubunganDenganTertanggung!.text = "Diri sendiri/debitur";

    await getDetailFormLanjutan();
  }

  getDetailFormLanjutan() async {
    is_loading.value = true;
    final request = DetailFormLanjutanRequest(idFormawal: int.parse(state.id_form_awal));
    final detail = await getService<DetailFormLanjutanService>()!.getDetailFormLanjutan(request);
    if (detail !=  null){

      //cek dulu apakah ada tandatangan
      //kalau ada tandatangan berarti SfSignaturePad di hidden
      if (detail.base64Tandatangan != null){
        if (detail.base64Tandatangan!.isEmpty){
          state.is_ada_riwayat = false;
        }else{
          state.is_ada_riwayat = true;
        }

        if (detail.base64Tandatangan == "File tidak ditemukan"){
          state.is_ada_riwayat = false;
        }
      }else{
        state.is_ada_riwayat = false;
      }

      debugPrint("ada data");
      debugPrint(detail.tanggalKejadianFormatIndo);

      //autofill tanggal kejadian
      //========================================================================
      state.tecTglKejadian!.text = detail.tanggalKejadianFormatIndo ?? "";
      state.strTglKejadian = detail.tanggalKejadian ?? "";

      //autofill tempat kejadian
      //========================================================================
      final tempatKejadian = detail.tempatKejadian ?? "";
      final adaTempatKejadian = state.dropdownTempatKejadian.where((x) => x.value == tempatKejadian);
      if (adaTempatKejadian.isEmpty){
        state.selected_dropdownTempatKejadian = state.dropdownTempatKejadian.first.value;
      }else{
        state.selected_dropdownTempatKejadian = tempatKejadian;
      }

      //autofill kecepatan saat kejadian
      //========================================================================
      state.tecKecepatanSaatKejadian!.text = detail.kecepatanSaatKejadian ?? "0";

      //autofill nama pengemudi saat kejadian
      //========================================================================
      state.tecNamaPengemudi!.text = detail.namaPengemudi ?? "";

      //autofill alamat pengemudi saat kejadian
      //========================================================================
      state.tecAlamatPengemudi!.text = detail.alamatPengemudi ?? "";

      //autofill dropdown jenis sim
      //========================================================================
      final jenisSIM = detail.jenisSim ?? "";
      final adaJenisSIM = state.dropdownJenisSIM.where((x) => x.value == jenisSIM);
      if (adaJenisSIM.isEmpty){
        state.selected_dropdownJenisSIM = state.dropdownJenisSIM.first.value;
      }else{
        state.selected_dropdownJenisSIM = jenisSIM;
      }

      //autofill nomor sim
      //========================================================================
      state.tecNomorSIM!.text = detail.nomorSim ?? "";

      //autofill masa berlaku sim
      //========================================================================
      state.tecMasaBerlakuSIM!.text = detail.masaBerlakuSimFormatIndo ?? "";
      state.strMasaBerlakuSIM = detail.masaBerlakuSim ?? "";

      //autofill radio pengemudi bekerja pada tertanggung
      //========================================================================
      state.selected_opsiPengemudiBekerjaPadaTertanggung = (detail.pengemudiBekerjaKpdTertanggung == "1" ? state.opsiPengemudiBekerjaPadaTertanggung[0] : state.opsiPengemudiBekerjaPadaTertanggung[1]);

      //autofill radio pengemudi sepengatahuan pada tertanggung
      //========================================================================
      state.selected_opsiPengemudiSepengetahuanTertanggung = (detail.pengemudiSepengetahuanTertanggung == "1" ? state.opsiPengemudiSepengetahuanTertanggung[0] : state.opsiPengemudiSepengetahuanTertanggung[1]);

      //autofill penggunaan kendaraan saat kejadian
      //========================================================================
      state.tecPenggunaanKendaraanSaatKejadian!.text = detail.penggunaanKendaraanKejadian ?? "";

      //autofill radio dilaporkan ke polisi
      //========================================================================
      state.selected_opsiKejadianDilaporanPolisi = (detail.dilaporkanKePolisi == "1" ? state.opsiKejadianDilaporanPolisi[0] : state.opsiKejadianDilaporanPolisi[1]);

      //autofill nama polsek
      //========================================================================
      state.tecNamaPolsek!.text = detail.namaPolsek ?? "";

      //autofill dimana kendaraan saat ini?
      //========================================================================
      state.tecDimanaKendaraanSekarang!.text = detail.lokasiKendaraanSaatIni ?? "";

      //autofill sisi kendaraan
      //========================================================================
      state.tecSisiKendaraanRusak!.text = detail.sisiKendaraanRusak ?? "";

      //autofill estimasi kendaraan
      //========================================================================
      state.tecEstimasiNilaiKerugian!.text = detail.estimasiKerugian.toString() ?? "0";

      //autofill radio pihak lain bertanggung jawab
      //========================================================================
      state.selected_opsiPihakLainBertanggungjawab = (detail.pihakLainBertanggungjawab == "1" ? state.opsiPihakLainBertanggungjawab[0] : state.opsiPihakLainBertanggungjawab[1]);
      state.tecNamaPihakLain!.text = detail.namaPihakLain ?? "";
      state.tecAlamatPihakLain!.text = detail.alamatPihakLain ?? "";
      state.tecAsuransiPihakLain!.text = detail.asuransiPihakLain ?? "";

      //autofill data pihak ketiga
      //========================================================================
      state.tecNamaPihakKetiga!.text = detail.namaPihakKetiga ?? "";
      state.tecAlamatPihakKetiga!.text = detail.alamatPihakKetiga ?? "";
      state.tecNomorhpPihakKetiga!.text = detail.nomorHpPihakKetiga ?? "";
      state.tecNamaAsuransiPihakKetiga!.text = detail.asuransiPihakKetiga ?? "";
      state.selected_opsiKerugianPihakketigaDiasuransikan = (detail.kerugianPihakKetigaDiasuransikan == "1" ? state.opsiKerugianPihakketigaDiasuransikan[0] : state.opsiKerugianPihakketigaDiasuransikan[1]);
      state.tecKronologiKejadian!.text = detail.kronologiKejadian ?? "";


      state.is_check_pernyataan = true;
      state.is_check_saya_bersedia = true;
      state.base64_tandatangan = detail.base64Tandatangan ?? "";

    }else{
      state.is_ada_riwayat = false;
      debugPrint("tidak ada data");
    }
    is_loading.value = false;
  }

  void setTglKejadian(DateTime date){
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    final String formatted = formatter.format(date);
    state.strTglKejadian = formatted;

    final DateFormat formatNormal = DateFormat('dd MMM yyyy hh:mm:ss');
    final String tglNormal = formatNormal.format(date);
    state.tecTglKejadian!.text = tglNormal;
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

  void setTglMasaBerlakuSIM(DateTime date){
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    state.strMasaBerlakuSIM = formatted;
    final DateFormat formatNormal = DateFormat('dd MMM yyyy');
    final String tglNormal = formatNormal.format(date);
    state.tecMasaBerlakuSIM!.text = tglNormal;
  }

  void tapTglMasaBerlakuSIM(BuildContext context){
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        onChanged: (date){
          setTglMasaBerlakuSIM(date);
        },
        onConfirm: (date){
          setTglMasaBerlakuSIM(date);
        },
        currentTime: DateTime.now(), locale: LocaleType.en
    );
  }

  void setDropdownTempatKejadian(String newValue){
    state.selected_dropdownTempatKejadian = newValue;
  }

  void setDropdownJenisSIM(String newValue){
    state.selected_dropdownJenisSIM = newValue;
  }

  void setOpsi_PengemudiBekerjaPadaTertanggung(String newValue){
    state.selected_opsiPengemudiBekerjaPadaTertanggung = newValue.toString();
    print(state.selected_opsiPengemudiBekerjaPadaTertanggung);
    update();
  }
  void setOpsi_PengemudiSepengetahuanTertanggung(String newValue){
    state.selected_opsiPengemudiSepengetahuanTertanggung = newValue.toString();
    print(state.selected_opsiPengemudiSepengetahuanTertanggung);
    update();
  }
  void setOpsi_PihaklainBertanggungjawab(String newValue){
    state.selected_opsiPihakLainBertanggungjawab = newValue.toString();
    print(state.selected_opsiPihakLainBertanggungjawab);
    update();
  }
  void setOpsi_KerugianPihakketigaDiasuransikan(String newValue){
    state.selected_opsiKerugianPihakketigaDiasuransikan = newValue.toString();
    if (newValue == Konstan.tag_ya){
      state.isEnableAsuransiPihakKetiga = true;
    }else{
      state.isEnableAsuransiPihakKetiga = false;
    }
    print(state.selected_opsiKerugianPihakketigaDiasuransikan);
    update();
  }
  void setOpsi_KejadianDilaporkanPolisi(String newValue){
    state.selected_opsiKejadianDilaporanPolisi = newValue.toString();
    newValue == Konstan.tag_ya
        ? state.isEnableKejadianDilaporkanPolisi = true
        : state.isEnableKejadianDilaporkanPolisi = false;
    print(state.selected_opsiKejadianDilaporanPolisi);
    update();
  }

  void handleCekKerugian(int index, bool newValue){
    List<String> hasilcek = List<String>.empty(growable: true);
    state.isCheckboxKerugian[index] = newValue;
    for (var i = 0; i < 3; i++) {
      if (state.isCheckboxKerugian[i] == true){
        hasilcek.add(state.checkboxKerugian[i]);
      }
    }
    state.strCheckboxKerugian = hasilcek.toString();
    print(state.strCheckboxKerugian);
    update();
  }
  void handleCekpernyataan(bool newValue) {
    state.is_check_pernyataan = newValue;
    update();
  }
  void handleCekSayaBersedia(bool newValue){
    state.is_check_saya_bersedia = newValue;
    update();
  }
  void clearSignature() {
    if (state.signatureGlobalKey != null){
      state.signatureGlobalKey!.currentState!.clear();
      state.base64_tandatangan = "";
    }
  }
  Future<String> handleSignature() async {
    if (state.base64_tandatangan.isNotEmpty){
      if (state.base64_tandatangan == Konstan.tag_file_tidak_ditemukan){
        state.base64_tandatangan = "";
        return state.base64_tandatangan;
      }else{
        return state.base64_tandatangan;
      }
    }else{
      final data = await state.signatureGlobalKey!.currentState!.toImage(pixelRatio: 2.0);
      final bytes = await data.toByteData(format: ImageByteFormat.png);
      final a = bytes!.buffer.asUint8List();
      state.base64_tandatangan = base64Encode(a);
      return state.base64_tandatangan;
    }
  }

  void submitClaimDetail() async {
    try{
      state.base64_tandatangan = await handleSignature();

      if (state.tecNomorPolisAsuransi!.text.isEmpty){
        Fungsi.warningToast("Nomor polis asuransi wajib diisi");
        return;
      }
      if (state.tecNamaTertanggung!.text.isEmpty){
        Fungsi.warningToast("Nama tertanggung wajib diisi");
        return;
      }
      if (state.tecAlamatTertanggung!.text.isEmpty){
        Fungsi.warningToast("Alamat tertanggung wajib diisi");
        return;
      }
      if (state.tecNomorhpTertanggung!.text.isEmpty){
        Fungsi.warningToast("Nomor hp tertanggung wajib diisi");
        return;
      }
      if (state.tecNamaPelapor!.text.isEmpty){
        Fungsi.warningToast("Nama pelapor wajib diisi");
        return;
      }
      if (state.tecAlamatPelapor!.text.isEmpty){
        Fungsi.warningToast("Alamat pelapor wajib diisi");
        return;
      }
      if (state.tecNomorhpPelapor!.text.isEmpty){
        Fungsi.warningToast("Nomor HP pelapor wajib diisi");
        return;
      }
      if (state.tecMerkTipeKendaraan!.text.isEmpty){
        Fungsi.warningToast("Merk/tipe kendaraan wajib diisi");
        return;
      }
      if (state.tecTahunPembuatan!.text.isEmpty){
        Fungsi.warningToast("Tahun pembuatan kendaraan wajib diisi");
        return;
      }
      if (state.tecNomorRangka!.text.isEmpty){
        Fungsi.warningToast("Nomor rangka wajib diisi");
        return;
      }
      if (state.tecNomorMesin!.text.isEmpty){
        Fungsi.warningToast("Nomor mesin wajib diisi");
        return;
      }
      if (state.tecNomorPolisi!.text.isEmpty){
        Fungsi.warningToast("Nomor plat kendaraan wajib diisi");
        return;
      }
      if (state.tecTglKejadian!.text.isEmpty){
        Fungsi.warningToast("Tanggal dan jam kejadian wajib diisi");
        return;
      }
      if (state.selected_dropdownTempatKejadian.isEmpty){
        Fungsi.warningToast("Tempat kejadian wajib diisi");
        return;
      }
      if (state.tecKronologiKejadian!.text.isEmpty){
        Fungsi.warningToast("Kronologi kejadian wajib diisi");
        return;
      }
      if (state.is_check_pernyataan == false){
        Fungsi.warningToast("Cek pernyataan wajib dicentang");
        return;
      }
      if (state.is_check_saya_bersedia == false){
        Fungsi.warningToast("Cek pengumpulan dokumen wajib dicentang");
        return;
      }
      // if (state.selected_opsiKerugianPihakketigaDiasuransikan == Konstan.tag_ya && state.tecNamaAsuransiPihakKetiga!.text.isEmpty){
      //   Fungsi.warningToast("Nama asuransi pihak ketiga wajib diisi");
      //   return;
      // }
      if (state.tipeKlaim == Konstan.tag_kecelakaan && state.tecDimanaKendaraanSekarang!.text.isEmpty){
        Fungsi.warningToast("Posisi kendaraan wajib diisi");
        return;
      }
      if (state.tipeKlaim == Konstan.tag_kecelakaan && state.tecSisiKendaraanRusak!.text.isEmpty){
        Fungsi.warningToast("Sisi kendaraan yang rusak wajib diisi");
        return;
      }
      if (state.tipeKlaim == Konstan.tag_kecelakaan && state.tecEstimasiNilaiKerugian!.text.isEmpty){
        Fungsi.warningToast("Estimasi kerugian kendaraan wajib diisi");
        return;
      }
      if (state.tipeKlaim == Konstan.tag_kecelakaan && state.tecNamaPihakLain!.text.isEmpty){
        Fungsi.warningToast("Nama pihak lain wajib diisi");
        return;
      }
      if (state.tipeKlaim == Konstan.tag_kecelakaan && state.tecAlamatPihakLain!.text.isEmpty){
        Fungsi.warningToast("Alamat pihak lain wajib diisi");
        return;
      }
      if (state.selected_opsiPihakLainBertanggungjawab == Konstan.tag_ya && state.tecAsuransiPihakLain!.text.isEmpty){
        Fungsi.warningToast("Nama asuransi pihak lain wajib diisi");
        return;
      }
      if (state.base64_tandatangan == "File tidak ditemukan"){
        Fungsi.errorToast("Tanda tangan belum ada (101)");
        return;
      }
      if (state.base64_tandatangan.isEmpty || state.base64_tandatangan == "" || state.base64_tandatangan.substring(0,150) == Konstan.tag_tandatangan_kosong.substring(0,150)) {
        Fungsi.errorToast("Tanda tangan belum ada (102)");
        return;
      }

      print("submit claim detail mpmi");

      //sebelum submit, siapin dulu detailnya dari argument
      state.modelFormAwal = Get.arguments["detail"];
      print("model formawal" + " " + state.modelFormAwal);
      var model = jsonDecode(state.modelFormAwal);
      final formawal = far.Data.fromJson(model);

      final strToken = await getTokenMpmi();

      final insuredDetail = InsuredDetail(
          contractNo: formawal.agreementNo,
          policyNo: state.tecNomorPolisAsuransi!.text,
          insuredName: state.tecNamaTertanggung!.text,
          insuredAddress: state.tecAlamatTertanggung!.text,
          insuredPhone: state.tecNomorhpTertanggung!.text,
          email: state.tecEmailTertanggung!.text,
          sign: state.base64_tandatangan
      );
      final claimantDetail = ClaimantDetail(
          claimantName: state.tecNamaPelapor!.text,
          claimantAddress: state.tecAlamatPelapor!.text,
          claimantPhone: state.tecNomorhpPelapor!.text,
          claimantEmail: state.tecEmailPelapor!.text,
          claimantRelationship: state.tecHubunganDenganTertanggung!.text
      );
      final vehicleDetail = VehicleDetail(
          brandType: state.tecMerkTipeKendaraan!.text,
          manufactureYear: int.parse(state.tecTahunPembuatan!.text),
          chassisNo: state.tecNomorRangka!.text,
          machineNo: state.tecNomorMesin!.text,
          plateNo: state.tecNomorPolisi!.text
      );
      final incidentDetail = IncidentDetail(
          dateOfIncident: state.strTglKejadian.replaceAll(" ", "T"),
          incidentLocation: state.selected_dropdownTempatKejadian,
          speed: state.tecKecepatanSaatKejadian!.text.isEmpty ? 0 : int.parse(state.tecKecepatanSaatKejadian!.text.replaceAll(".", "").replaceAll(",", "")),
          driverName: state.tecNamaPengemudi!.text,
          driverAddress: state.tecAlamatPengemudi!.text,
          sIMType: state.selected_dropdownJenisSIM,
          sIMNo: state.tecNomorSIM!.text,
          sIMExp: state.tecMasaBerlakuSIM!.text.isEmpty ? "1900-01-01T00:00:00" : state.tecMasaBerlakuSIM!.text.replaceAll(" ", "T"),
          isDriverOfInsured: state.selected_opsiPengemudiBekerjaPadaTertanggung == Konstan.tag_ya ? true : false,
          isDrivingAsInsuredOrder: state.selected_opsiPengemudiSepengetahuanTertanggung == Konstan.tag_ya ? true : false,
          vehicleUsageOnIncident: state.tecPenggunaanKendaraanSaatKejadian!.text,
          isReportedToPolice: state.selected_opsiKejadianDilaporanPolisi == Konstan.tag_ya ? true : false,
          policeLocation: state.selected_opsiKejadianDilaporanPolisi,
          chronology: state.tecKronologiKejadian!.text
      );
      final detailOfLoss = DetailOfLoss(
          vehicleLocation: state.tecDimanaKendaraanSekarang!.text,
          vehicleDamageDescription: state.tecSisiKendaraanRusak!.text,
          estimatedLoss: state.tecEstimasiNilaiKerugian!.text.isEmpty ? 0 : int.parse(state.tecEstimasiNilaiKerugian!.text.replaceAll(",", "").replaceAll(".", "")),
          isAnotherPersonInvolved: state.selected_opsiPihakLainBertanggungjawab == Konstan.tag_ya ? true : false,
          involvedPersonName: state.tecNamaPihakLain!.text,
          involvedPersonAddress: state.tecAlamatPihakLain!.text,
          involvedPersonInsurance: state.tecAsuransiPihakLain!.text
      );
      final thirdPartyDetail = ThirdPartyDetail(
          thirdPartyName: state.tecNamaPihakKetiga!.text,
          thirdPartyAddress: state.tecAlamatPihakKetiga!.text,
          thirdPartyPhone: state.tecNomorhpPihakKetiga!.text,
          thirdPartyLoss: state.kerugianPihakKetiga,
          thirdPartyInsurance: state.selected_opsiKerugianPihakketigaDiasuransikan == Konstan.tag_ya ? true : false,
          thirdPartyInsuranceName: state.tecNamaAsuransiPihakKetiga!.text
      );
      final documentDetail = DocumentDetail(
          sTPL: ""
      );

      var listInsuredDetail = List<InsuredDetail>.empty(growable: true);
      listInsuredDetail.add(insuredDetail);
      var listClaimantDetail = List<ClaimantDetail>.empty(growable: true);
      listClaimantDetail.add(claimantDetail);
      var listVehicleDetail = List<VehicleDetail>.empty(growable: true);
      listVehicleDetail.add(vehicleDetail);
      var listIncidentDetail = List<IncidentDetail>.empty(growable: true);
      listIncidentDetail.add(incidentDetail);
      var listDetailofLoss = List<DetailOfLoss>.empty(growable: true);
      listDetailofLoss.add(detailOfLoss);
      var listThirdPartyDetail = List<ThirdPartyDetail>.empty(growable: true);
      listThirdPartyDetail.add(thirdPartyDetail);
      var listDocumentDetail = List<DocumentDetail>.empty(growable: true);
      listDocumentDetail.add(documentDetail);

      final request = MpmiSubmitClaimDetail(
          insuredDetail: listInsuredDetail,
          claimantDetail: listClaimantDetail,
          vehicleDetail: listVehicleDetail,
          incidentDetail: listIncidentDetail,
          detailOfLoss: listDetailofLoss,
          thirdPartyDetail: listThirdPartyDetail,
          documentDetail: listDocumentDetail,
          token: strToken
      );

      //setelah inputan jadi json, kirimkan ke screen upload sttlp
      //nanti diselipin di function submitJMCare()
      //buat dilempar ke next screen => pick sttlp
      state.strMpmiSubmitClaimDetailRequest = jsonEncode(request);
      submitJMCare();
    } on Exception catch(e){
      Fungsi.errorToast('$e');
    }

  }

  void submitJMCare() async {

    //cari login user id di session
    final auth = await getStorage<LoginRespon>();
    final login_user_id = auth.data!.loginUserId;

    //semua inputan dijadikan json dulu
    final request = FormlanjutRequest(
      idFormawal:int.parse(state.id_form_awal),
      loginUserId: int.parse(login_user_id!),
      nomorPolisAsuransi: state.tecNomorPolisAsuransi!.text,
      namaTertanggung: state.tecNamaTertanggung!.text,
      alamatTertanggung: state.tecAlamatTertanggung!.text,
      nomorHpTertanggung: state.tecNomorhpTertanggung!.text,
      emailTertanggung: state.tecEmailTertanggung!.text,
      namaPelapor: state.tecNamaPelapor!.text,
      alamatPelapor: state.tecAlamatPelapor!.text,
      nomorHpPelapor: state.tecNomorhpPelapor!.text,
      emailPelapor: state.tecEmailPelapor!.text,
      hubunganDenganTertanggung: state.tecHubunganDenganTertanggung!.text,
      merkKendataan: state.tecMerkTipeKendaraan!.text,
      tahunPembuatan: state.tecTahunPembuatan!.text,
      nomorRangka: state.tecNomorRangka!.text,
      nomorMesin: state.tecNomorMesin!.text,
      nomorPlat: state.tecNomorPolisi!.text,
      tanggalKejadian: state.strTglKejadian,
      tempatKejadian: state.selected_dropdownTempatKejadian,
      kecepatanSaatKejadian: state.tecKecepatanSaatKejadian!.text.isEmpty ? "0" : (state.tecKecepatanSaatKejadian!.text.replaceAll(",", "").replaceAll(".", "")),
      namaPengemudi: state.tecNamaPengemudi!.text,
      alamatPengemudi: state.tecAlamatPengemudi!.text,
      jenisSim: state.selected_dropdownJenisSIM,
      nomorSim: state.tecNomorSIM!.text,
      masaBerlakuSim: state.strMasaBerlakuSIM,
      pengemudiBekerjaKpdTertanggung: state.selected_opsiPengemudiBekerjaPadaTertanggung == Konstan.tag_ya ? "1" : "0",
      pengemudiSepengetahuanTertanggung: state.selected_opsiPengemudiSepengetahuanTertanggung == Konstan.tag_ya ? "1" :"0",
      penggunaanKendaraanKejadian: state.tecPenggunaanKendaraanSaatKejadian!.text,
      dilaporkanKePolisi: state.selected_opsiKejadianDilaporanPolisi == Konstan.tag_ya ? "1" : "0",
      namaPolsek: state.tecNamaPolsek!.text,
      lokasiKendaraanSaatIni: state.tecDimanaKendaraanSekarang!.text,
      sisiKendaraanRusak: state.tecSisiKendaraanRusak!.text,
      estimasiKerugian: state.tecEstimasiNilaiKerugian!.text.isEmpty ? 0 : int.parse(state.tecEstimasiNilaiKerugian!.text.replaceAll(".", "").replaceAll(",", "")),
      pihakLainBertanggungjawab: state.selected_opsiPihakLainBertanggungjawab == Konstan.tag_ya ? "1" : "0",
      namaPihakLain: state.tecNamaPihakLain!.text,
      alamatPihakLain: state.tecAlamatPihakLain!.text,
      asuransiPihakLain: state.tecAsuransiPihakLain!.text,
      namaPihakKetiga: state.tecNamaPihakKetiga!.text,
      alamatPihakKetiga: state.tecAlamatPihakKetiga!.text,
      nomorHpPihakKetiga: state.tecNomorhpPihakKetiga!.text,
      kerugianPihakKetiga: state.kerugianPihakKetiga,
      kerugianPihakKetigaDiasuransikan: state.selected_opsiKerugianPihakketigaDiasuransikan == Konstan.tag_ya ? "1" : "0",
      asuransiPihakKetiga: state.tecNamaAsuransiPihakKetiga!.text,
      kronologiKejadian: state.tecKronologiKejadian!.text,
      stplKepolisian: "",
      tandatangan: state.base64_tandatangan
    );

    //setelah inputan jadi json, kirimkan ke screen upload sttlp
    final detail = jsonEncode(request);
    Get.toNamed(Konstan.rute_klaimasuransi_upload_sttlp,
        arguments: {
          "detail":detail,  //ini model request yang mau disimpan di db jmcare
          "mpmirequest":state.strMpmiSubmitClaimDetailRequest //ini model request yang mau dilempar ke api mpmi
      }
    );

  }
}