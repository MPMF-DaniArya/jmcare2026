import 'package:jmcare/model/api/AgreementcardRespon.dart';
import 'package:jmcare/model/api/AgreementinscoRespon.dart';
import 'package:jmcare/model/api/AntriansekarangRespon.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/CabangRespon.dart';
import 'package:jmcare/model/api/CekRegistrasiesignRespon.dart';
import 'package:jmcare/model/api/DetailFormLanjutanRespon.dart';
import 'package:jmcare/model/api/DownloadRespon.dart';
import 'package:jmcare/model/api/DropdownRespon.dart';
import 'package:jmcare/model/api/EpolisRespon.dart';
import 'package:jmcare/model/api/EsignRegisterRespon.dart';
import 'package:jmcare/model/api/EsignRequestStampRespon.dart';
import 'package:jmcare/model/api/EsignSentotpRespon.dart';
import 'package:jmcare/model/api/EsigncekstampRespon.dart';
import 'package:jmcare/model/api/EsigndownloadRespon.dart';
import 'package:jmcare/model/api/EsigninvitationRespon.dart';
import 'package:jmcare/model/api/EsignsignRespon.dart';
import 'package:jmcare/model/api/EsignstatussignRespon.dart';
import 'package:jmcare/model/api/EsignunsignedRespon.dart';
import 'package:jmcare/model/api/FaqRespon.dart';
import 'package:jmcare/model/api/FormawalRespon.dart';
import 'package:jmcare/model/api/FormlanjutanRespon.dart';
import 'package:jmcare/model/api/GradeRespon.dart';
import 'package:jmcare/model/api/HistoripoinRespon.dart';
import 'package:jmcare/model/api/JenisklaimRespon.dart';
import 'package:jmcare/model/api/JmoRespon.dart';
import 'package:jmcare/model/api/KategoriRespon.dart';
import 'package:jmcare/model/api/KodeposRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/MpmiBaseRespon.dart';
import 'package:jmcare/model/api/MpmiTokenRequest.dart';
import 'package:jmcare/model/api/NotifikasiRespon.dart';
import 'package:jmcare/model/api/OtpModel.dart';
import 'package:jmcare/model/api/PaginationuserRespon.dart';
import 'package:jmcare/model/api/PertanyaanRespon.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart';
import 'package:jmcare/model/api/ProdukRespon.dart';
import 'package:jmcare/model/api/PromoRespon.dart';
import 'package:jmcare/model/api/RiwayatantrianRespon.dart';
import 'package:jmcare/model/api/SlideshowRespon.dart';
import 'package:jmcare/model/api/WilayahRespon.dart';
import 'package:jmcare/model/session/RegisterpinModel.dart';
import 'package:jmcare/model/session/ResetPassModel.dart';
import 'package:jmcare/model/session/SelectedMethod.dart';
import 'package:jmcare/model/api/SmsRespon.dart';
import 'package:jmcare/model/session/ShowWelcome.dart';
import '../api/NotifRespon.dart';
import '../api/VersiRespon.dart';

class ModelGenerator {
  static ModelGenerator instance = ModelGenerator();
  get classes {
    return {
      LoginRespon: (json) => LoginRespon.fromJson(json),
      BaseRespon: (json) => BaseRespon.fromJson(json),
      ResetPassModel: (json) => ResetPassModel.fromJson(json),
      SelectedMethod: (json) => SelectedMethod.fromJson(json),
      SmsRespon: (json) => SmsRespon.fromJson(json),
      OtpModel: (json) => OtpModel.fromJson(json),
      VersiRespon: (json) => VersiRespon.fromJson(json),
      SlideshowRespon: (json) => SlideshowRespon.fromJson(json),
      ProdukRespon: (json) => ProdukRespon.fromJson(json),
      PromoRespon: (json) => PromoRespon.fromJson(json),
      ShowWelcome: (json) => ShowWelcome.fromJson(json),
      GradeRespon: (json) => GradeRespon.fromJson(json),
      HistoripoinRespon: (json) => HistoripoinRespon.fromJson(json),
      PaginationuserRespon: (json) => PaginationuserRespon.fromJson(json),
      CabangRespon: (json) => CabangRespon.fromJson(json),
      RegisterpinModel: (json) => RegisterpinModel.fromJson(json),
      PilihkontrakRespon: (json) => PilihkontrakRespon.fromJson(json),
      AgreementcardRespon: (json) => AgreementcardRespon.fromJson(json),
      EpolisRespon: (json) => EpolisRespon.fromJson(json),
      DownloadRespon: (json) => DownloadRespon.fromJson(json),
      KategoriRespon: (json) => KategoriRespon.fromJson(json),
      RiwayatantrianRespon: (json) => RiwayatantrianRespon.fromJson(json),
      PertanyaanRespon: (json) => PertanyaanRespon.fromJson(json),
      AntriansekarangRespon: (json) => AntriansekarangRespon.fromJson(json),
      NotifikasiRespon: (json) => NotifikasiRespon.fromJson(json),
      WilayahRespon: (json) => WilayahRespon.fromJson(json),
      JmoRespon: (json) => JmoRespon.fromJson(json),
      CekRegistrasiesignRespon: (json) => CekRegistrasiesignRespon.fromJson(json),
      EsigninvitationRespon: (json) => EsigninvitationRespon.fromJson(json),
      EsignRegisterRespon: (json) => EsignRegisterRespon.fromJson(json),
      EsignunsignedRespon: (json) => EsignunsignedRespon.fromJson(json),
      EsignSentotpRespon: (json) => EsignSentotpRespon.fromJson(json),
      EsignsignRespon: (json) => EsignsignRespon.fromJson(json),
      EsignstatussignRespon: (json) => EsignstatussignRespon.fromJson(json),
      EsigndownloadRespon: (json) => EsigndownloadRespon.fromJson(json),
      EsignRequestStampRespon: (json) => EsignRequestStampRespon.fromJson(json),
      EsigncekstampRespon: (json) => EsigncekstampRespon.fromJson(json),
      KodeposRespon: (json) => KodeposRespon.fromJson(json),
      JenisklaimRespon: (json) => JenisklaimRespon.fromJson(json),
      AgreementinscoRespon: (json) => AgreementinscoRespon.fromJson(json),
      FormawalRespon: (json) => FormawalRespon.fromJson(json),
      FormlanjutanRespon: (json) => FormlanjutanRespon.fromJson(json),
      DropdownRespon: (json) => DropdownRespon.fromJson(json),
      FaqRespon: (json) => FaqRespon.fromJson(json),
      MpmiBaseRespon: (json) => MpmiBaseRespon.fromJson(json),
      MpmiTokenRequest: (json) => MpmiTokenRequest.fromJson(json),
      NotifRespon: (json) => NotifRespon.fromJson(json),
      DetailFormLanjutanRespon: (json) => DetailFormLanjutanRespon.fromJson(json)
    };
  }

  static T? resolve<T>(Map<String, dynamic>? json) {
    if (instance.classes[T] == null) {
      throw "Tipe $T tidak ditemukan. Pastikan sudah diregister di generator";
    }
    return instance.classes[T](json);
  }
}
