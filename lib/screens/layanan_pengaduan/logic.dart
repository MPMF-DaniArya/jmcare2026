import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart';
import 'package:jmcare/screens/layanan_pengaduan/state.dart';
import 'package:jmcare/service/LayananPengaduanSubmitFormService.dart';

import '../../helper/Fungsi.dart';
import '../../helper/Konstan.dart';
import '../../model/api/LoginRespon.dart';
import '../../service/PilihkontrakService.dart';
import '../../service/Service.dart';
import '../../storage/storage.dart';
import '../base/base_logic.dart';

class LayananPengaduanLogic extends BaseLogic {
  final LayananPengaduanState state = LayananPengaduanState();
  var ddNomorKontrak = <DropdownMenuItem<String>>[].obs;
  var idxDdNomorKontrak = ''.obs;
  var pilihKontrak = PilihkontrakRespon().obs;
  var realKontrak = PilihkontrakRespon();
  String jenisDebitur = '';
  var isDebitur = false.obs;
  var jmlRow = 0.obs;
  int user_id = 0;
  String nama = '';
  String noHp = '';
  String email = '';
  File? gambarDipilih;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getListKontrak();

    getDetailUser();
  }

  void getDetailUser() async {
    final authStorage = await getStorage<LoginRespon>();
    if (authStorage.data != null) {
      if (authStorage.data!.code != "0") {
        jenisDebitur = authStorage.data!.jenisdebitur!;
        nama = authStorage.data!.namaUser!;
        noHp = authStorage.data!.noHp!;
        email = authStorage.data!.email!;
        user_id = int.tryParse(authStorage.data!.loginUserId!)!;
        state.tecNamaLengkap!.text = nama;
        state.tecNoHp!.text = noHp;
        state.tecEmail!.text = email;

        if (jenisDebitur.replaceAll(" ", "") == "1") {
          isDebitur.value = true;
        } else {
          isDebitur.value = false;
        }
        print(isDebitur.value);
      }
    }
  }

  void getListKontrak() async {
    is_loading.value = true;
    final authStorage = await getStorage<LoginRespon>();
    if (authStorage.data != null) {
      if (authStorage.data!.code != "0") {
        final String noKTP = authStorage.data!.noKtp!;
        final respon =
            await getService<PilihkontrakService>()?.getListKontrak(noKTP);
        if (respon is PilihkontrakError || respon == null) {
          Fungsi.errorToast("Tidak dapat menampilkan nomor kontrak!");
          jmlRow.value = 0;
        } else {
          pilihKontrak.value = respon;
          realKontrak.data = respon.data;
          jmlRow.value = realKontrak.data!.length;

          ddNomorKontrak.clear();

          //get array pertama, untuk get nomor kontrak pertama
          //asign pada var idxDdNomorKontrak
          if (realKontrak.data!.isNotEmpty) {
            final kontrakPertama = realKontrak.data!.first;
            idxDdNomorKontrak.value = kontrakPertama.aGRMNTNO!;
            state.tecNamaLengkap!.text = kontrakPertama.cUSTFULLNAME!;
            state.tecNoPlat!.text = kontrakPertama.pLATNO!;
            state.tecTipeUnit!.text = kontrakPertama.merkType!;
          }

          //tambahkan ke dropdown
          realKontrak.data?.forEach((e) {
            ddNomorKontrak.add(
                DropdownMenuItem(value: e.aGRMNTNO, child: Text(e.aGRMNTNO!)));
          });
        }
      }
    }

    is_loading.value = false;
  }

  void setDDNomorKontrak(String newValue) {
    //set id dropdown
    idxDdNomorKontrak.value = newValue;
    //set nama dan nomor plat
    final cari = realKontrak.data!.where((x) => x.aGRMNTNO == newValue);
    if (cari.isNotEmpty) {
      final p = cari.first;
      state.tecNamaLengkap!.text = p.cUSTFULLNAME!;
      state.tecNoPlat!.text = p.pLATNO!;
      state.tecTipeUnit!.text = p.merkType!;
    } else {
      state.tecNamaLengkap!.text = "";
      state.tecNoPlat!.text = "";
      state.tecTipeUnit!.text = "";
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (pickedImage == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Sesuaikan Gambar',
          toolbarColor: Colors.green,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
      ],
    );

    if (croppedFile == null) return;

    state.lampiran = File(croppedFile.path);
    update();
  }

  void submit(BuildContext context) async {
    if (state.formKey!.currentState!.validate()) {
      is_loading.value = true;
      final hasil = await getService<LayananPengaduanSubmitFormService>()!
          .submitFormLayananPengaduan(
              login_user_id: user_id,
              nama_lengkap: state.tecNamaLengkap!.text.trim(),
              nomor_hp: state.tecNoHp!.text.trim(),
              agreement_no: idxDdNomorKontrak.value,
              kritikSaranPengaduan: state.tecKritikDanSaran!.text.trim());

      if (hasil == null) {
        Fungsi.koneksiError();
      } else {
        if (hasil.code == Konstan.tag_100) {
          Fungsi.warningToast(hasil.message!);
        } else {
          await initializeDateFormatting('id_ID');
          showDialog(
              context: context,
              builder: (context) {
                final textTheme = Theme.of(context).textTheme;

                return AlertDialog(
                  actionsAlignment: MainAxisAlignment.center,
                  title: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Nomor Tiket\n',
                        style: textTheme.headlineSmall,
                        children: [
                          TextSpan(
                              text: hasil.message,
                              style: textTheme.headlineSmall!
                                  .copyWith(fontWeight: FontWeight.bold))
                        ]),
                  ),
                  content: Text(
                    'Pengaduan bapak/ibu telah berhasil dikirimkan pada hari ${DateFormat('EEEE, d MMMM y', 'id_ID').format(DateTime.now())}',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.offAllNamed(Konstan.rute_home);
                        },
                        child: Text(
                          'OK',
                          style: textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold)
                              .copyWith(color: Colors.green),
                        ))
                  ],
                );
              });
        }
      }

      is_loading.value = false;
    }
  }
}
