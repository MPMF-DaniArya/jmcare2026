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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addNewForm();
    state.jenisData.forEach(
      (element) => ddJenisData.add(DropdownMenuItem(
        value: element,
        child: Text(element),
      )),
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    for (var map in state.formList) {
      map['input1']!.dispose();
      map['input2']!.dispose();
    }
    super.onClose();
  }

  void addNewForm() {
    if (state.formList.length < state.maxForms) {
      state.formList.add({
        'input1': TextEditingController(),
        'input2': TextEditingController(),
      });
    } else {
      Fungsi.errorToast('Anda telah mencapai batas maksimum formulir.');
    }
  }

  void removeForm(int index) {
    state.formList[index]['input1']?.dispose();
    state.formList[index]['input2']?.dispose();

    state.formList.removeAt(index);
  }

  void pickFile() async {
    state.lampiran = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'heic', 'doc', 'docx'],
        allowMultiple: false,
        allowCompression: true);
    if (state.lampiran != null) {
      state.platformFile = state.lampiran!.files.first;
      state.fileSizes = state.platformFile!.size.toString();
      state.filePath = state.platformFile!.path.toString();

      if (int.parse(state.fileSizes) >= 10000000) {
        Fungsi.warningToast("File tidak boleh lebih besar dari 10MB");
        return;
      } else {
        File file = File(state.filePath);
        final b = await file.readAsBytes();
        state.base64_file = base64Encode(b);
        update();
      }
    }
  }

  void submitData() {
    for (int i = 0; i < state.formList.length; i++) {
      var item = state.formList[i];
      print("Form ke-${i + 1}:");
      print("Input 1: ${item['input1']?.text}");
      print("Input 2: ${item['input2']?.text}");
    }
  }
}
