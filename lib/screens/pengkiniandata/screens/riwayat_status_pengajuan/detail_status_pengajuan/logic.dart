import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/api/GetDetailRiwayatSdpRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/service/GetDetailRiwayatSdpService.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../helper/Fungsi.dart';
import '../../../../../model/api/DownloadFilePdpRespon.dart';
import '../../../../../service/Service.dart';
import '../../../../../service/preview_file_pdp_riwayat_status_pengajuan/PreviewFileKkService.dart';
import '../../../../../service/preview_file_pdp_riwayat_status_pengajuan/PreviewFileKtpService.dart';
import '../../../../../service/preview_file_pdp_riwayat_status_pengajuan/PreviewFilePendukungService.dart';

class DetailStatusPengajuanLogic extends BaseLogic {
  var headerPengajuan = HeaderData().obs;
  var listPengajuanDetail = <DetailData>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null && Get.arguments['noTiket'] != null) {
      getDetailRiwayatSdp(Get.arguments['noTiket']);
    }
  }

  void getDetailRiwayatSdp(String noTiket) async {
    is_loading.value = true;
    try {
      final response = await getService<GetDetailRiwayatSdpService>()!
          .getDetailSdpByNoTiket(noTiket: noTiket);

      if (response != null) {
        GetDetailRiwayatSpdRespon parsedData =
            GetDetailRiwayatSpdRespon.fromJson(response);

        if (parsedData.header != null) {
          headerPengajuan.value = parsedData.header!;
        }

        if (parsedData.detail != null) {
          listPengajuanDetail.value = parsedData.detail!;
        }
      } else {
        Fungsi.errorToast('Gagal Memuat Riwayat Dengan No Tiket Ini.');
      }
    } catch (e) {
      debugPrint("Error GetDetail: $e");
    } finally {
      is_loading.value = false;
    }
  }

  void previewFileKtp(int idPdp) async {
    is_loading.value = true;
    try {
      final response = await getService<PreviewFileKtpService>()!
          .previewFileKtp(idPdp: idPdp);

      if (response != null) {
        if (response is DownloadFilePdpError) {
          Fungsi.errorToast(
              'Terjadi masalah. Tidak dapat menampilkan file KTP');
        } else {
          if (response.base64File!.isNotEmpty && response.base64File != null) {
            Uint8List bytes = base64Decode(response.base64File!);

            String extensions = Fungsi.getFileExtension(bytes);

            final direktori = await getTemporaryDirectory();
            DateTime now = DateTime.now();
            String timestamp =
                "${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}";
            final filePath =
                '${direktori.path}/ktp_preview$timestamp$extensions';
            final file = File(filePath);

            await file.writeAsBytes(bytes);

            final result = await OpenFile.open(filePath);

            if (result.type != ResultType.done) {
              Fungsi.errorToast(
                  "Tidak ada aplikasi untuk membuka file $extensions ini.");
            }
          } else {
            Fungsi.warningToast("Data file kosong.");
          }
        }
      }
    } catch (e) {
      Fungsi.errorToast("Gagal memproses preview: $e");
    } finally {
      is_loading.value = false;
    }
  }

  void previewFileKk(int idPdp) async {
    is_loading.value = true;
    try {
      final response =
          await getService<PreviewFileKkService>()!.previewFileKk(idPdp: idPdp);

      if (response != null) {
        if (response is DownloadFilePdpError) {
          Fungsi.errorToast(
              'Terjadi masalah. Tidak dapat menampilkan file KTP ');
        } else {
          if (response.base64File!.isNotEmpty && response.base64File != null) {
            Uint8List bytes = base64Decode(response.base64File!);

            String extensions = Fungsi.getFileExtension(bytes);

            final direktori = await getTemporaryDirectory();
            DateTime now = DateTime.now();
            String timestamp =
                "${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}";
            final filePath =
                '${direktori.path}/kk_preview$timestamp$extensions';
            final file = File(filePath);

            await file.writeAsBytes(bytes);

            final result = await OpenFile.open(filePath);

            if (result.type != ResultType.done) {
              Fungsi.errorToast(
                  "Tidak ada aplikasi untuk membuka file $extensions ini.");
            }
          } else {
            Fungsi.warningToast("Data file kosong.");
          }
        }
      }
    } catch (e) {
      Fungsi.errorToast("Gagal memproses preview: $e");
    } finally {
      is_loading.value = false;
    }
  }

  void previewFilePendukung(int idPdp) async {
    is_loading.value = true;
    try {
      final response = await getService<PreviewFilePendukungService>()!
          .previewFilePendukung(idPdp: idPdp);

      if (response != null) {
        if (response is DownloadFilePdpError) {
          Fungsi.errorToast(
              'Terjadi masalah. Tidak dapat menampilkan file KTP ');
        } else {
          if (response.base64File!.isNotEmpty && response.base64File != null) {
            Uint8List bytes = base64Decode(response.base64File!);

            String extensions = Fungsi.getFileExtension(bytes);

            final direktori = await getTemporaryDirectory();
            DateTime now = DateTime.now();
            String timestamp =
                "${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}";
            final filePath =
                '${direktori.path}/kk_preview$timestamp$extensions';
            final file = File(filePath);

            await file.writeAsBytes(bytes);

            final result = await OpenFile.open(filePath);

            if (result.type != ResultType.done) {
              Fungsi.errorToast(
                  "Tidak ada aplikasi untuk membuka file $extensions ini.");
            }
          } else {
            Fungsi.warningToast("Tidak ada file yang anda unggah");
          }
        }
      }
    } catch (e) {
      Fungsi.errorToast("Gagal memproses preview: $e");
    } finally {
      is_loading.value = false;
    }
  }
}
