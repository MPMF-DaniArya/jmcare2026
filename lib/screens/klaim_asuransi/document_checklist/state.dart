import 'package:flutter/material.dart';

import '../../../model/api/DocumentCodeModel.dart';

class DocumentchecklistState {

  String id_formawal = "0";
  String nomor_kontrak = "";
  String arrayChecklistDocument = "";
  String docChecklistFromAsuransi = "";
  List<DocumentCodeModel> dcm = List<DocumentCodeModel>.empty(growable: true);

  DocumentchecklistState(){

  }
}