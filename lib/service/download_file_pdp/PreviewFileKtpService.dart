import 'package:flutter/material.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/DownloadFilePdpRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class PreviewFileKtpService extends BaseService {
  static PreviewFileKtpService instance = PreviewFileKtpService();

  Future<PreviewFilePdpRespon?> previewFileKtp({
    required int idPdp,
  }) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postJSON(Endpoint.TAG_DOWNLOAD_FILE_PDP,
          body: {'id': idPdp, 'jenis_file': 'file_ktp'});
    } catch (e) {
      debugPrint('Error service: $e');
      return DownloadFilePdpError();
    }
  }
}
