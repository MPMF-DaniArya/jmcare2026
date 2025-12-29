import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart';
import 'package:jmcare/screens/layanan_pengaduan/state.dart';

import '../../helper/Fungsi.dart';
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
}
