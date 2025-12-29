
import 'dart:convert';

import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart';
import 'BaseService.dart';

class PilihkontrakService extends BaseService{

  static PilihkontrakService instance = PilihkontrakService();

  Future<PilihkontrakRespon?> getListKontrak(String noKTP) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      final bytes = utf8.encode(noKTP);
      final base64Str = base64.encode(bytes);
      print(base64Str);
      return getJsonArray(Endpoint.TAG_PILIH_KONTRAK, body: {
        "KTPNO":base64Str
      });
    }catch(e){
      return PilihkontrakError();
    }
  }
}
