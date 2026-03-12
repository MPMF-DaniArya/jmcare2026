import 'package:flutter/material.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class PengkinianDataPribadiSubmitFormService extends BaseService {
  static PengkinianDataPribadiSubmitFormService instance =
      PengkinianDataPribadiSubmitFormService();

  Future<BaseRespon?> submitFormPengkinianDataPribadi(
      {required List<Map<String, dynamic>> requestBody}) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postJSONList(Endpoint.TAG_SUBMIT_REQ_PENGKINIAN_DATA_PRIBADI,
          body: requestBody);
    } catch (e) {
      debugPrint("Error Service: $e");
      return BaseError();
    }
  }
}
