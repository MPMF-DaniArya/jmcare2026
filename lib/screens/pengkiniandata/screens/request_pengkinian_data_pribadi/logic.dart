import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_pengkinian_data_pribadi/state.dart';
import 'package:jmcare/service/PengkinianDataPribadiSubmitFormService.dart';

import '../../../../model/api/BaseRespon.dart';
import '../../../../model/api/LoginRespon.dart';
import '../../../../model/api/SubjekDataPribadiRespon.dart';
import '../../../../service/GetDetailSdpService.dart';
import '../../../../service/Service.dart';
import '../../../../storage/storage.dart';

class RequestPengkinianDataPribadiLogic extends BaseLogic {
  final RequestPengkinianDataPribadiState state =
      RequestPengkinianDataPribadiState();
  var ddJenisData = <DropdownMenuItem<String>>[].obs;
  RxString dataSaatIni = "".obs;

  // ini adalah jenis data yang wajib untuk upload dokumen
  final List<String> jenisDataWajibUploadDokumen = [
    'Nama Lengkap',
    'Alamat Domisili',
    'Alamat KTP',
  ];

  @override
  void onInit() {
    super.onInit();
    inisialisasiData();
  }

  void inisialisasiData() async {
    await getSubjekDataPribadiLokal();
    addFormBaru();
  }

  Future<void> getSubjekDataPribadiLokal() async {
    is_loading.value = true;

    try {
      final sdp = await getStorage<SubjekDataPribadiRespon>();
      final sdpData = sdp.data;

      if (sdpData != null) {
        _mapDataUntukInisialisasiState(sdpData);
      } else {
        final auth = await getStorage<LoginRespon>();
        final dataSdpRespon = await getService<GetDetailSdpService>()!
            .getDetailSdp(
                login_user_id: int.tryParse(auth.data!.loginUserId!)!);

        if (dataSdpRespon != null) {
          if (dataSdpRespon is SubjekDataPribadiError) {
            Fungsi.errorToast(
                "Terjadi masalah. Tidak dapat menampilkan data pribadi!");
          } else {
            baseSaveStorage<SubjekDataPribadiRespon>(dataSdpRespon);
            _mapDataUntukInisialisasiState(dataSdpRespon);
          }
        }
      }
    } catch (e) {
      Fungsi.koneksiError();
    } finally {
      is_loading.value = false;
    }
  }

  // Fungsi untuk mengisi dropdown jenis data
  List<String> getJenisDataTersedia(int currentIndex) {
    List<String?> jenisDataDipilih = state.formList
        .asMap()
        .entries
        .where(
          (jenisData) => jenisData.key != currentIndex,
        )
        .map((jenisData) => jenisData.value['jenisDataTerpilih'] as String?)
        .toList();

    // jika jenis data sudah dipilih di form sebelumnya maka jenis data tersebut akan di hilangkan di form selanjutnya
    return state.jenisData.where((element) {
      return !jenisDataDipilih.contains(element);
    }).toList();
  }

  void updateJenisDataTerpilih(int index, String? value) {
    state.formList[index]['jenisDataTerpilih'] = value;

    String dataLama = "-";

    switch (value) {
      case 'Nama Lengkap':
        dataLama = state.namaLengkapUser ?? "-";
        break;
      case 'Alamat Domisili':
        dataLama = state.alamatDomisiliUser ?? "-";
        break;
      case 'Alamat KTP':
        dataLama = state.alamatSesuaiIdUser ?? "-";
        break;
      case 'Nomor Handphone':
        dataLama = state.nomorTeleponUser ?? "-";
        break;
      case 'Alamat Email':
        dataLama = state.emailUser ?? "-";
        break;
      default:
        dataLama = "-";
    }

    state.formList[index]['dataLama'] = dataLama;

    // Reset dokumenList jika jenis data diubah ke yang tidak wajib dokumen
    bool isWajib = jenisDataWajibUploadDokumen.contains(value);
    var dokumenList =
        state.formList[index]['dokumenList'] as RxList<Map<String, dynamic>>;
    if (!isWajib && dokumenList.length > 1) {
      // Sisakan hanya satu dokumen
      var dokumenPertama = dokumenList[0];
      dokumenList.clear();
      dokumenList.add(dokumenPertama);
    }

    state.formList.refresh();
    update();
  }

  // Fungsi untuk menambahkan form baru
  void addFormBaru() {
    bool isSemuaFormSudahTerisi = state.formList.every((form) {
      String? jenisData = form['jenisDataTerpilih'];
      TextEditingController? tec = form['tecDataBaru'];
      bool isWajib = jenisDataWajibUploadDokumen.contains(jenisData);

      var dokumenList = form['dokumenList'] as RxList<Map<String, dynamic>>?;
      bool isDokumenTerisi = !isWajib ||
          (dokumenList != null &&
              dokumenList.isNotEmpty &&
              dokumenList[0]['lampiran'] != null);

      return jenisData != null &&
          tec != null &&
          tec.text.trim().isNotEmpty &&
          isDokumenTerisi;
    });

    if (state.formList.isNotEmpty && !isSemuaFormSudahTerisi) {
      Fungsi.warningToast(
          'Mohon lengkapi jenis data, perubahan data, dan dokumen (jika wajib) pada permintaan sebelumnya.');
      return;
    }

    if (state.formList.length < state.maxForms) {
      state.formList.add({
        'tecDataBaru': TextEditingController(),
        'jenisDataTerpilih': null,
        'dataLama': "-",
        'dokumenList': <Map<String, dynamic>>[
          {'lampiran': null, 'base64_file': "", 'namaFile': ""},
        ].obs,
      });
    } else {
      Fungsi.errorToast('Anda telah mencapai batas maksimum formulir.');
    }
  }

  void tambahDokumenPerForm(int formIndex) {
    var dokumenList = state.formList[formIndex]['dokumenList']
        as RxList<Map<String, dynamic>>;

    if (dokumenList.isEmpty || dokumenList.last['lampiran'] == null) {
      Fungsi.warningToast(
          "Pilih dokumen sebelumnya terlebih dahulu sebelum menambah dokumen baru.");
      return;
    }

    if (dokumenList.length < 3) {
      dokumenList.add({'lampiran': null, 'base64_file': "", 'namaFile': ""});
    } else {
      Fungsi.errorToast("Maksimal 3 dokumen per perubahan");
    }
  }

  void hapusForm(int index) {
    state.formList[index]['tecDataBaru']?.dispose();
    state.formList.removeAt(index);
    update();
  }

  void pilihFile(int formIndex, int docIndex) async {
    FilePickerResult? hasil = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'heic', 'doc', 'docx'],
    );

    if (hasil != null) {
      PlatformFile file = hasil.files.first;
      if (file.size >= 10000000) {
        Fungsi.warningToast("File tidak boleh lebih besar dari 10MB");
        return;
      }

      File fileObj = File(file.path!);
      final b = await fileObj.readAsBytes();

      var dokumenList = state.formList[formIndex]['dokumenList']
          as RxList<Map<String, dynamic>>;
      var doc = dokumenList[docIndex];
      doc['lampiran'] = hasil;
      doc['namaFile'] = file.name;
      doc['base64_file'] = base64Encode(b);

      dokumenList.refresh();
      state.formList.refresh();
      update();
    }
  }

  void hapusFile(int formIndex, int docIndex) {
    var dokumenList = state.formList[formIndex]['dokumenList']
        as RxList<Map<String, dynamic>>;

    if (dokumenList.length > 1) {
      dokumenList.removeAt(docIndex);
    } else {
      dokumenList[0] = {'lampiran': null, 'base64_file': "", 'namaFile': ""};
    }
    dokumenList.refresh();
    state.formList.refresh();
    update();
  }

  void submitData() async {
    if (state.formKey?.currentState?.validate() ?? false) {
      bool isSemuaFormSudahTerisi = state.formList.every((form) {
        String? jenisData = form['jenisDataTerpilih'];
        TextEditingController? tec = form['tecDataBaru'];
        bool isWajib = jenisDataWajibUploadDokumen.contains(jenisData);

        var dokumenList = form['dokumenList'] as RxList<Map<String, dynamic>>?;
        bool isDokumenTerisi = !isWajib ||
            (dokumenList != null &&
                dokumenList.isNotEmpty &&
                dokumenList[0]['lampiran'] != null);

        return jenisData != null &&
            tec != null &&
            tec.text.trim().isNotEmpty &&
            isDokumenTerisi;
      });

      if (!isSemuaFormSudahTerisi) {
        Fungsi.errorToast('Silahkan Cek Kembali Data Anda.');
        return;
      }

      is_loading.value = true;

      try {
        final auth = await getStorage<LoginRespon>();
        final userId = int.tryParse(auth.data!.loginUserId!)!;

        for (var form in state.formList) {
          String jenisData = form['jenisDataTerpilih']!;
          String dataLama = form['dataLama']!;
          String dataBaru = (form['tecDataBaru'] as TextEditingController).text;

          var dokumenList = form['dokumenList'] as RxList<Map<String, dynamic>>;

          final response =
              await getService<PengkinianDataPribadiSubmitFormService>()!
                  .submitFormPengkinianDataPribadi(
            login_user_id: userId,
            jenis_perubahan_data: jenisData,
            data_saat_ini: dataLama,
            perubahan_data: dataBaru,
            file_ktp: dokumenList[0]['base64_file'],
            file_kk: dokumenList[0]['base64_file'],
            file_pendukung: dokumenList[0]['base64_file'],
          );

          if (response == null || response is BaseError) {
            Fungsi.errorToast(
                "Gagal mengirimkan data untuk $jenisData. Silakan coba lagi.");
            return;
          }

          if (response.code.toString() != '200' &&
              response.status != "Success") {
            Fungsi.errorToast("Terjadi kesalahan: ${response.message}");
            return;
          }
        }

        Fungsi.suksesToast('Semua Pengkinian Data Berhasil Diajukan.');
        Get.back();
      } catch (e) {
        Fungsi.errorToast("Terjadi kesalahan sistem: $e");
      } finally {
        is_loading.value = false;
      }
    }
  }

  void _mapDataUntukInisialisasiState(dynamic data) {
    String rawAlamatIdUser =
        '${data.alamatLegalAlamat}, RT ${data.alamatLegalRt}/ RW ${data.alamatLegalRw}, Kel. ${data.alamatLegalKelurahan}, Kec. ${data.alamatLegalKecamatan}, ${data.alamatLegalKota}, ${data.alamatLegalKodepos}';
    String rawTempatTanggalLahir = "${data.tempatLahir}, ${data.tanggalLahir}";

    state.namaLengkapUser = Fungsi.formatTitleCase(data.namaLengkap);
    state.nomorIdUser = Fungsi.formatTitleCase(data.nomorId);
    state.tempatTanggalLahirUser =
        Fungsi.formatTitleCase(rawTempatTanggalLahir);
    state.alamatDomisiliUser = Fungsi.formatTitleCase(data.alamatDomisili);
    state.nomorTeleponUser = Fungsi.formatTitleCase(data.noTelepon);
    state.alamatSesuaiIdUser = Fungsi.formatTitleCase(rawAlamatIdUser);
    state.nomorKontrakUser = Fungsi.formatTitleCase(data.noKontrak);
    state.emailUser = data.email;
    update();
  }
}
