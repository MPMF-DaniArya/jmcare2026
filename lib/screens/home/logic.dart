import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/CekRegistrasiesignRequest.dart';
import 'package:jmcare/model/api/CekRegistrasiesignRespon.dart';
import 'package:jmcare/model/api/GradeRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/ProdukRespon.dart';
import 'package:jmcare/model/api/PromoRespon.dart';
import 'package:jmcare/model/api/SlideshowRespon.dart';
import 'package:jmcare/model/api/VersiRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/home/state.dart';
import 'package:jmcare/service/CekRegistrasiesignService.dart';
import 'package:jmcare/service/CekpengkiniandataService.dart';
import 'package:jmcare/service/GradeService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/VersiService.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../model/api/VersiModel.dart';
import '../../service/DeleteakunService.dart';
import '../../service/SlideService.dart';

class HomeLogic extends BaseLogic {
  final HomeState state = HomeState();
  var sdhLogin = false.obs;
  var indeksCarousel = 0.obs;
  var grade = "".obs;
  var point = "0".obs;
  var loading_grade = false.obs;
  var nama_user = "".obs;
  var icon_jenis_member = "".obs;
  var arraySlideshow = SlideshowRespon().obs;
  var jmlArraySlideshow = 0.obs;
  var jmlProduk = 0.obs;
  var jmlPromo = 0.obs;
  var arrayProduk = ProdukRespon().obs;
  var arrayPromo = PromoRespon().obs;
  var is_loading_pengkiniandata = false.obs;
  var obsSwitch = false.obs;

  @override
  void onInit() async {
    super.onInit();
    is_loading.value = true;
    checkIsLogin();

    getSlides();
    getGrade();

    if (Platform.isAndroid){
      cekVersi();
    }
  }

  void changeTheme(bool newValue){
    obsSwitch.value = newValue;
    Get.changeTheme(
      Get.isDarkMode
          ? ThemeData(
              useMaterial3:  false,
              primarySwatch: Colors.green,
              fontFamily: 'Nexa',
              brightness: Brightness.light
            )
          : ThemeData(
              useMaterial3: false,
              primarySwatch: Colors.green,
              fontFamily: 'Nexa',
              brightness: Brightness.dark
            )
    );
  }

  void klikGantiPassword(){
    Get.toNamed(Konstan.rute_gantipassword);
  }

  void klikJaringanKami(){
    Get.toNamed(Konstan.rute_list_cabang);
  }

  void klikPengkinianData() async {
    Get.toNamed(Konstan.rute_menu_pengkinian_data);
  }

  void klikAgreementCard() {
    Get.toNamed(Konstan.rute_pilih_no_kontrak, arguments: {'detail': Konstan.rute_agreement_card});
  }

  void klikeContract(){
    Get.toNamed(Konstan.rute_pilih_no_kontrak, arguments: {Konstan.tag_detail: Konstan.rute_eContract});
  }

  void klikAntrianOnline(){
    Get.toNamed(Konstan.rute_antrian, arguments: {Konstan.tag_selected_index: 0});
  }

  void klikEpolis(){
    Get.toNamed(Konstan.rute_pilih_no_kontrak, arguments: {'detail': Konstan.rute_epolis});
  }

  void klikLayananPengaduan() {
    Get.toNamed(Konstan.rute_layanan_pengaduan);
  }

  void klikKlaimAsuransi(){
    Get.toNamed(Konstan.rute_pilih_no_kontrak, arguments: {'detail': Konstan.rute_klaim_asuransi});
    // Get.toNamed(Konstan.rute_klaimasuransi_agreementinsco);
  }

  void klikFAQ(){
    Get.toNamed(Konstan.rute_faq);
  }

  void klikNotifikasi(){
    Get.toNamed(Konstan.rute_onesignal_notif);
  }

  void klikEsignHome(){
    Get.toNamed(Konstan.rute_esign_home);
    // Get.toNamed(Konstan.rute_klaimasuransi_agreementinsco);
  }

  void klikStatusKlaimAsuransi() async {
    Get.toNamed(Konstan.rute_klaimasuransi_riwayat_formawal);
  }

  void klikMenuMService(BuildContext context) async {
    //get login dari session
    final authStorage = await getStorage<LoginRespon>();

    if (authStorage.data == null || authStorage.data!.code == "0") {
      // Fungsi.toastBelumLogin();
      Get.bottomSheet(FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            decoration:
            BoxDecoration(border: Border.all(color: Colors.black12), color: Colors.white, borderRadius: const BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))),
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: [
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.4,
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                    ),
                  ),
                ),

                state.isDebitur == "1" ? const Divider() : Container(),
                ListTile(
                  leading: Image.asset(
                    'assets/images/selfservice.png',
                    width: 50,
                    height: 50,
                  ),
                  title: const Text("Antrian Online"),
                  trailing: const Icon(Icons.arrow_right),
                  subtitle: const Text("Sistem reservasi nomor antrian loket pendaftaran secara online"),
                  onTap: () => Get.offNamed(Konstan.rute_antrian, arguments: {Konstan.tag_selected_index: 0}),
                  // onTap: () => Fungsi.warningToast("Menu belum tersedia"),
                ),
              ],
            ),
          )));

    } else {
      //kalo sdh login, cek apakah debitur atau bukan
      //cek apakah yang login itu debitur atau bukan
      state.isDebitur = authStorage.data!.jenisdebitur!.replaceAll(" ", "");
      Get.bottomSheet(FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            decoration:
            BoxDecoration(border: Border.all(color: Colors.black12), color: Colors.white, borderRadius: const BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))),
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: [
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.4,
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                state.isDebitur == "1" //kalo yg login debitur, tampilkan menu agreement card
                    ? ListTile(
                  leading: Image.asset(
                    'assets/images/selfservice.png',
                    width: 50,
                    height: 50,
                  ),
                  title: const Text("Agreement Card"),
                  trailing: const Icon(Icons.arrow_right),
                  subtitle: const Text("Lihat agreement card berdasarkan nomor kontrak"),
                  onTap: () => Get.offNamed(Konstan.rute_pilih_no_kontrak, arguments: {'detail': Konstan.rute_agreement_card}),
                )
                    : Container(),
                state.isDebitur == "1" ? const Divider() : Container(),
                ListTile(
                  leading: Image.asset(
                    'assets/images/selfservice.png',
                    width: 50,
                    height: 50,
                  ),
                  title: const Text("Antrian Online"),
                  trailing: const Icon(Icons.arrow_right),
                  subtitle: const Text("Sistem reservasi nomor antrian loket pendaftaran secara online"),
                  onTap: () => Get.offNamed(Konstan.rute_antrian, arguments: {Konstan.tag_selected_index: 0}),
                  // onTap: () => Fungsi.warningToast("Menu belum tersedia"),
                ),
                state.isDebitur == "1" ? const Divider() : Container(),
                state.isDebitur == "1" //kalo yg login debitur, tampilkan menu epolis
                    ? ListTile(
                  leading: Image.asset(
                    'assets/images/selfservice.png',
                    width: 50,
                    height: 50,
                  ),
                  trailing: const Icon(Icons.arrow_right),
                  title: const Text("E-Polis"),
                  subtitle: const Text("Unduh epolis Anda dalam format PDF"),
                  onTap: () => Get.offNamed(Konstan.rute_pilih_no_kontrak, arguments: {'detail': Konstan.rute_epolis}),
                )
                    : Container()
              ],
            ),
          )));
    }
  }

  void klikMenuSelfService(BuildContext context) async {
    final authStorage = await getStorage<LoginRespon>();
    if (authStorage.data == null) {
      Fungsi.toastBelumLogin();
    } else {
      state.isDebitur = authStorage.data!.jenisdebitur!.replaceAll(" ", "");
      Get.bottomSheet(FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            decoration:
            BoxDecoration(border: Border.all(color: Colors.black12), color: Colors.white, borderRadius: const BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))),
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: [
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.4,
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                ListTile(
                  leading: Image.asset(
                    'assets/images/selfservice.png',
                    width: 50,
                    height: 50,
                  ),
                  title: const Text("Jaringan Kami"),
                  trailing: const Icon(Icons.arrow_right),
                  subtitle: const Text("Lihat daftar semua kantor cabang"),
                  onTap: () => Get.offNamed(Konstan.rute_list_cabang),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),

                state.isDebitur == "1" ?
                ListTile(
                  leading: Image.asset(
                    'assets/images/selfservice.png',
                    width: 50,
                    height: 50,
                  ),
                  title: const Text("Pengkinian Data"),
                  trailing: is_loading.value ? const CircularProgressIndicator() : const Icon(Icons.arrow_right),
                  subtitle: const Text("Pembaharuan data Anda terkini"),
                  onTap: () {
                    //cek apakah sudah melakukan pengkinian data/belum?
                    // cekPengkinianData();
                    Fungsi.warningToast("Menu belum tersedia");
                  },
                ):Container(),

                state.isDebitur == "1" ?
                const Padding(padding: EdgeInsets.only(top: 20)) : Container(),

                state.isDebitur == "1" ?
                ListTile(
                  leading: Image.asset(
                    'assets/images/selfservice.png',
                    width: 50,
                    height: 50,
                  ),
                  title: const Text("eSignHub"),
                  trailing: const Icon(Icons.arrow_right),
                  subtitle: const Text("Tanda tangan elektronik"),
                  onTap: () {
                    Get.offNamed(Konstan.rute_esign_home);
                  },
                ):Container()
              ],
            ),
          )));
    }
  }

  Future<bool> deleteAkun() async {
    final authStorage = await getStorage<LoginRespon>();
    var id = authStorage.data!.loginUserId;
    final baseRespon = await getService<DeleteakunService>()?.deleteAkun(id!);
    if (baseRespon is BaseError || baseRespon == null) {
      return false;
    } else {
      if (baseRespon?.code == "200" || baseRespon?.message == 'Success') {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool?> dialogDeleteAkun(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus akun'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah Anda yakin akan menghapus akun Anda?'),
              ],
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
              child: const Text('TIDAK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            ElevatedButton(
              child: const Text('YA'),
              onPressed: () async {
                //hit api
                final hasil = await deleteAkun();
                if (hasil == true) {
                  Fungsi.suksesToast("Akun berhasil dihapus!");
                  //clear session
                  clearSP();
                  //restart aplikasi ke splash screen
                  Get.offNamedUntil(Konstan.rute_splash, (route) => false);
                } else {
                  Fungsi.errorToast("Akun gagal dihapus!");
                  Navigator.of(context).pop(true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void hapusAkunPermanen() {
    deleteAkun();
  }

  void gotoHistoripoin() {
    Get.toNamed(Konstan.rute_histori_poin);
  }

  void gotoPaginationuser() {
    Get.toNamed(Konstan.rute_pagination_user);
  }

  void clickBadgeUser() async {
    final loginStorage = await getStorage<LoginRespon>();
    bool is_admin = loginStorage.data!.isAdmin! == "1";
    if (is_admin) {
      gotoPaginationuser();
    } else {
      // gotoHistoripoin();
    }
  }

  void cekRegistrasiEsign() async {
    is_loading.value = true;
    final loginStorage = await getStorage<LoginRespon>();
    final String noKTP = loginStorage.data!.noKtp!;
    var audit = Audit(callerId: Endpoint.TAG_ESIGN_CALLER_ID);

    var body = CekRegistrasiesignRequest(audit: audit, dataType: "NIK", userData: noKTP);
    final cekRegistrasi = await getService<CekRegistrasiesignService>()?.cekRegistrasi(noKTP);
    if (cekRegistrasi is CekregistrasiesignError || cekRegistrasi == null) {
      Fungsi.errorToast("Gagal cek registrasi Esign!");
    } else {
      if (cekRegistrasi!.status!.code! == 0) {
        print("sudah register");
        Get.offAndToNamed(Konstan.rute_esign);
      } else {
        print("belum register");
        Get.offAndToNamed(Konstan.rute_esign_invitation);
      }
    }
    is_loading.value = false;
  }

  void getGrade() async {
    loading_grade.value = true;
    //get no ktp dari session
    final loginRespon = await getStorage<LoginRespon>();
    state.noKTP = loginRespon.data!.noKtp!;
    nama_user.value = Fungsi.splitNamaUser(loginRespon.data!.namaUser!);
    final gradeRespon = await getService<GradeService>()?.getGrade(state.noKTP);
    loading_grade.value = false;
    if (gradeRespon == null){
      grade.value = "";
      point.value = "0";
    }else{
      if (gradeRespon is GradeError) {
        grade.value = "";
        point.value = "0";
      } else {
        var data = gradeRespon.data!.first;
        grade.value = data.grade!;
        point.value = data.point!.toString().isEmpty ? '0' : Fungsi.formatNumber(data.point!, 0);
      }
    }
    //simpan grade dan point di session
    baseSaveStorage<GradeRespon>(gradeRespon);
    //set image dan point
    if (grade.value.toLowerCase() == Konstan.tag_gold) {
      icon_jenis_member.value = "assets/images/gold.png";
    } else if (grade.value.toLowerCase() == Konstan.tag_bronze) {
      icon_jenis_member.value = "assets/images/bronze.png";
    } else if (grade.value.toLowerCase() == Konstan.tag_silver) {
      icon_jenis_member.value = "assets/images/platinum.png";
    } else if (grade.value.toLowerCase() == Konstan.tag_platinum) {
      icon_jenis_member.value = "assets/images/platinum.png";
    } else {
      icon_jenis_member.value = "";
    }
    debugPrint('icon jenis member ' + icon_jenis_member.value.toString());

  }

  void checkIsLogin() async {
    is_loading.value = true;
    final storageAuth = await getStorage<LoginRespon>();
    if (storageAuth.data?.loginUserId != null) {
      //cek jika login user id-nya 68 atau si ANIK
      //set obsAppleVisibility jadi true
      //karena menu pengkinian data disorot sama Apple dan direject karena
      //menu pengkinian data hanya bisa diklik kalau cabang sudah insert data debitur
      //ke mysystem
      //ini cuma di iPhone/iOS saja ya...
      if (storageAuth.data!.loginUserId!.replaceAll(" ", "") == "68"){
        obsAppleVisibility.value = true;
      }else{
        obsAppleVisibility.value = false;
      }
      // debugPrint( "login userid " + storageAuth.data!.loginUserId!);
      sdhLogin.value = true;
      //ask permission kalo sdh login
      askPermission();
      state.isDebitur = storageAuth.data!.jenisdebitur!.removeAllWhitespace;
    } else {
      sdhLogin.value = false;
    }
    is_loading.value = false;
    debugPrint('sdh login ' + sdhLogin.value.toString());
  }

  void getSlides() async {
    is_loading.value = true;
    //get slideshow
    var slideshow = await getService<SlideService>()?.getSlideshow();
    if (slideshow != null){
      if (slideshow is SlideshowError || slideshow?.data?.length == 0) {
        Fungsi.errorToast("Error get slide data");
        jmlArraySlideshow.value = 0;
      } else {
        arraySlideshow.value = slideshow;
        jmlArraySlideshow.value = slideshow.data!.length;
      }
    }else{
      Fungsi.koneksiError();
      jmlArraySlideshow.value = 0;
    }

    is_loading.value = false;

    //get slide produk
    is_loading.value = true;
    var produks = await getService<SlideService>()?.getSlideProduk();
    if (produks == null){
      jmlProduk.value = 0;
    }else{
      if (produks is ProdukError || produks?.data?.length == 0) {
        // Fungsi.koneksiError();
        jmlProduk.value = 0;
      } else {
        arrayProduk.value = produks;
        jmlProduk.value = produks.data!.length;
      }
    }

    is_loading.value = false;

    is_loading.value = true;
    //get slide promo
    var promos = await getService<SlideService>()?.getSlidePromo();
    if (promos == null){
      jmlPromo.value = 0;
      // Fungsi.koneksiError();
    }else{
      if (promos is PromoError) {
        Fungsi.errorToast("Error memproses data!");
        jmlPromo.value = 0;
      } else {
        arrayPromo.value = promos;
        jmlPromo.value = promos.data!.length;
      }
    }

    is_loading.value = false;
  }

  void setIndeksCarousel(int value) {
    indeksCarousel.value = value;
  }

  void showDetailSlide(String detail) {
    debugPrint("detail " + detail);
  }

}