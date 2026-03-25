import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jmcare/model/api/DownloadPdfPdpRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/screens/unduh_pdf_data_pribadi/state.dart';
import 'package:jmcare/service/DownloadPdpPdfService.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../helper/Fungsi.dart';
import '../../../../../../helper/Konstan.dart';
import '../../../../../../service/Service.dart';

class UnduhPdfDataPribadiLogic extends BaseLogic {
  final UnduhPdfDataPribadiState state = UnduhPdfDataPribadiState();

  @override
  void onInit() {
    super.onInit();
    state.tecINPUT.clear();
  }

  @override
  void onClose() {
    state.tecINPUT.dispose();
    super.onClose();
  }

  // fungsi untuk mengecek pin input
  void pengecekanPinInput() async {
    final inputPin = state.tecINPUT.text;

    if (inputPin.isEmpty) {
      Fungsi.errorToast("PIN harus diisi!");
      return;
    }
    if (inputPin.length < 6) {
      Fungsi.errorToast("PIN minimal 6 angka");
      return;
    }

    is_loading.value = true;

    try {
      // ambil pin user dari storage
      final String savedPIN = await getPIN();

      if (savedPIN == inputPin) {
        // kalau input dan pin di storage sama maka post unduh data pribadi
        await postUnduhDataPribadi(savedPIN);
      } else {
        Fungsi.errorToast("PIN tidak cocok!");
        state.tecINPUT.clear();
      }
    } catch (e) {
      Fungsi.errorToast('Terjadi kesalahan sistem');
    } finally {
      is_loading.value = false;
    }
  }

  // fungsi untuk post req untuk unduh data pribadi
  Future<void> postUnduhDataPribadi(String pin) async {
    try {
      final auth = await getStorage<LoginRespon>();
      final data = await getService<DownloadPdpPdfService>()!.downloadPdfPdp(
          login_user_id: int.tryParse(auth.data!.loginUserId!)!,
          pinJmcare: pin,
          email: auth.data!.email!);

      if (data != null) {
        if (data is DownloadPdfPdpError) {
          Fungsi.errorToast(data.pesan.toString());
        } else {
          if (data.base64Pdf != null) {
            DateTime now = DateTime.now();

            String formattedDate = DateFormat('yyMMdd_HHmm').format(now);

            String fileName = "DP_$formattedDate.pdf";
            await savePdfSdpDialog(data.base64Pdf!, fileName);
          } else {
            Fungsi.errorToast("Data Pribadi tidak ditemukan");
          }
        }
      }
    } catch (e) {
      Fungsi.koneksiError();
    }
  }

  // fungsi untuk menyimpan pdf ke hp user dan dialog apakah akan membuka file pdf tersebut langsung atau tidak
  Future<void> savePdfSdpDialog(String base64String, String fileName) async {
    try {
      var bytes = base64Decode(base64String);
      Directory? directory;

      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      String filePath = '${directory!.path}/$fileName.pdf';
      File file = File(filePath);
      await file.writeAsBytes(bytes);

      is_loading.value = false;

      Get.defaultDialog(
        title: "Unduh Berhasil",
        titleStyle: const TextStyle(fontWeight: FontWeight.bold),
        contentPadding: const EdgeInsets.all(20),
        middleText:
            "File PDF telah tersimpan di folder Download.\n\nApakah Anda ingin membuka file ini sekarang?",
        textConfirm: "BUKA FILE",
        textCancel: "NANTI",
        confirmTextColor: Colors.white,
        buttonColor: Colors.green,
        onConfirm: () {
          Get.back();
          Get.back();
          OpenFile.open(filePath);
          // setelah mengunduh file pdf user diminta untuk kembali ke halaman auth pin
          Get.offAllNamed(Konstan.rute_auth_pin);
        },
        onCancel: () {
          // setelah mengunduh file pdf user diminta untuk kembali ke halaman auth pin
          Get.offAllNamed(Konstan.rute_auth_pin);
        },
      );
    } catch (e) {
      is_loading.value = false;
      Fungsi.errorToast('Gagal memproses file: $e');
    }
  }
}
