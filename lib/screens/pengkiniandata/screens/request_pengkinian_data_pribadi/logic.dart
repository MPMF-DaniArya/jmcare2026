import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_pengkinian_data_pribadi/state.dart';

import '../../../../helper/Konstan.dart';

class RequestPengkinianDataPribadiLogic extends BaseLogic {
  final RequestPengkinianDataPribadiState state =
      RequestPengkinianDataPribadiState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addNewForm();
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

  void submitData() {
    for (int i = 0; i < state.formList.length; i++) {
      var item = state.formList[i];
      print("Form ke-${i + 1}:");
      print("Input 1: ${item['input1']?.text}");
      print("Input 2: ${item['input2']?.text}");
    }
  }
}
