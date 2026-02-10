import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RequestPengkinianDataPribadiState {
  GlobalKey<FormState>? formKey;
  var formList = <Map<String, TextEditingController>>[].obs;
  final int maxForms = 3;
  FilePickerResult? lampiran;
  PlatformFile? platformFile;
  String base64_file = "";
  String fileSizes = "";
  String filePath = "";

  RequestPengkinianDataPribadiState() {
    formKey = GlobalKey<FormState>();
  }

  final List<String> jenisData = [
    'Nama Lengkap',
    'Alamat Domisili',
    'Alamat KTP',
    'Nomor Handphone',
    'Alamat Email'
  ];
}
