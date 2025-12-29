import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/FormlanjutRequest.dart';
import 'package:jmcare/model/api/MpmiSubmitClaimDetail.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/klaim_asuransi/upload_sttlp/state.dart';
import 'package:get/get.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/klaimasuransi/InsertformlanjutService.dart';

import '../../../model/api/MpmiBaseRespon.dart';
import '../../../service/klaimasuransi/MpmiClaimDetailService.dart';

class UploadsttlpLogic extends BaseLogic{

  final UploadsttlpState state = UploadsttlpState();
  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    askPermission();
    getDetail();
  }

  void getDetail(){
    state.strRequest = Get.arguments["detail"];
    state.strMpmiRequest = Get.arguments["mpmirequest"];

    print("model lanjut " + " " + state.strRequest);
    print("model mpmi request " + state.strMpmiRequest);

    var model = jsonDecode(state.strRequest);
    var mpmi_model = jsonDecode(state.strMpmiRequest);

    state.request = FormlanjutRequest.fromJson(model);
    state.mpmiRequest = MpmiSubmitClaimDetail.fromJson(mpmi_model);
  }

  void submitJMCare() async {
    is_loading.value = true;
    final responJMCare = await getService<InsertformlanjutService>()?.insertFormLanjut(state.request!);
    is_loading.value = false;
    if (responJMCare is BaseError || responJMCare == null){
      Fungsi.koneksiError();
    }else{
      if (responJMCare.code == "100"){
        Fungsi.errorToast(responJMCare.message!);
      }else{
        Get.offAllNamed(Konstan.rute_home);
        Fungsi.suksesToast("Formulir klaim asuransi berhasil disimpan");
      }
    }
    is_loading.value = false;
  }

  void submit() async {
    if (state.result == null){
      Fungsi.warningToast("File STTLP belum dipilih");
    }else{
      is_loading.value = true;
      //tambahin base64 pick file ke model request
      state.request!.stplKepolisian = state.base64_file;
      state.mpmiRequest!.documentDetail!.add(DocumentDetail(sTPL: state.base64_file));
      //hit api dulu ke mpmi
      final respon = await getService<MpmiClaimDetailService>()?.submitClaimDetail(state.mpmiRequest!);
      is_loading.value = false;
      Get.back();
      if (respon is MpmibaseError || respon == null){
        Fungsi.koneksiError();
      }else{
        if (respon.status == "1"){
          Fungsi.suksesToast(respon.message!);
          //kalau sukses api incsco
          //hit api ke jmcare
          submitJMCare();
          // final responJMCare = await getService<InsertformlanjutService>()?.insertFormLanjut(state.request!);
          // is_loading.value = false;
          // if (responJMCare is BaseError){
          //   Fungsi.errorToast("Error : Gagal memproses formulir klaim asuransi");
          // }else{
          //   if (responJMCare!.code == "100"){
          //     Fungsi.errorToast(responJMCare.message!);
          //   }else{
          //     Get.offAllNamed(Konstan.rute_home);
          //     Fungsi.suksesToast("Formulir klaim asuransi berhasil disimpan");
          //   }
          // }
        }else{
          Fungsi.errorToast(respon.message!);
        }
      }
    }
  }

  void pickFile() async {
    state.result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowCompression: true
    );
    if (state.result != null){
      state.platformFile = state.result!.files.first;
      state.fileName = state.platformFile!.name;
      state.fileBytes = state.platformFile!.bytes.toString();
      state.fileSizes = state.platformFile!.size.toString();
      state.fileExtension = state.platformFile!.extension.toString();
      state.filePath = state.platformFile!.path.toString();

      print("== " + state.fileName);
      print("== " + state.fileBytes);
      print("== " + state.fileSizes);
      print("== " + state.fileExtension);
      print("== " + state.filePath);

      if (int.parse(state.fileSizes) >= 2000000){
        Fungsi.warningToast("File PDF tidak boleh lebih besar dari 2MB");
        return;
      }else{
        File file = File(state.filePath);
        final b = await file.readAsBytes();
        state.base64_file = base64Encode(b);
        state.request!.stplKepolisian = state.base64_file;
        print(state.base64_file.substring(0,50));
        update();
      }
    }
  }
}