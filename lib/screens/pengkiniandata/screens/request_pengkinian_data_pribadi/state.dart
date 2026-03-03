import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RequestPengkinianDataPribadiState {
  GlobalKey<FormState>? formKey;
  var formList = <Map<String, dynamic>>[].obs;
  final int maxForms = 5;
  String? namaLengkapUser;
  String? nomorIdUser;
  String? tempatTanggalLahirUser;
  String? alamatSesuaiIdUser;
  String? alamatDomisiliUser;
  String? nomorTeleponUser;
  String? nomorKontrakUser;

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
