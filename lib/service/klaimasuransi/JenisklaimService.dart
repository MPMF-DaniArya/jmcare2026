import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/JenisklaimRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class Jenisklaimservice extends BaseService {
  static Jenisklaimservice instance = Jenisklaimservice();

  Future<JenisklaimRespon?> getJenisKlaim() async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getResources(Endpoint.TAG_KLAIM_ASURANSI_JENIS_KLAIM, body: {
      });
    }catch(e){
      return JenisklaimError();
    }
  }
}