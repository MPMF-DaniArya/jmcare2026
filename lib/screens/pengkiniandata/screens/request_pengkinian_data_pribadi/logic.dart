import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_pengkinian_data_pribadi/state.dart';

class RequestPengkinianDataPribadiLogic extends BaseLogic {
  final RequestPengkinianDataPribadiState state =
      RequestPengkinianDataPribadiState();
  var ddJenisData = <DropdownMenuItem<String>>[].obs;

  final List<String> jenisDataWajibUploadDokumen = [
    'Nama Lengkap',
    'Alamat Domisili',
    'Alamat KTP',
  ];

  @override
  void onInit() {
    super.onInit();
    addFormBaru();
  }

  List<String> getJenisDataTersedia(int currentIndex) {
    List<String?> jenisDataDipilih = state.formList
        .asMap()
        .entries
        .where(
          (jenisData) => jenisData.key != currentIndex,
        )
        .map((jenisData) => jenisData.value['jenisDataTerpilih'] as String?)
        .toList();

    return state.jenisData.where((element) {
      return !jenisDataDipilih.contains(element);
    }).toList();
  }

  void addFormBaru() {
    bool isSemuaFormSudahTerisi = state.formList.every((form) {
      String? jenisData = form['jenisDataTerpilih'];
      TextEditingController? tec = form['tecDataBaru'];
      bool isWajib = jenisDataWajibUploadDokumen.contains(jenisData);
      bool isDokumenTerisi = !isWajib || (form['lampiran'] != null);
      
      return jenisData != null && tec != null && tec.text.trim().isNotEmpty && isDokumenTerisi;
    });

    if (state.formList.isNotEmpty && !isSemuaFormSudahTerisi) {
      Fungsi.warningToast(
          'Mohon lengkapi jenis data, perubahan data, dan dokumen (jika wajib) pada form sebelumnya.');
      return;
    }

    if (state.formList.length < state.maxForms) {
      state.formList.add({
        'tecDataBaru': TextEditingController(),
        'jenisDataTerpilih': null,
        'lampiran': null,
        'base64_file': "",
        'namaFile': "",
      });
    } else {
      Fungsi.errorToast('Anda telah mencapai batas maksimum formulir.');
    }
  }

  void updateJenisDataTerpilih(int index, String? value) {
    state.formList[index]['jenisDataTerpilih'] = value;
    state.formList.refresh();
    update();
  }

  void hapusForm(int index) {
    state.formList[index]['tecDataBaru']?.dispose();
    state.formList.removeAt(index);
    update();
  }

  void pilihFile(int index) async {
    FilePickerResult? hasil = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'heic', 'doc', 'docx'],
        allowMultiple: false,
        allowCompression: true);
    if (hasil != null) {
      PlatformFile file = hasil.files.first;

      if (file.size >= 10000000) {
        Fungsi.warningToast("File tidak boleh lebih besar dari 10MB");
        return;
      } else {
        File fileObj = File(file.path!);
        final b = await fileObj.readAsBytes();
        state.formList[index]['lampiran'] = hasil;
        state.formList[index]['namaFile'] = file.name;
        state.formList[index]['base64_file'] = base64Encode(b);
        state.formList.refresh();
        update();
      }
    }
  }

  void hapusFile(int index) {
    state.formList[index]['lampiran'] = null;
    state.formList[index]['namaFile'] = "";
    state.formList[index]['base64_file'] = "";
    state.formList.refresh();
    update();
  }

  void submitData() {
    if (state.formKey?.currentState?.validate() ?? false) {
      bool isSemuaFormSudahTerisi = state.formList.every((form) {
        String? jenisData = form['jenisDataTerpilih'];
        TextEditingController? tec = form['tecDataBaru'];
        bool isWajib = jenisDataWajibUploadDokumen.contains(jenisData);
        bool isDokumenTerisi = !isWajib || (form['lampiran'] != null);

        return jenisData != null && tec != null && tec.text.trim().isNotEmpty && isDokumenTerisi;
      });

      if (!isSemuaFormSudahTerisi) {
        Fungsi.warningToast(
            'Mohon lengkapi semua form dan dokumen wajib yang telah ditambahkan.');
        return;
      }

      for (int i = 0; i < state.formList.length; i++) {
        var item = state.formList[i];
        print(
            "Form ke-${i + 1}: Jenis Data: ${item['jenisDataTerpilih']}, Data Baru: ${item['tecDataBaru']?.text}, File: ${item['namaFile']}");
      }
    }
  }
}
