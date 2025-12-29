import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/MpmiSubmitClaimDetail.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/MpmiBaseRespon.dart';

class MpmiClaimDetailService extends BaseService {
  static MpmiClaimDetailService instance = MpmiClaimDetailService();
  Future<MpmiBaseRespon?> submitClaimDetail(MpmiSubmitClaimDetail request) async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      final bodi = request.toJson();
      return postMPMI(Endpoint.TAG_MPMI_SUBMIT_CLAIM_DETAIL, body: bodi);
    }catch(e){
      return MpmibaseError();
    }
  }
}