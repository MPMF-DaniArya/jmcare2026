import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/DownloadFilePdpRespon.dart';
import 'package:jmcare/model/api/GetRiwayatPpdRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/riwayat_status_pengajuan/state.dart';
import 'package:jmcare/service/GetRiyawatPdpService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/download_file_pdp/PreviewFileKkService.dart';
import 'package:jmcare/service/download_file_pdp/PreviewFileKtpService.dart';
import 'package:jmcare/service/download_file_pdp/PreviewFilePendukungService.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class RiwayatStatusPengajuanLogic extends BaseLogic {
  final RiwayatStatusPengajuanState state = RiwayatStatusPengajuanState();
  var selectedCategory = 'Semua'.obs;

  var listRiwayat = <GetRiwayatPpdRespon>[].obs;

  @override
  onInit() {
    super.onInit();
    getHistoryPengkinian();
  }

  void getHistoryPengkinian() async {
    is_loading.value = true;

    try {
      final auth = await getStorage<LoginRespon>();

      String statusFilter = selectedCategory.value == 'Semua'
          ? ''
          : selectedCategory.value.toUpperCase();

      await Future.delayed(const Duration(seconds: 1));

      final dynamic response = await getService<GetRiyawatPdpService>()!
          .getRiwayatPdp(
              userId: int.tryParse(auth.data!.loginUserId!)!,
              status: statusFilter);

      if (response != null && response is List) {
        List<GetRiwayatPpdRespon> rawList = response
            .map(
              (e) => GetRiwayatPpdRespon.fromJson(e),
            )
            .toList();

        DateFormat inputFormat = DateFormat("dd MMM yyyy HH:mm:ss");

        rawList.sort(
          (a, b) => inputFormat
              .parse(b.createDate!)
              .compareTo(inputFormat.parse(a.createDate!)),
        );

        listRiwayat.value = rawList;
      } else if (response is GetRiwayatPdpError) {
        Fungsi.errorToast('Gagal Memuat Riwayat. Silahkan coba lagi nanti!');
      }
    } catch (e) {
      Fungsi.koneksiError();
    } finally {
      is_loading.value = false;
    }
  }

  List<GetRiwayatPpdRespon> get filterredHistory {
    if (selectedCategory.value == 'Semua') {
      return listRiwayat;
    }
    return listRiwayat
        .where((item) =>
            item.status!.toUpperCase() == selectedCategory.value.toUpperCase())
        .toList();
  }

  void changeCategory(String category) {
    selectedCategory.value = category;

    getHistoryPengkinian();
  }

  void previewFileKtp(int idPdp) async {
    is_loading.value = true;
    try {
      final response = await getService<PreviewFileKtpService>()!
          .previewFileKtp(idPdp: idPdp);

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
}
