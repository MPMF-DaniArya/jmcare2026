import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/BaseRespon.dart';

class DownloadsuratkeputusanService extends BaseService {
  static DownloadsuratkeputusanService instance = DownloadsuratkeputusanService();
  Future<BaseRespon?> downloadSuratKeputusan(String file_name) async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postJSON(Endpoint.TAG_KLAIM_ASURANSI_DOWNLOAD_SURAT_KEPUTUSAN, body: {
        "file_name": file_name
      });
    }catch(e){
      return BaseError();
    }
  }
}