import 'dart:convert';

import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/DetailFormLanjutanRequest.dart';
import 'package:jmcare/model/api/DetailFormLanjutanRespon.dart';
import 'package:jmcare/model/api/FormlanjutRequest.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/BaseRespon.dart';

class DetailFormLanjutanService extends BaseService {
  static DetailFormLanjutanService instance = DetailFormLanjutanService();
  Future<DetailFormLanjutanRespon?> getDetailFormLanjutan(DetailFormLanjutanRequest request) async {
    final bodi = request.toJson();
    try{
      return postJSON(Endpoint.TAG_KLAIM_ASURANSI_DETAIL_FORM_LANJUTAN, body: bodi);
    }catch(e){
      return DetailFormLanjutanError();
    }
  }
}