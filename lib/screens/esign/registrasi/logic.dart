import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/EsignRegisterRequest.dart';
import 'package:jmcare/model/api/EsignRegisterRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/esign/registrasi/state.dart';
import 'package:jmcare/service/EsignRegisterService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class EsignRegisterLogic extends BaseLogic {
  final EsignRegisterState state = EsignRegisterState();
  var show_pass = true.obs;
  var show_ulangi_pass = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    askPermission();
    getDetail();
  }

  void getDetail() {
    //get detail dulu dari lemparan esign invitation
    //nanti dikumpulin value pas nembak api register
    state.detail = Get.arguments['detail'];
  }

  void show_pass_action() {
    if (show_pass.value) {
      show_pass.value = false;
    } else {
      show_pass.value = true;
    }
  }

  void show_ulangi_pass_action() {
    if (show_ulangi_pass.value) {
      show_ulangi_pass.value = false;
    } else {
      show_ulangi_pass.value = true;
    }
  }

  void askPermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage].request();
  }

  void clearFoto(String jenis) {
    if (jenis == "KTP") {
      state.imageKTP = null;
    } else {
      state.imageProfil = null;
    }
    update();
  }

  Future pickImage(String jenis, ImageSource sumber) async {
    var image = await state.imagePicker!.pickImage(source: sumber);
    if (jenis == "KTP") {
      state.imageKTP = File(image!.path);
      final kompres = await FlutterImageCompress.compressWithFile(
          state.imageKTP!.absolute.path,
          quality: 50,
          rotate: 0);
      final a = kompres!.toList();
      state.base64_ktp = base64Encode(a);
    } else {
      state.imageProfil = File(image!.path);
      final kompres = await FlutterImageCompress.compressWithFile(
          state.imageKTP!.absolute.path,
          quality: 50,
          rotate: 0);
      final a = kompres!.toList();
      state.base64_profil = base64Encode(a);
    }
    update();
  }

  void showPicker(BuildContext context, String jenis) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Galeri'),
                    onTap: () {
                      pickImage(jenis, ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Kamera'),
                  onTap: () {
                    pickImage(jenis, ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void submit() async {
    if (state.base64_ktp.isEmpty) {
      Fungsi.errorToast("Foto ktp belum ada");
      return;
    }

    if (state.base64_profil.isEmpty) {
      Fungsi.errorToast("Foto selfi belum ada");
      return;
    }

    if (state.tecPassword!.text.isEmpty) {
      Fungsi.errorToast("Password belum diisi");
      return;
    }

    if (state.tecUlangpassword!.text.isEmpty) {
      Fungsi.errorToast("Pengulangan password belum ada");
      return;
    }

    if (state.tecPassword!.text != state.tecUlangpassword!.text) {
      Fungsi.errorToast("Password dan pengulangannya tidak sama!");
      return;
    }

    is_loading.value = true;
    var map = jsonDecode(state.detail);
    var sumber = EsignRegisterRequest.fromJson(map);

    final respon = await getService<Esignregisterservice>()?.register(
        sumber.nama!,
        sumber.email!,
        sumber.tmpLahir!,
        sumber.tglLahir!,
        sumber.jenisKelamin!,
        sumber.tlp!,
        sumber.idKtp!,
        sumber.alamat!,
        sumber.kecamatan!,
        sumber.kelurahan!,
        sumber.kota!,
        sumber.provinsi!,
        sumber.kodePos!,
        state.base64_profil,
        state.base64_ktp,
        state.tecPassword!.text);

    try {
      if (respon is EsignregisterError) {
        Fungsi.errorToast("Tidak dapat memproses data");
      } else {
        if (respon!.status!.code! == 0) {
          // Fungsi.suksesToast("Proses register berhasil!");
          Get.offAndToNamed(Konstan.rute_esign);
        } else {
          Fungsi.errorToast(respon.status!.message!);
        }
      }
    } catch (e) {
      Fungsi.errorToast("Error register!");
    }

    is_loading.value = false;
  }
}
