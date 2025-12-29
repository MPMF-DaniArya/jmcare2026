import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class Insertformawalservice extends BaseService {
  static Insertformawalservice instance = Insertformawalservice();

  Future<BaseRespon?> insertFormAwal(
        String login_user_id,
        String tgl_lapor,
        String agreement_no,
        String branch_id,
        String nama_tertanggung,
        String nomor_polis_asuransi,
        String jenis_pertanggungan,
        String tgl_kejadian,
        String tipe_klaim,
        String jenis_klaim,
        String status_klaim,
        String file_surat_keputusan
      ) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getResources(Endpoint.TAG_KLAIM_ASURANSI_INSERT_FORM_AWAL, body: {
        "login_user_id": login_user_id,
        "tgl_lapor": tgl_lapor,
        "agreement_no": agreement_no,
        "branch_id": branch_id,
        "nama_tertanggung": nama_tertanggung,
        "nomor_polis_asuransi": nomor_polis_asuransi,
        "jenis_pertanggungan": jenis_pertanggungan,
        "tgl_kejadian": tgl_kejadian,
        "tipe_klaim": tipe_klaim,
        "jenis_klaim": jenis_klaim,
        "status_klaim": status_klaim,
        "file_surat_keputusan": file_surat_keputusan
      });
    }catch(e){
      return BaseError();
    }
  }

}