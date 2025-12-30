import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class LayananPengaduanSubmitFormService extends BaseService {
  static LayananPengaduanSubmitFormService instance =
      LayananPengaduanSubmitFormService();

  Future<BaseRespon?> submitFormLayananPengaduan(
      {required int login_user_id,
      required String nama_lengkap,
      required String nomor_hp,
      required String agreement_no,
      required String kritikSaranPengaduan,
      String lampiran = ''}) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postJSON(Endpoint.TAG_LAYANAN_PENGADUAN_SUBMIT, body: {
        'login_user_id': login_user_id,
        'nama_lengkap': nama_lengkap,
        'hp': nomor_hp,
        'no_agreement': agreement_no,
        'isi_kritik': kritikSaranPengaduan,
        'lampiran': lampiran,
        'create_by': login_user_id.toString()
      });
    } catch (e) {
      return BaseError();
    }
  }
}
