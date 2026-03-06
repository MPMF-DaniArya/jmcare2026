import 'package:flutter/material.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class PengkinianDataPribadiSubmitFormService extends BaseService {
  static PengkinianDataPribadiSubmitFormService instance =
      PengkinianDataPribadiSubmitFormService();

  Future<BaseRespon?> submitFormPengkinianDataPribadi(
      {required int login_user_id,
      required String jenis_perubahan_data,
      required String data_saat_ini,
      required String perubahan_data,
      required String file_pendukung,
      required String file_ktp,
      required String file_kk}) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      List<Map<String, dynamic>> requestBody = [
        {
          "login_user_id": login_user_id,
          "jenis_perubahan_data": jenis_perubahan_data,
          "data_saat_ini": data_saat_ini,
          "perubahan_data": perubahan_data,
          "file_pendukung": file_pendukung,
          "file_ktp": file_ktp,
          "file_kk": file_kk
        }
      ];

      return postJSONList(Endpoint.TAG_SUBMIT_REQ_PENGKINIAN_DATA_PRIBADI,
          body: requestBody);
    } catch (e) {
      debugPrint("Error Service: $e");
      return BaseError();
    }
  }
}
