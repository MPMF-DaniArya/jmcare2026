import 'package:flutter/material.dart';

class EsigninvitationState {
  GlobalKey<FormState>? formKey;
  TextEditingController? tecNama;
  TextEditingController? tecEmail;
  TextEditingController? tecNIK;
  TextEditingController? tecTmplahir;
  TextEditingController? tecTgllahir;
  TextEditingController? tecHP;
  TextEditingController? tecAlamat;
  TextEditingController? tecPropinsi;
  TextEditingController? tecKabupaten;
  TextEditingController? tecKecamatan;
  TextEditingController? tecKelurahan;
  TextEditingController? tecKodepos;

  int selected_id_propinsi = 0;
  int selected_id_kabupaten = 0;
  int selected_id_kecamatan = 0;
  int selected_id_kelurahan = 0;

  List<String> options_gender = ["M", "F"];
  String current_option_gender = "M";

  EsigninvitationState() {
    formKey = GlobalKey<FormState>();
    tecNama = TextEditingController();
    tecEmail = TextEditingController();
    tecNIK = TextEditingController();
    tecTmplahir = TextEditingController();
    tecTgllahir = TextEditingController();
    tecHP = TextEditingController();
    tecAlamat = TextEditingController();
    tecPropinsi = TextEditingController();
    tecKabupaten = TextEditingController();
    tecKecamatan = TextEditingController();
    tecKelurahan = TextEditingController();
    tecKodepos = TextEditingController();
    current_option_gender = options_gender[0];
  }
}
