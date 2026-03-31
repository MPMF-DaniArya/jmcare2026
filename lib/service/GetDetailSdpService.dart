import 'package:flutter/material.dart';
import 'package:jmcare/model/api/SubjekDataPribadiRespon.dart';
import 'package:jmcare/service/BaseService.dart';

import '../helper/Endpoint.dart';

class GetDetailSdpService extends BaseService {
  static GetDetailSdpService instance = GetDetailSdpService();

  Future<SubjekDataPribadiRespon?> getDetailSdp(
      {required int login_user_id}) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postJSON(Endpoint.TAG_DETAIL_SDP_USER, body: {
        'login_user_id': login_user_id,
      });
    } catch (e) {
      debugPrint("Error Service: $e");
      return SubjekDataPribadiError();
    }
  }
}
