import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/EsigninvitationRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class EsigninvitationService extends BaseService {
  static EsigninvitationService instance = EsigninvitationService();

  Future<EsigninvitationRespon?> invite(
    String provinsi,
    String kota,
    String kelurahan,
    String tmpLahir,
    String alamat,
    String tglLahir,
    String nama,
    String kecamatan,
    String tlp,
    String jenisKelamin,
    String idKtp,
    String kodePos,
    String email,
    String type,
  ) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postEsign(Endpoint.TAG_ESIGN_GENERATE_INVITATION, body: {
        "provinsi": provinsi,
        "kota": kota,
        "kelurahan": kelurahan,
        "tmpLahir": tmpLahir,
        "alamat": alamat,
        "tglLahir": tglLahir,
        "nama": nama,
        "kecamatan": kecamatan,
        "tlp": tlp,
        "jenisKelamin": jenisKelamin,
        "idKtp": idKtp,
        "kodePos": kodePos,
        "email": email,
        "type": type,
        "audit": {"callerId": "USER" + Endpoint.TAG_ESIGN_TENANT_CODE}
      });
    } catch (e) {
      return EsigninvitationError();
    }
  }
}
