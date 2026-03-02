import 'package:flutter/material.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/DownloadPdfPdpRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class DownloadPdpPdfService extends BaseService {
  static DownloadPdpPdfService instance = DownloadPdpPdfService();

  Future<DownloadPdfPdpRespon?> downloadPdfPdp(
      {required int login_user_id,
      required String pinJmcare,
      required String email}) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postJSON(Endpoint.TAG_DOWNLOAD_PDP_PDF, body: {
        "login_user_id": login_user_id,
        "pin_jmcare": pinJmcare,
        "email": email
      });
    } catch (e) {
      debugPrint("Error Service: $e");
      DownloadPdfPdpError();
    }
  }
}
