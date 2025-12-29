import 'package:flutter/material.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class FormlanjutState {

  String id_form_awal = "";
  String modelFormAwal = "";
  String sayaBersedia = Konstan.tag_saya_bersedia_memenuhi_dokumen;
  GlobalKey<SfSignaturePadState>? signatureGlobalKey;

  TextEditingController? tecNomorPolisAsuransi;
  TextEditingController? tecNamaTertanggung;
  TextEditingController? tecAlamatTertanggung;
  TextEditingController? tecNomorhpTertanggung;
  TextEditingController? tecEmailTertanggung;

  TextEditingController? tecNamaPelapor;
  TextEditingController? tecAlamatPelapor;
  TextEditingController? tecNomorhpPelapor;
  TextEditingController? tecEmailPelapor;
  TextEditingController? tecHubunganDenganTertanggung;

  TextEditingController? tecMerkTipeKendaraan;
  TextEditingController? tecTahunPembuatan;
  TextEditingController? tecNomorRangka;
  TextEditingController? tecNomorMesin;
  TextEditingController? tecNomorPolisi;
  TextEditingController? tecTglKejadian;
  String tempatKejadian = "";
  TextEditingController? tecKecepatanSaatKejadian;
  TextEditingController? tecNamaPengemudi;
  TextEditingController? tecAlamatPengemudi;
  TextEditingController? tecNomorSIM;
  TextEditingController? tecMasaBerlakuSIM;
  bool? isPengemudiBekerjaPadaTertanggung;
  bool? isPengemudiSepengetahuanTertanggung;
  TextEditingController? tecPenggunaanKendaraanSaatKejadian;
  bool? isDilaporakanKepolisian;
  TextEditingController? tecNamaPolsek;
  TextEditingController? tecDimanaKendaraanSekarang;
  TextEditingController? tecSisiKendaraanRusak;
  TextEditingController? tecEstimasiNilaiKerugian;
  bool? isAdaPihakLainBertanggungjawab;
  TextEditingController? tecNamaPihakLain;
  TextEditingController? tecAlamatPihakLain;
  TextEditingController? tecAsuransiPihakLain;
  TextEditingController? tecNamaPihakKetiga;
  TextEditingController? tecAlamatPihakKetiga;
  TextEditingController? tecNomorhpPihakKetiga;
  String kerugianPihakKetiga = "";
  bool? isPihakKetigaDiasuransikan;
  TextEditingController? tecNamaAsuransiPihakKetiga;
  TextEditingController? tecKronologiKejadian;
  String tecTandaTangan = "";
  bool? intialExpand = true;
  bool? isEnableAsuransiPihakKetiga = true;
  bool? isEnableKejadianDilaporkanPolisi = true;

  String base64_tandatangan = "";
  String strTglKejadian = "";
  String strMasaBerlakuSIM = "";
  var dropdownTempatKejadian = List<DropdownMenuItem>.empty(growable: true);
  String selected_dropdownTempatKejadian = "Di rumah";
  var dropdownJenisSIM = List<DropdownMenuItem>.empty(growable: true);
  String selected_dropdownJenisSIM = "SIM A";

  List<String> opsiPengemudiBekerjaPadaTertanggung = [Konstan.tag_ya, Konstan.tag_tidak];
  String selected_opsiPengemudiBekerjaPadaTertanggung = Konstan.tag_ya;
  List<String> opsiPengemudiSepengetahuanTertanggung = [Konstan.tag_ya, Konstan.tag_tidak];
  String selected_opsiPengemudiSepengetahuanTertanggung = Konstan.tag_ya;
  List<String> opsiPihakLainBertanggungjawab = [Konstan.tag_ya, Konstan.tag_tidak];
  String selected_opsiPihakLainBertanggungjawab = Konstan.tag_ya;
  List<String> opsiKerugianPihakketigaDiasuransikan = [Konstan.tag_ya, Konstan.tag_tidak];
  String selected_opsiKerugianPihakketigaDiasuransikan = Konstan.tag_ya;
  List<String> opsiKejadianDilaporanPolisi = [Konstan.tag_ya, Konstan.tag_tidak];
  String selected_opsiKejadianDilaporanPolisi = Konstan.tag_ya;

  List<String> checkboxKerugian = ["Kendaraan","Harta benda","Korban jiwa"];
  List<bool> isCheckboxKerugian = [false, false, false];
  String strCheckboxKerugian = "";
  String strMpmiSubmitClaimDetailRequest = "";

  String title_pernyataan = Konstan.tag_bersedia;

  bool? is_check_pernyataan = false;
  bool? is_check_saya_bersedia = false;
  String tipeKlaim = "";
  bool is_ada_riwayat = false;

  FormlanjutState(){

    tecNomorPolisAsuransi = TextEditingController();
    tecNamaTertanggung = TextEditingController();
    tecAlamatTertanggung = TextEditingController();
    tecNomorhpTertanggung = TextEditingController();
    tecEmailTertanggung = TextEditingController();

    tecNamaPelapor = TextEditingController();
    tecAlamatPelapor = TextEditingController();
    tecNomorhpPelapor = TextEditingController();
    tecEmailPelapor = TextEditingController();
    tecHubunganDenganTertanggung = TextEditingController();

    tecMerkTipeKendaraan = TextEditingController();
    tecTahunPembuatan = TextEditingController();
    tecNomorRangka = TextEditingController();
    tecNomorMesin = TextEditingController();
    tecNomorPolisi = TextEditingController();

    tecTglKejadian = TextEditingController();
    tempatKejadian = "";
    tecKecepatanSaatKejadian = TextEditingController();
    tecNamaPengemudi = TextEditingController();
    tecAlamatPengemudi = TextEditingController();

    tecNomorSIM = TextEditingController();
    tecMasaBerlakuSIM = TextEditingController();
    isPengemudiBekerjaPadaTertanggung = false;
    isPengemudiSepengetahuanTertanggung = false;
    tecPenggunaanKendaraanSaatKejadian = TextEditingController();
    isDilaporakanKepolisian = false;
    tecNamaPolsek = TextEditingController();

    tecDimanaKendaraanSekarang = TextEditingController();
    tecSisiKendaraanRusak = TextEditingController();
    tecEstimasiNilaiKerugian = TextEditingController();

    isAdaPihakLainBertanggungjawab = false;
    tecNamaPihakLain = TextEditingController();
    tecAlamatPihakLain = TextEditingController();
    tecAsuransiPihakLain = TextEditingController();

    tecNamaPihakKetiga = TextEditingController();
    tecAlamatPihakKetiga = TextEditingController();
    tecNomorhpPihakKetiga = TextEditingController();
    kerugianPihakKetiga = "";
    isPihakKetigaDiasuransikan = false;
    tecNamaAsuransiPihakKetiga = TextEditingController();

    tecKronologiKejadian = TextEditingController();
    tecTandaTangan = "";

    dropdownTempatKejadian.add(const DropdownMenuItem(value: "Di rumah", child: Text("Di rumah")));
    dropdownTempatKejadian.add(const DropdownMenuItem(value: "Di tempat parkir", child: Text("Di tempat parkir")));
    dropdownTempatKejadian.add(const DropdownMenuItem(value: "Dicuri", child: Text("Dicuri")));

    dropdownJenisSIM.add(const DropdownMenuItem(value: "SIM A", child: Text("SIM A")));
    dropdownJenisSIM.add(const DropdownMenuItem(value: "SIM B1", child: Text("SIM B1")));
    dropdownJenisSIM.add(const DropdownMenuItem(value: "SIM B2", child: Text("SIM B2")));
    dropdownJenisSIM.add(const DropdownMenuItem(value: "SIM C", child: Text("SIM C")));
    dropdownJenisSIM.add(const DropdownMenuItem(value: "SIM D", child: Text("SIM D")));

    signatureGlobalKey = GlobalKey();
  }
}