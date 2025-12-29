import 'package:jmcare/screens/base/base_state.dart';
import 'package:flutter/material.dart';

class FormpengaduanEContractState extends BaseState {

  final formKey = GlobalKey<FormState>();
  TextEditingController tecNamaLengkap = TextEditingController();
  TextEditingController tecAgreementNo = TextEditingController();
  TextEditingController tecNomorHP = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPesan = TextEditingController();
  String lemparan = "";
  int login_user_id = 0;
  String nomor_hp = "";
  String email = "";

  FormpengaduanEContractState(){

  }

}