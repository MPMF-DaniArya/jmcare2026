import 'dart:convert';

import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/FormlanjutRequest.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/BaseRespon.dart';

class InsertformlanjutService extends BaseService {
  static InsertformlanjutService instance = InsertformlanjutService();
  Future<BaseRespon?> insertFormLanjut(FormlanjutRequest request) async {
    final bodi = request.toJson();
    try{
      return getResources(Endpoint.TAG_KLAIM_ASURANSI_INSERT_FORM_LANJUTAN, body: bodi);
    }catch(e){
      return BaseError();
    }
  }
}