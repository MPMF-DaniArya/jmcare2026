import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/AddantrianService.dart';
import 'package:jmcare/service/AgreementcardService.dart';
import 'package:jmcare/service/AntriansekarangService.dart';
import 'package:jmcare/service/CabangService.dart';
import 'package:jmcare/service/CekRegistrasiesignService.dart';
import 'package:jmcare/service/CekkuisionerService.dart';
import 'package:jmcare/service/CeknomorhpService.dart';
import 'package:jmcare/service/CekpengkiniandataService.dart';
import 'package:jmcare/service/DeleteakunService.dart';
import 'package:jmcare/service/DialogjmoService.dart';
import 'package:jmcare/service/DownloadepolisService.dart';
import 'package:jmcare/service/DropdownService.dart';
import 'package:jmcare/service/EContractdownloadService.dart';
import 'package:jmcare/service/EContractsubmitformpengaduanService.dart';
import 'package:jmcare/service/EpolisService.dart';
import 'package:jmcare/service/EsignRegisterService.dart';
import 'package:jmcare/service/EsignRequestStampService.dart';
import 'package:jmcare/service/EsignSentotpService.dart';
import 'package:jmcare/service/EsignUnsignedService.dart';
import 'package:jmcare/service/EsigncekstampService.dart';
import 'package:jmcare/service/EsigndownloadService.dart';
import 'package:jmcare/service/EsigninvitationService.dart';
import 'package:jmcare/service/EsignsignService.dart';
import 'package:jmcare/service/EsignstatussignService.dart';
import 'package:jmcare/service/FaqService.dart';
import 'package:jmcare/service/GantipasswordService.dart';
import 'package:jmcare/service/GradeService.dart';
import 'package:jmcare/service/HistoripoinService.dart';
import 'package:jmcare/service/JumlahdownloadService.dart';
import 'package:jmcare/service/KategoriService.dart';
import 'package:jmcare/service/KodeposService.dart';
import 'package:jmcare/service/KonfirmasikedatanganService.dart';
import 'package:jmcare/service/LupapinService.dart';
import 'package:jmcare/service/NotifikasiService.dart';
import 'package:jmcare/service/OnesignalUpdateIdService.dart';
import 'package:jmcare/service/OnesignalgetnotifService.dart';
import 'package:jmcare/service/OtpemailService.dart';
import 'package:jmcare/service/OtpwaService.dart';
import 'package:jmcare/service/PaginationuserService.dart';
import 'package:jmcare/service/PengkiniandataService.dart';
import 'package:jmcare/service/PertanyaanService.dart';
import 'package:jmcare/service/PilihkontrakService.dart';
import 'package:jmcare/service/RegisterDebiturService.dart';
import 'package:jmcare/service/RegisterNonDebiturService.dart';
import 'package:jmcare/service/ResetpasswordService.dart';
import 'package:jmcare/service/RiwayatantrianService.dart';
import 'package:jmcare/service/SearchuserService.dart';
import 'package:jmcare/service/SlideService.dart';
import 'package:jmcare/service/SmsService.dart';
import 'package:jmcare/service/SubmitjawabanService.dart';
import 'package:jmcare/service/SubmitlogdownloadService.dart';
import 'package:jmcare/service/VersiService.dart';
import 'package:jmcare/service/WilayahService.dart';
import 'package:jmcare/service/klaimasuransi/AgreementinscoService.dart';
import 'package:jmcare/service/klaimasuransi/CheckclaimavailableService.dart';
import 'package:jmcare/service/klaimasuransi/DetailFormLanjutanService.dart';
import 'package:jmcare/service/klaimasuransi/DownloadSuratKeputusanService.dart';
import 'package:jmcare/service/klaimasuransi/GetDocumentChecklistAsuransiService.dart';
import 'package:jmcare/service/klaimasuransi/InsertformawalService.dart';
import 'package:jmcare/service/klaimasuransi/InsertformlanjutService.dart';
import 'package:jmcare/service/klaimasuransi/JenisklaimService.dart';
import 'package:jmcare/service/klaimasuransi/MpmiClaimDetailService.dart';
import 'package:jmcare/service/klaimasuransi/MpmiClaimRegisterService.dart';
import 'package:jmcare/service/klaimasuransi/MpmiDocumentChecklistService.dart';
import 'package:jmcare/service/klaimasuransi/MpmiTokenService.dart';
import 'package:jmcare/service/klaimasuransi/RiwayatformawalService.dart';
import 'package:jmcare/service/klaimasuransi/UpdatechecklistdocumentService.dart';
import 'BaseService.dart';
import 'LoginService.dart';

class Service {
  Dio? client;
  static late Service instance;

  Service();

  Service.setup(this.client) {
    instance = this;
  }

  Map<Type, BaseService> get classes {
    return {
      LoginService: LoginService.instance,
      RegisterDebiturService: RegisterDebiturService.instance,
      RegisterNonDebiturService: RegisterNonDebiturService.instance,
      CeknomorhpService: CeknomorhpService.instance,
      OtpemailService: OtpemailService.instance,
      OtpwaService: OtpwaService.instance,
      SmsService: SmsService.instance,
      ResetpasswordService: ResetpasswordService.instance,
      VersiService: VersiService.instance,
      SlideService: SlideService.instance,
      GradeService: GradeService.instance,
      HistoripoinService: HistoripoinService.instance,
      PaginationuserService: PaginationuserService.instance,
      SearchuserService: SearchuserService.instance,
      DeleteakunService: DeleteakunService.instance,
      CabangService: CabangService.instance,
      LupapinService: LupapinService.instance,
      PilihkontrakService: PilihkontrakService.instance,
      AgreementcardService: AgreementcardService.instance,
      EpolisService: EpolisService.instance,
      DownloadepolisService: DownloadepolisService.instance,
      KategoriService: KategoriService.instance,
      AddantrianService: AddantrianService.instance,
      RiwayatantrianService: RiwayatantrianService.instance,
      KonfirmasikedatanganService: KonfirmasikedatanganService.instance,
      CekkuisionerService: CekkuisionerService.instance,
      PertanyaanService: PertanyaanService.instance,
      SubmitjawabanService: SubmitjawabanService.instance,
      AntriansekarangService: AntriansekarangService.instance,
      NotifikasiService: NotifikasiService.instance,
      CekpengkiniandataService: CekpengkiniandataService.instance,
      WilayahService: WilayahService.instance,
      DialogjmoService: DialogjmoService.instance,
      PengkiniandataService: PengkiniandataService.instance,
      CekRegistrasiesignService: CekRegistrasiesignService.instance,
      EsigninvitationService: EsigninvitationService.instance,
      Esignregisterservice: Esignregisterservice.instance,
      EsignunsignedService: EsignunsignedService.instance,
      EsignsentotpService: EsignsentotpService.instance,
      EsignsignService: EsignsignService.instance,
      EsignstatussignService: EsignstatussignService.instance,
      EsigndownloadService: EsigndownloadService.instance,
      EsignRequestStampService: EsignRequestStampService.instance,
      EsigncekstampService: EsigncekstampService.instance,
      KodeposService: KodeposService.instance,
      Jenisklaimservice: Jenisklaimservice.instance,
      Agreementinscoservice: Agreementinscoservice.instance,
      Insertformawalservice: Insertformawalservice.instance,
      RiwayatformawalService: RiwayatformawalService.instance,
      InsertformlanjutService: InsertformlanjutService.instance,
      DropdownService: DropdownService.instance,
      UpdatechecklistdocumentService: UpdatechecklistdocumentService.instance,
      FaqService: FaqService.instance,
      MpmitokenService: MpmitokenService.instance,
      MpmiClaimRegisterService: MpmiClaimRegisterService.instance,
      MpmiClaimDetailService: MpmiClaimDetailService.instance,
      MpmiDocumentChecklistService: MpmiDocumentChecklistService.instance,
      CheckclaimavailableService: CheckclaimavailableService.instance,
      GetDocumentChecklistAsuransiService: GetDocumentChecklistAsuransiService.instance,
      OnesignalUpdateIdService: OnesignalUpdateIdService.instance,
      OnesignalgetnotifService: OnesignalgetnotifService.instance,
      EContractsubmitformpengaduanService: EContractsubmitformpengaduanService.instance,
      EContractdownloadService: EContractdownloadService.instance,
      SubmitlogdownloadService: SubmitlogdownloadService.instance,
      JumlahdownloadService: JumlahdownloadService.instance,
      GantipasswordService: GantipasswordService.instance,
      DownloadsuratkeputusanService: DownloadsuratkeputusanService.instance,
      DetailFormLanjutanService: DetailFormLanjutanService.instance
    };
  }

  static T? resolve<T extends BaseService?>() {
    if (instance.classes[T] == null) {
      throw "$T belum diregistrasi. Periksa service!";
    }
    return instance.classes[T] as T?;
  }
}

T? getService<T extends BaseService>() {
  return Service.resolve<T>();
}
