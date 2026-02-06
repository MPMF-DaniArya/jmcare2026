import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class LayananPengaduanState {
  GlobalKey<FormState>? formKey;
  TextEditingController? tecNamaLengkap;
  TextEditingController? tecNoHp;
  TextEditingController? tecEmail;
  TextEditingController? tecTipeUnit;
  TextEditingController? tecNoPlat;
  TextEditingController? tecKritikDanSaran;
  FilePickerResult? lampiran;
  PlatformFile? platformFile;
  String base64_file = "";
  String fileSizes = "";
  String filePath = "";

  LayananPengaduanState() {
    formKey = GlobalKey<FormState>();
    tecNamaLengkap = TextEditingController();
    tecNoHp = TextEditingController();
    tecEmail = TextEditingController();
    tecKritikDanSaran = TextEditingController();
    tecTipeUnit = TextEditingController();
    tecNoPlat = TextEditingController();
  }

  void dispose() {
    tecNamaLengkap?.dispose();
    tecNoHp?.dispose();
    tecEmail?.dispose();
    tecTipeUnit?.dispose();
    tecNoPlat?.dispose();
    tecKritikDanSaran?.dispose();
  }
}
