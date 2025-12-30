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
  String fileName = "";
  String fileBytes = "";
  String fileSizes = "";
  String fileExtension = "";
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
}
