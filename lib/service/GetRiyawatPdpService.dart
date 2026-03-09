import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../helper/Endpoint.dart';
import 'BaseService.dart';

class GetRiyawatPdpService extends BaseService {
  static GetRiyawatPdpService instance = GetRiyawatPdpService();

  // Kembalikan Future<dynamic> agar bisa menerima List atau Map
  Future<dynamic> getRiwayatPdp(
      {required int userId, String status = ""}) async {
    try {
      var client = BaseService.client;
      client.options.baseUrl = Endpoint.base_url;

      // JANGAN pakai <GetRiwayatPpdRespon> di sini
      final response = await client.post(
        Endpoint.TAG_HISTORY_PENGKINIAN_DATA_PRIBADI,
        data: {
          'login_user_id': userId,
          'status': status,
        },
        options: Options(headers: BaseService.headerJSON),
      );

      // Kembalikan data mentah (List) agar diolah di Logic
      return response.data;
    } catch (e) {
      debugPrint("Error Service: $e");
      return null;
    }
  }
}
