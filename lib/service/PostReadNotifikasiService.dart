import 'package:flutter/material.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class PostReadNotifikasiService extends BaseService {
  static PostReadNotifikasiService instance = PostReadNotifikasiService();

  Future<BaseRespon?> isReadNotifikasi({required String idNotifikasi}) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postJSON(Endpoint.TAG_READ_NOTIFIKASI, body: {'id': idNotifikasi});
    } catch (e) {
      debugPrint("Error Service: $e");
      return BaseError();
    }
  }
}
