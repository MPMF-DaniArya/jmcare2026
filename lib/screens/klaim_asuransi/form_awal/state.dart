import 'package:flutter/material.dart';


class FormawalState {

  GlobalKey<FormState>? formKey;
  TextEditingController? tecTgllapor;
  TextEditingController? tecNoKontrak;
  TextEditingController? tecNamaTertanggung;
  TextEditingController? tecNomorPolis;
  TextEditingController? tecJenisPertanggungan;
  TextEditingController? tecTglKejadian;
  String tipeKlaim = "";
  String jenisKlaim = "";
  String strTglLapor = "";
  String strTglKejadian = "";
  String branch_id = "";
  String branch_name = "";

  FormawalState(){
    formKey = GlobalKey<FormState>();
    tecTgllapor = TextEditingController();
    tecNoKontrak = TextEditingController();
    tecNamaTertanggung = TextEditingController();
    tecNomorPolis = TextEditingController();
    tecJenisPertanggungan = TextEditingController();
    tecTglKejadian = TextEditingController();
    jenisKlaim = "";
  }
}