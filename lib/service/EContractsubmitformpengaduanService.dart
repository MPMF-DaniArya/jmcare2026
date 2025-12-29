import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';

import '../helper/Endpoint.dart';

class EContractsubmitformpengaduanService extends BaseService {

  static EContractsubmitformpengaduanService instance = EContractsubmitformpengaduanService();
  Future<BaseRespon?> submitFormPengaduan(
        int login_user_id,
        String nama_lengkap,
        String nomor_hp,
        String agreement_no,
        String email,
        String pesan
      ) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postJSON(Endpoint.TAG_ECONTRACT_SUBMIT_FORMPENGADUAN, body: {
        "login_user_id":login_user_id,
        "nama_lengkap": nama_lengkap,
        "nomor_hp": nomor_hp,
        "agreement_no": agreement_no,
        "email": email,
        "pesan": pesan
      });
    }catch(e){
      return BaseError();
    }
  }
}