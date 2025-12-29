import 'dart:convert';

import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/MpmiSubmitClaimRegister.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/MpmiBaseRespon.dart';

class MpmiClaimRegisterService extends BaseService {
  static MpmiClaimRegisterService instance = MpmiClaimRegisterService();
  Future<MpmiBaseRespon?> submitClaimRegister(MpmiSubmitClaimRegister request) async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      final bodi = request.toJson();
      return postMPMI(Endpoint.TAG_MPMI_SUBMIT_CLAIM_REGISTER, body: bodi);
    }catch(e){
      return MpmibaseError();
    }
  }
}