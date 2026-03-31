import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jmcare/service/BaseService.dart';

import '../helper/Endpoint.dart';
import '../model/api/GetDetailRiwayatSdpRespon.dart';

class GetDetailRiwayatSdpService extends BaseService {
  static GetDetailRiwayatSdpService instance = GetDetailRiwayatSdpService();

  Future<Map<String, dynamic>?> getDetailSdpByNoTiket(
      {required String noTiket}) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      var client = BaseService.client;
      client.options.baseUrl = Endpoint.base_url;

      final response = await client.post(Endpoint.TAG_GET_DETAIL_RIWAYAT_SDP,
          data: {'no_tiket': noTiket},
          options: Options(headers: BaseService.headerJSON));

      if (response.data != null && response.data is Map<String, dynamic>) {
        return response.data;
      }
      return null;
    } catch (e) {
      debugPrint('Error service: $e');
      return null;
    }
  }
}
