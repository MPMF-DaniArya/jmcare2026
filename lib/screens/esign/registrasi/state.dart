import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EsignRegisterState {
  ImagePicker? imagePicker;
  GlobalKey<FormState>? formKey;
  File? imageKTP;
  File? imageProfil;
  String base64_ktp = "";
  String base64_profil = "";
  TextEditingController? tecPassword;
  TextEditingController? tecUlangpassword;
  String detail = "";

  EsignRegisterState() {
    formKey = GlobalKey<FormState>();
    imagePicker = ImagePicker();
    tecPassword = TextEditingController();
    tecUlangpassword = TextEditingController();
  }
}
