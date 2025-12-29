import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/EsignRegisterRespon.dart';
import 'package:jmcare/service/BaseService.dart';

class Esignregisterservice extends BaseService {
  static Esignregisterservice instance = Esignregisterservice();

  Future<EsignRegisterRespon?> register(String nama, String email, String tmpLahir, String tglLahir, String jenisKelamin, String tlp, String idKtp, String alamat, String kecamatan, String kelurahan,
      String kota, String provinsi, String kodePos, String selfPhoto, String idPhoto, String password) async {
    await Future.delayed(const Duration(seconds: 0));
    try {
      return postEsign(Endpoint.TAG_ESIGN_REGISTER, body: {
        "audit": {"callerId": "User" + Endpoint.TAG_ESIGN_TENANT_CODE},
        "nama": nama,
        "email": email,
        "tmpLahir": tmpLahir,
        "tglLahir": tglLahir,
        "jenisKelamin": jenisKelamin,
        "tlp": tlp,
        "idKtp": idKtp,
        "alamat": alamat,
        "kecamatan": kecamatan,
        "kelurahan": kelurahan,
        "kota": kota,
        "provinsi": provinsi,
        "kodePos": kodePos,
        "selfPhoto": selfPhoto,
        "idPhoto": idPhoto,
        "password": password
      });
    } catch (e) {
      return EsignregisterError();
    }
  }
}
