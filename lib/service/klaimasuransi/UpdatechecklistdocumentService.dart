import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/service/BaseService.dart';
import 'package:jmcare/model/api/BaseRespon.dart';

class UpdatechecklistdocumentService extends BaseService {
  static UpdatechecklistdocumentService instance = UpdatechecklistdocumentService();
  Future<BaseRespon?> doUpdate(int id_formawal, String arrayDocChecklist) async {
    await Future.delayed(Duration(seconds: 0));
    try{
      return postJSON(Endpoint.TAG_KLAIM_ASURANSI_UPDATE_CHECKLIST_DOCUMENT, body: {
        "id_formawal": id_formawal,
        "array_checklist_document": arrayDocChecklist
      });
    }catch(e){
      return BaseError();
    }
  }
}