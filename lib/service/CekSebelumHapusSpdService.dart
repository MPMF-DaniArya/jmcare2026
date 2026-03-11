import 'package:flutter/material.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class CekSebelumHapusSpdService extends BaseService {
  static CekSebelumHapusSpdService instance = CekSebelumHapusSpdService();

  Future<BaseRespon?> cekSebelumHapusSdp({required int idUser}) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postJSON(Endpoint.TAG_CEK_SEBELUM_HAPUS_SDP,
          body: {'login_user_id': idUser});
    } catch (e) {
      debugPrint("Error Service: $e");
      BaseError();
    }
  }
}
