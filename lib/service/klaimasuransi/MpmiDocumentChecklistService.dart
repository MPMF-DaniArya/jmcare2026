import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/MpmiBaseRespon.dart';
import 'package:jmcare/model/api/MpmiSubmitDocumentChecklist.dart';
import 'package:jmcare/service/BaseService.dart';

class MpmiDocumentChecklistService extends BaseService {
  static MpmiDocumentChecklistService instance = MpmiDocumentChecklistService();
  Future<MpmiBaseRespon?> submitDocumentChecklist(MpmiSubmitDocumentChecklist request) async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      final bodi = request.toJson();
      return postMPMI(Endpoint.TAG_MPMI_SUBMIT_DOCUMENT_CHECKLIST, body: bodi);
    }catch(e){
      return MpmibaseError();
    }
  }
}