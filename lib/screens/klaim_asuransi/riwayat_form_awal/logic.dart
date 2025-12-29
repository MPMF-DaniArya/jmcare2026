import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/FormawalRespon.dart';
import 'package:jmcare/model/api/FormawalRespon.dart' as far;
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/klaim_asuransi/riwayat_form_awal/state.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/klaimasuransi/DownloadSuratKeputusanService.dart';
import 'package:jmcare/service/klaimasuransi/RiwayatformawalService.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../service/DownloadepolisService.dart';

class RiwayatformawalLogic extends BaseLogic {

  final RiwayatformawalState state = RiwayatformawalState();
  var obsRiwayatformawal = FormawalRespon().obs;
  var rowCount = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRiwayatformawal();
  }

  void downloadSuratKeputusan(int index) async {
    var statusStorage = await Permission.storage.request();
    if (obsRiwayatformawal.value.data![index].fileSuratKeputusan == null || obsRiwayatformawal.value.data![index].fileSuratKeputusan!.isEmpty){
      Fungsi.errorToast("Berkas surat keputusan tidak tersedia.");
    }else{

      is_loading.value = true;
      final file_name = obsRiwayatformawal.value.data![index].fileSuratKeputusan!;
      final hasil = await getService<DownloadsuratkeputusanService>()!.downloadSuratKeputusan(file_name);
      if (hasil != null){
        final base64File = hasil.message ?? "";
        Directory? dir;

        if (Platform.isAndroid){
          dir = Directory('/storage/emulated/0/Download/'); // for android
          if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
          File fileImg;
          final decodedBytes = base64Decode(base64File);
          fileImg = File('${dir.path}/$file_name');
          fileImg.writeAsBytesSync(List.from(decodedBytes));
          Fungsi.suksesToast("Surat keputusan berhasil didownload");
          OpenFile.open(fileImg.path);
        }else{
          dir = await getApplicationDocumentsDirectory();
          var path = "${dir.path}/$file_name";
          var file = File(path);
          final decodedBytes = base64Decode(base64File);
          file.writeAsBytesSync(List.from(decodedBytes));
          Fungsi.suksesToast("Surat keputusan berhasil didownload");
          OpenFile.open(file.path);
        }
      }
      is_loading.value = false;
    }
  }

  void gotoDocumentChecklist(int index){
    final data = obsRiwayatformawal.value.data![index];
    if (data.statusKlaim == Konstan.tag_status_klaim_insco_apv){
      Get.offAndToNamed(
          Konstan.rute_klaimasuransi_document_checklist,
          arguments: {
            "detail":obsRiwayatformawal.value.data![index].id.toString(),
            "nomor_kontrak": obsRiwayatformawal.value.data![index].agreementNo.toString()
          }
      );
    }else{
      Fungsi.errorToast("Menu tidak dapat diakses");
    }
  }
  void printt(){
    print("klikk");
  }

  void klikFormlanjut(far.Data model){
    if (model.statusKlaim == Konstan.tag_status_klaim_apv || model.statusKlaim == Konstan.tag_status_klaim_return){
      final String m = jsonEncode(model);
      Get.offAndToNamed(
          Konstan.rute_klaimasuransi_formlanjut,
          arguments: {
            "detail": m
          }
      );
    }else{
      Fungsi.errorToast("Tidak dapat memproses formulir klaim");
    }
  }

  //ini status klaim ya...
  void getRiwayatformawal() async {
    is_loading.value = true;
    final auth = await getStorage<LoginRespon>();
    final login_user_id = auth.data!.loginUserId;
    if (login_user_id == null){
      Fungsi.toastBelumLogin();
    }else{
      final respon = await getService<RiwayatformawalService>()?.getRiwayatFormAwal(int.parse(login_user_id));
      if (respon == null){
        rowCount.value = 0;
        Fungsi.koneksiError();
      }else{
        if (respon is FormawalError){
          rowCount.value = 0;
          Fungsi.koneksiError();
        }else{
          obsRiwayatformawal.value = respon!;
          rowCount.value = obsRiwayatformawal.value.data!.length;
        }
      }
    }
    is_loading.value = false;
  }
}