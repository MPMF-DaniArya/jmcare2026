import 'dart:io';

import 'package:flutter/cupertino.dart';

class LayananPengaduanState {
  GlobalKey<FormState>? formKey;
  TextEditingController? tecNamaLengkap;
  TextEditingController? tecNoHp;
  TextEditingController? tecEmail;
  TextEditingController? tecTipeUnit;
  TextEditingController? tecNoPlat;
  TextEditingController?  tecKritikDanSaran;
  File? lampiran;

  LayananPengaduanState() {
    formKey = GlobalKey<FormState>();
    tecNamaLengkap = TextEditingController();
    tecNoHp = TextEditingController();
    tecEmail = TextEditingController();
    tecKritikDanSaran = TextEditingController();
    tecTipeUnit = TextEditingController();
    tecNoPlat = TextEditingController();
  }
}