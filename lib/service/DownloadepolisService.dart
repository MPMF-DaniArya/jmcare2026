
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/DownloadRespon.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:get/get.dart';

import '../helper/Konstan.dart';

class DownloadepolisService extends BaseService {
  static DownloadepolisService instance = DownloadepolisService();

  Future<void> downloadEpolis(String baseURL, String fileName) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      await download(baseURL, fileName);
    }catch(e){
      Fungsi.errorToast(e.toString());
    }
  }

  Future<int> downloadEAgreement(String baseURL, String fileName, String nomorKontrak) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return await download(baseURL, fileName);
    }catch(e){
      // Fungsi.errorToast("$e, silakan mengisi formulir pengaduan");
      return 0;
    }
  }
}