import 'package:jmcare/model/api/AgreementinscoRespon.dart';
import 'package:jmcare/service/BaseService.dart';

import '../../helper/Endpoint.dart';

class Agreementinscoservice extends BaseService {
  static Agreementinscoservice instance = Agreementinscoservice();

  Future<AgreementinscoRespon?> getAgreementInsco(String agreement_no) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getResources(Endpoint.TAG_KLAIM_ASURANSI_AGREEMENT_INSCO, body: {
        "agreement_no":agreement_no
      });
    }catch(e){
      return AgreementinscoError();
    }
  }
}