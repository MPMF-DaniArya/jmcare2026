import 'package:jmcare/model/api/FormawalRespon.dart';
import '../../helper/Endpoint.dart';
import '../BaseService.dart';

class RiwayatformawalService extends BaseService {
  static RiwayatformawalService instance = RiwayatformawalService();
  Future<FormawalRespon?> getRiwayatFormAwal(int login_user_id) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getResources(Endpoint.TAG_KLAIM_ASURANSI_RIWAYAT_FORM_AWAL, body: {
        "login_user_id":login_user_id
      });
    }catch(e){
      return FormawalError();
    }
  }
}
