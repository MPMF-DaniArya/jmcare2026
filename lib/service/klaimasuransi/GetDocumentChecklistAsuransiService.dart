import 'package:jmcare/service/BaseService.dart';

import '../../helper/Endpoint.dart';
import '../../model/api/BaseRespon.dart';


//class ini gunanya buat hit api
//buat get document checklist yang udah ditentukan sama insco
//lihat tabel jmcare.dbo.klaim_asuransi_formlanjutan -> field document_checklist_dari_asuransi
//alasan dibuat api ini adalah
//karena user harus tahu checklist apa saja yang ditentukan sama insco
//misalnya dari insco cuma nentuin doc check listnya => D01, D02, D03 doang...
//lha masalahnya, di page document itu kan nampilin semua master dropdown (dari D01,D02,dst sampat D20)
//kalau debitur centang sembarangan, waktu submit di api insco, bakan return error
//jadi debitur harus dibuatin filter, checklist dropdown mana aja yang harus dia centang
class GetDocumentChecklistAsuransiService extends BaseService {
  static GetDocumentChecklistAsuransiService instance = GetDocumentChecklistAsuransiService();
  Future<BaseRespon?> getDocumentChecklist(String id_formawal) async {
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postJSON(Endpoint.TAG_KLAIM_ASURANSI_GET_DOC_CHECKLIST_ASURANSI, body: {
        "ID_Formawal": id_formawal
      });
    }catch(e){
      return BaseError();
    }
  }
}