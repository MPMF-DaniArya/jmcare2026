import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/EsignInvitationRequest.dart';
import 'package:jmcare/model/api/EsigninvitationRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/esign/invitation/state.dart';
import 'package:jmcare/service/EsigninvitationService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/api/WilayahRespon.dart' as wr;

class EsigninvitationLogic extends BaseLogic {
  final EsigninvitationState state = EsigninvitationState();

  @override
  void onInit() {
    super.onInit();
    getDetail();
  }

  void getDetail() async {
    final auth = await getStorage<LoginRespon>();
    state.tecNama!.text = auth.data!.namaUser!;
    state.tecNIK!.text = auth.data!.noKtp!;
    state.tecTmplahir!.text = auth.data!.tempatLahir!;
    state.tecTgllahir!.text = auth.data!.tglLahir!;
    state.tecHP!.text = auth.data!.noHp!;
    state.tecAlamat!.text = auth.data!.alamat!;
    state.tecPropinsi!.text = auth.data!.provinsi!;
    state.tecKabupaten!.text = auth.data!.kabupaten!;
    state.tecKecamatan!.text = auth.data!.kecamatan!;
    state.tecKelurahan!.text = auth.data!.kelurahan!;
    state.tecKodepos!.text = auth.data!.kodepos!;
    state.tecEmail!.text = auth.data!.email!;
  }

  void klikTgllahir(BuildContext context) {
    DatePicker.showDatePicker(context, showTitleActions: true,
        onChanged: (date) {
      setTgllahir(date);
    }, onConfirm: (date) {
      setTgllahir(date);
    });
  }

  void setTgllahir(DateTime date) {
    state.tecTgllahir!.text = date.year.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.day.toString();
  }

  void dialogWilayah(String jenis) async {
    //variabel ini digunakan untuk mengisi param id_master
    //kalau user klik dropdown propinsi, id_payload = 0
    //kalau user klik dropdown kabupaten, id_payload = selected_id_propinsi
    //kalau user klik dropdown kecamatan, id_payload = selected_id_kabupaten
    //kalau user klik dropdown kelurahan, id_payload = selected_id_kecamatan
    int id_payload;
    switch (jenis) {
      case Konstan.tag_propinsi:
        id_payload = 0;
        break;
      case Konstan.tag_kabupaten:
        if (state.tecPropinsi!.text.isEmpty) {
          Fungsi.warningToast("Propinsi belum dipilih");
          return;
        }
        id_payload = state.selected_id_propinsi;
        break;
      case Konstan.tag_kecamatan:
        if (state.tecKabupaten!.text.isEmpty) {
          Fungsi.warningToast("Kabupaten belum dipilih");
          return;
        }
        id_payload = state.selected_id_kabupaten;
        break;
      case Konstan.tag_kelurahan:
        if (state.tecKecamatan!.text.isEmpty) {
          Fungsi.warningToast("Kecamatan belum dipilih");
          return;
        }
        id_payload = state.selected_id_kecamatan;
        break;
      default:
        id_payload = 0;
        break;
    }
    final result = await Get.toNamed(Konstan.rute_dialog_wilayah,
        arguments: {"jenis": jenis, "id_master": id_payload});

    if ("$result" == null || "$result".isEmpty) {
    } else {
      try {
        debugPrint("$result");
        //variabel selected dihasilkan dari screen dialog wilayah yang diklik dari listview
        final selected = wr.Data.fromJson(jsonDecode("$result"));
        switch (jenis) {
          case Konstan.tag_propinsi:
            state.tecPropinsi!.text = selected.nama!;
            state.selected_id_propinsi = selected.id!;
            state.selected_id_kabupaten = 0;
            state.selected_id_kecamatan = 0;
            state.selected_id_kelurahan = 0;
            state.tecKabupaten!.text = "";
            state.tecKecamatan!.text = "";
            state.tecKelurahan!.text = "";
            break;
          case Konstan.tag_kabupaten:
            state.tecKabupaten!.text = selected.nama!;
            state.selected_id_kabupaten = selected.id!;
            state.selected_id_kecamatan = 0;
            state.selected_id_kelurahan = 0;
            state.tecKecamatan!.text = "";
            state.tecKelurahan!.text = "";
            break;
          case Konstan.tag_kecamatan:
            state.tecKecamatan!.text = selected.nama!;
            state.selected_id_kecamatan = selected.id!;
            state.selected_id_kelurahan = 0;
            state.tecKelurahan!.text = "";
            break;
          case Konstan.tag_kelurahan:
            state.tecKelurahan!.text = selected.nama!;
            state.selected_id_kelurahan = selected.id!;
            break;
          default:
            state.tecPropinsi!.text = selected.nama!;
            state.selected_id_propinsi = selected.id!;
            state.selected_id_kabupaten = 0;
            state.selected_id_kecamatan = 0;
            state.selected_id_kelurahan = 0;
            state.tecKabupaten!.text = "";
            state.tecKecamatan!.text = "";
            state.tecKelurahan!.text = "";
            break;
        }
      } catch (e) {
        debugPrint("tidak ada yang dipilih");
      }
    }
  }

  void handleOptionGender(String newValue) {
    state.current_option_gender = newValue;
    update();
  }

  void submit() async {
    if (state.tecHP!.text.isEmpty) {
      Fungsi.errorToast("Nomor HP belum diisi!");
      return;
    }
    if (state.tecAlamat!.text.isEmpty) {
      Fungsi.errorToast("Alamat belum diisi!");
      return;
    }
    if (state.tecPropinsi!.text.isEmpty) {
      Fungsi.errorToast("Propinsi belum diisi!");
      return;
    }
    if (state.tecKabupaten!.text.isEmpty) {
      Fungsi.errorToast("Kabupaten belum diisi!");
      return;
    }
    if (state.tecKecamatan!.text.isEmpty) {
      Fungsi.errorToast("Kecamatan belum diisi!");
      return;
    }
    if (state.tecKelurahan!.text.isEmpty) {
      Fungsi.errorToast("Kelurahan belum diisi!");
      return;
    }
    if (state.tecKodepos!.text.isEmpty) {
      Fungsi.errorToast("Kodepos belum diisi!");
      return;
    }
    if (state.tecTgllahir!.text.isEmpty) {
      Fungsi.errorToast("Tanggal lahir belum diisi");
      return;
    }

    is_loading.value = true;
    //get detail user yang login
    final auth = await getStorage<LoginRespon>();
    final user = auth.data!;
    final respon = await getService<EsigninvitationService>()?.invite(
        state.tecPropinsi!.text,
        state.tecKabupaten!.text,
        state.tecKelurahan!.text,
        state.tecTmplahir!.text,
        state.tecAlamat!.text,
        state.tecTgllahir!.text,
        state.tecNama!.text,
        state.tecKecamatan!.text,
        state.tecHP!.text,
        state.current_option_gender,
        state.tecNIK!.text,
        state.tecKodepos!.text,
        state.tecEmail!.text,
        "EMPLOYEE");

    if (respon is EsigninvitationError) {
      Fungsi.errorToast("Tidak dapat memproses invitation link");
    } else {
      Get.toNamed(Konstan.rute_esign, arguments: {'detail': respon!.link});
      // // Get.back();
      // // Fungsi.suksesToast("Invitation berhasil diproses!");
      // //buat json buat intent extra string
      // EsignInvitationRequest request = EsignInvitationRequest(
      //     provinsi: state.tecPropinsi!.text,
      //     kota: state.tecKabupaten!.text,
      //     kelurahan: state.tecKelurahan!.text,
      //     tmpLahir: state.tecTmplahir!.text,
      //     alamat: state.tecAlamat!.text,
      //     tglLahir: state.tecTgllahir!.text,
      //     nama: state.tecNama!.text,
      //     kecamatan: state.tecKecamatan!.text,
      //     tlp: state.tecHP!.text,
      //     jenisKelamin: state.current_option_gender,
      //     idKtp: state.tecNIK!.text,
      //     kodePos: state.tecKodepos!.text,
      //     email: state.tecEmail!.text);

      // var detail = jsonEncode(request);
      // Get.offAndToNamed(Konstan.rute_esign_register, arguments: {'detail': detail});
    }
    is_loading.value = false;
  }
}
