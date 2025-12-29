import 'package:flutter/material.dart';

class CeknomorhpState{

  TextEditingController? tecNomorHP;
  GlobalKey<FormState>? formKey;
  String teksKembali = "Kembali";

  CeknomorhpState(){
    tecNomorHP = TextEditingController();
    formKey = GlobalKey<FormState>();
  }
}
