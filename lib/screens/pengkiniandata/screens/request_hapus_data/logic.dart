import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_hapus_data/state.dart';
import 'package:jmcare/service/PengkinianDataPribadiSubmitFormService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';

import '../../../../helper/Fungsi.dart';

class RequestHapusDataLogic extends BaseLogic {
  final RequestHapusDataState state = RequestHapusDataState();

  RxBool isSetuju = false.obs;

  void pickFile() async {
    state.lampiran = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'jpg',
        ],
        allowMultiple: false,
        allowCompression: true);
    if (state.lampiran != null) {
      state.platformFile = state.lampiran!.files.first;
      state.fileSizes = state.platformFile!.size.toString();
      state.filePath = state.platformFile!.path.toString();

      if (int.parse(state.fileSizes) >= 5000000) {
        Fungsi.warningToast("File tidak boleh lebih besar dari 5MB");
        return;
      } else {
        File file = File(state.filePath);
        final b = await file.readAsBytes();
        state.base64_file = base64Encode(b);
        update();
      }
    }
  }

  void dialogKonfirmasiHapusdata(BuildContext context) {
    Get.defaultDialog(
      title: "Pemberitahuan",
      barrierDismissible: false,
      onWillPop: () async => !is_loading.value,
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      contentPadding: const EdgeInsets.all(20),
      content: Obx(() => Column(
            children: [
              if (!is_loading.value) ...[
                const Icon(
                  Icons.info_outline_rounded,
                  color: Colors.red,
                  size: 100,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Konfirmasi Request Hapus Data',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Apakah Anda yakin ingin menghapus akun ini?\nSemua data Anda akan dihapus secara permanen.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ] else ...[
                // Tampilan saat loading
                Komponen.getLoadingWidget(),
                const Text("Sedang memproses..."),
              ],
            ],
          )),
      confirm: Obx(() => is_loading.value
          ? const SizedBox.shrink()
          : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => submitRequestPenghapusan(),
                child:
                    const Text('Yakin', style: TextStyle(color: Colors.white)),
              ),
            )),
      cancel: Obx(() => is_loading.value
          ? const SizedBox.shrink()
          : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => Get.back(),
                child:
                    const Text('Batal', style: TextStyle(color: Colors.white)),
              ),
            )),
    );
  }

  void submitRequestPenghapusan() async {
    is_loading.value = true;

    try {
      final auth = await getStorage<LoginRespon>();
      final userId = int.tryParse(auth.data!.loginUserId!)!;

      List<Map<String, dynamic>> requestBody = [
        {
          "login_user_id": userId,
          "jenis_perubahan_data": "Penghapusan Data Pribadi",
          "file_pendukung": state.base64_file
        }
      ];

      final response =
          await getService<PengkinianDataPribadiSubmitFormService>()!
              .submitFormPengkinianDataPribadi(requestBody: requestBody);

      if (response == null || response is BaseError) {
        Fungsi.errorToast(
            "Gagal request penghapusan data pribadi. Silakan coba lagi.");
        return;
      }

      if (response.code! != '200' && response.status != 'Success') {
        Fungsi.errorToast("Terjadi kesalahan: ${response.message}");
        return;
      }

      Fungsi.suksesToast(
          'Request Penghapusan Data Pribadi Berhasil Diajukan. Silahkan menunggu konfirmasi dari kami.');
      Get.close(2);
    } catch (e) {
      Fungsi.errorToast("Terjadi kesalahan sistem: $e");
    } finally {
      is_loading.value = false;
    }
  }
}
