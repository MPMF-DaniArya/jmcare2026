
import 'package:get/get.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/service/BaseService.dart';

import '../model/api/KodeposRespon.dart';

class KodeposService extends BaseService {
  static KodeposService instance = KodeposService();
  Future<KodeposRespon?> getKodepos(String kelurahan, String kecamatan, String kabupaten) async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getResources(Endpoint.TAG_KODEPOS_INDONESIA, body: {
        "kelurahan": kelurahan.replaceAll("KOTA ", "").replaceAll("KABUPATEN ", "").removeAllWhitespace,
        "kecamatan": kecamatan,
        "kabupaten": kabupaten.replaceAll("KOTA ", "").replaceAll("KABUPATEN ", "").removeAllWhitespace
      });
    }catch(e){
      return KodeposError();
    }
  }
}