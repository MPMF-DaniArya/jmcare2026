import 'package:flutter/material.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/service/BaseService.dart';

import '../model/api/GetRiwayatPpdRespon.dart';

class GetRiyawatPdpService extends BaseService {
  static GetRiyawatPdpService instance = GetRiyawatPdpService();

  Future<GetRiwayatPpdRespon?> getRiwayatPdp(
      {required int userId, String status = ""}) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postJSON(Endpoint.TAG_HISTORY_PENGKINIAN_DATA_PRIBADI, body: {
        'login_user_id': userId,
        'status': status,
      });
    } catch (e) {
      debugPrint("Error Service: $e");
      return GetRiwayatPdpError();
    }
  }
}
