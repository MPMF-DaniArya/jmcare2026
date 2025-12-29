import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Endpoint {
  static const String base_url                  = "https://ws.mpm-finance.com/jmcare_dev/Service1.svc/";
  static const String base_url_jmo              = "https://ws.mpm-finance.com/JMOrderApi_dev/Service1.svc/";
  static const String base_url_mpmi             = "https://id.mpm-insurance.com:20011/api/JMFI/";
  static const String base_url_klaim_asuransi   = "file://///172.16.27.20/JMCare_Data/klaim_asuransi/";
  //
  // static const String base_url                 = "https://apicloud.jaccs-mpmfinance.com/JMCare-xrgis8hm4zcwdt3ktsgy/Service1.svc/";
  // static const String base_url_jmo             = "https://apicloud.jaccs-mpmfinance.com/JMOrderApi/Service1.svc/";
  // static const String base_url_mpmi            = "https://id.mpm-insurance.com:9505/api/JMFI/";
  // static const String base_url_klaim_asuransi  = "https://mobapps.mpm-finance.com/JMCare_Data/klaim_asuransi/";

  static const String base_url_esign = "https://gdkwebserver.ad-ins.com/adimobile/demo/esign/services/external/";
  // static const String base_url_esign =
  //     "https://esignhub.docsol.id/adimobile/esign/services/external/";

  static const String base_url_reset_pass_sms = "http://web-server-api.mpmf.com/M1cr0s1t3T3st1ng/Service1.svc/";

  static const String login = "login.json";
  static const String TAG_VERSION = "getversion.json";
  static const String TAG_REGISTER_DEBITUR = "LoginJM/register.json";
  static const String TAG_REGISTER_NONDEBITOR = "UpdateUserNonDebitur.json";
  static const String TAG_SUBMIT_AJUKAN_KREDIT = "submitajukankredit.json";
  static const String TAG_DETAIL_PENGAJUAN_KREDIT = "getdtlpengajuankredit/{nomor}";

  static const String TAG_DROPDOWN = "getDropdown.json";
  static const String TAG_FAQ_INSERT = "insertFAQ.json";
  static const String TAG_FAQ_GET = "getFAQ.json";

  static const String TAG_FORGET_PIN = "forgetpin.json";
  static const String TAG_AUTOFILL_PENGAJUANKREDIT = "autofillpengajuankredit.json";
  static const String TAG_GETEPOLIS = "getfile-url.json";
  static const String TAG_BANNER = "getwebsite-data.json";
  static const String TAG_GRADE = "getgradecustomer.json";
  static const String TAG_LIST_CABANG = "getlistcabang.json";

  static const String TAG_RESET_PASSWORD_CEK_NOMOR_HP = "CekNomorHP.json";
  static const String TAG_RESET_PASSWORD_OTP_BY_EMAIL = "otpbyemail.json";
  static const String TAG_RESET_PASSWORD_OTP_BY_WA = "otpbywa.json";
  static const String TAG_RESET_PASSWORD = "resetpassword.json";
  static const String TAG_GANTI_PASSWORD = "gantipassword.json";
  static const String TAG_RIWAYAT_POIN = "gethistorypointcustomer.json";

  static const String TAG_ANTRIAN_GET_ANTRIANBYCABANG = "getAntrianByCabang.json";
  static const String TAG_ANTRIAN_KONFIRMASI_KUISIONER = "getKonfirmasidanKuisioner.json";
  static const String TAG_ANTRIAN_GETLISTREQ_BPKB = "getlistReqBPKB/q=";
  static const String TAG_ANTRIAN_GETANTRIAN_SEKARANG = "getantriansekarang.json";
  static const String TAG_ANTRIAN_GETANTRIAN_ONLINE = "GetAntrianOnline.json";
  static const String TAG_ANTRIAN_KONFIRMASI_KEDATANGAN = "KonfirmasiKedatangan.json";
  static const String TAG_ANTRIAN_INSERT_APM = "apmInsertAntrian.json";
  static const String TAG_ANTRIAN_INSERT_ANTRIAN_CS = "InsertAntrianCS.json";
  static const String TAG_ANTRIAN_GETSUBKATEGORI = "getSubKategori.json/{jenis_pic}";
  static const String TAG_ANTRIAN_NOTIFIKASI_KUISIONER = "getNotifikasiKuisioner.json";
  static const String TAG_ANTRIAN_GET_PERTANYAAN = "getPertanyaan.json";
  static const String TAG_ANTRIAN_SUBMIT_JAWABAN = "submitJawaban.json";
  static const String TAG_ANTRIAN_TOLAK_KUISIONER = "tolakKuisioner.json";
  static const String TAG_ANTRIAN_KATEGORI = "getKategori.json";
  static const String TAG_ANTRIAN_CEK_KUISIONER = "cekKuisioner.json";

  static const String TAG_LIST_USER = "getlistuser.json";
  static const String TAG_PAGINATION_USER = "paginationuser.json";
  static const String TAG_SEARCH_USER = "searchuser.json";
  static const String TAG_AGREEMENT_CARD = "getlistagrmntcard.json";
  static const String TAG_GET_LIST_AGREEMENT_KTP = "getlistagrmntktp_new.json";
  // static const String TAG_PILIH_KONTRAK = "listAgreementByKTP.json";
  static const String TAG_PILIH_KONTRAK = "getlistagrmntktp_new.json";
  static const String TAG_TOKEN_ENKRIPSI =
      "EoXiV1ZgSXdhKC94fsAGOdgMDZZK3VCBjSuP3Phd6s3yD55vDhevxRoyjt2fvm8PADweDeMvaVM9IfqDC5lQO7p38I2toddcwigjlcZeXXEB0O2Pmyo177gmofpvQgGVXGcjXpL3Qqu5AHkYj0ZdsAgWhtqsF0c7Ip388oTWV0rHkUwVvhcCuU70SYTo8KkMBgJKtPYwvKH3PWCh9GWm3JWk5MGrLPdzI0RpMatdG8bL6j9ErFXs0dIgjIlhLOAL6bl7hPhGlKAYFfTcxDLQZWcIyhflwscVhL7Dod8tF8cs0rQTavH5u17MyVzbIJH70EAZHG4XpbWqAZTyJfOQrhYSv4QfQETyjr2";
  static const String TAG_DELETE_AKUN = "DeleteAccount.json";

  static const String TAG_KONFIRMASI_TOPUP_PLAFOND = "konfirmasiTopupPlafond.json";
  static const String TAG_BATALKAN_TOPUP_PLAFOND = "batalkanTopupPlafond.json";
  static const String TAG_HISTORI_TOPUP_PLAFOND = "historiTopupPlafond.json";
  static const String TAG_KONFIRMASI_BATAL_TOPUP_PLAFOND = "cekKonfBatalTopupPlafond.json";
  static const String TAG_PENCAIRAN_DAN_ANGSURAN = "GetPencairanDanAngsuran.json";
  static const String TAG_INSERT_TOPUPPLAFOND_JMCARE = "insertTopUpPlafond_JMCare.json";
  static const String TAG_JM_SUBMIT_ORDER = "jm_submitorder.json";
  static const String TAG_GETPRICE_FROMBRAND = "getpricefrom_brandtype.json";
  static const String TAG_PARAM_COMBO = "getlistparam-combo.json";
  static const String TAG_VIEWLIST_JENISDOKUMEN = "getviewlist/JnsDokumen/0";
  static const String TAG_LISTPARAM_CONFINS_PEKERJAAN = "getlistparam-confins/Pekerjaan/sKdCbg";
  static const String TAG_LISTPARAM_CONFINS_PENDIDIKANTERAKHIR = "getlistparam-confins/PendidikanTerakhir/sKdCbg";
  static const String TAG_VIEWLIST_STATUSPERNIKAHAN = "getviewlistWO/501/statuspernikahan/0";
  static const String TAG_VIEWLIST_STATUS_KEPEMILIKAN_RUMAH = "getviewList/StatusKepemilikanRumah/0";
  static const String TAG_VIEWLIST_JENIS_PEKERJAAN = "getviewjnspekerjaan";
  static const String TAG_VIEWLIST_PRODUK = "getTipeProduk.json";
  static const String TAG_VIEWLIST_SOURCE_OF_APPLICATION = "getviewlistsoa/0/SourceOfApplication/0/";
  static const String TAG_VIEWLIST_JAMINAN_BPKB = "getviewlist/JaminanBPKB/0";
  static const String TAG_VIEWLIST_ASSET = "getviewlistasset/0/";
  static const String TAG_VIEWLIST_TUJUAN_PEMBIAYAAN = "getlistparam-infomedia/tujuan_pembiayaan";
  static const String TAG_VIEWLIST_ADDRESS = "GetlistAdress/{a}/{b}/{c}";
  static const String TAG_VIEWLIST_MERKKENDARAAN = "getlistmerkkend/{tipeJaminan}";
  static const String TAG_VIEWLIST_TIPEKENDARAAN = "getlisttipekend/{id}";

  static const String TAG_CEK_PENGKINIAN_DATA = "cekPengkinianData.json";
  static const String TAG_PENGKINIAN_DATA = "pengkinianData.json";
  static const String TAG_WILAYAH_INDONESIA = "wilayahIndonesia.json";
  static const String TAG_KODEPOS_INDONESIA = "getKodepos.json";
  static const String TAG_JMO_PENDIDIKAN = "getlistparam-confins/PendidikanTerakhir/sKdCbg";
  static const String TAG_JMO_STATUS_NIKAH = "getviewlistWO/501/statuspernikahan/0";
  static const String TAG_JMO_JENIS_PEKERJAAN = "getviewjnspekerjaan";
  static const String TAG_JMO_KODEPOS = "GetlistAdress";

  static const String TAG_SEND_OTP = "sendSMS/";
  // static const String TAG_SEND_OTP                             = "sendSMS/{nomor_hp}/{pesan}";

  static const String TAG_ESIGN_PORTAL = "https://gdkwebserver.ad-ins.com/";

  static const String TAG_ESIGN_TENANT_CODE = "JMFI";
  static const String TAG_ESIGN_API_KEY = "SwfCQh";
  static const String TAG_ESIGN_CALLER_ID = "USER@AD-INS.COM";
  static const String TAG_ESIGN_CEK_REGISTRASI = "user/checkRegistration";
  static const String TAG_ESIGN_GENERATE_INVITATION = "user/generateInvLink";
  static const String TAG_ESIGN_REGISTER = "user/register";
  static const String TAG_ESIGN_UNSIGNED_DOC = "document/getTotalUnsignedDocuments";
  static const String TAG_ESIGN_SENT_OTP_SIGNING = "user/sentOtpSigning";
  static const String TAG_ESIGN_SIGN = "document/signDocument";
  static const String TAG_ESIGN_CHECK_STATUS_SIGN = "document/checkStatusSigning";
  static const String TAG_ESIGN_DOWNLOAD = "document/downloadDocument";
  static const String TAG_ESIGN_REQUEST_STAMPING = "document/requestStamping";
  static const String TAG_ESIGN_CHECK_STAMPING = "document/checkStampingStatus";

  static const String TAG_KLAIM_ASURANSI_JENIS_KLAIM = "getJenisKlaim.json";
  static const String TAG_KLAIM_ASURANSI_AGREEMENT_INSCO = "agreementInsco.json";
  static const String TAG_KLAIM_ASURANSI_CHECK_CLAIM_AVAILABLE = "CheckClaimAvailable";
  static const String TAG_KLAIM_ASURANSI_INSERT_FORM_AWAL = "insertFormAwal.json";
  static const String TAG_KLAIM_ASURANSI_INSERT_FORM_LANJUTAN = "insertFormLanjutan.json";
  static const String TAG_KLAIM_ASURANSI_RIWAYAT_FORM_AWAL = "getRiwayatFormAwal.json";
  static const String TAG_KLAIM_ASURANSI_RIWAYAT_FORM_LANJUTAN = "getRiwayatFormLanjutan.json";
  static const String TAG_KLAIM_ASURANSI_UPDATE_CHECKLIST_DOCUMENT = "updateChecklistDokumen.json";
  static const String TAG_KLAIM_ASURANSI_GET_DOC_CHECKLIST_ASURANSI = "getDocumentChecklistFromAsuransi.json";
  static const String TAG_KLAIM_ASURANSI_DOWNLOAD_SURAT_KEPUTUSAN = "downloadSuratKeputusan.json";
  static const String TAG_KLAIM_ASURANSI_DETAIL_FORM_LANJUTAN = "getDetailFormLanjutan.json";

  static const String TAG_MPMI_GET_TOKEN = "GetToken";
  static const String TAG_MPMI_SUBMIT_CLAIM_REGISTER = "SubmitClaimRegister";
  static const String TAG_MPMI_SUBMIT_CLAIM_DETAIL = "SubmitClaimDetail";
  static const String TAG_MPMI_SUBMIT_DOCUMENT_CHECKLIST = "SubmitDocumentChecklist";

  static const String TAG_ONESIGNAL_UPDATEID = "onesignal/update_id";
  static const String TAG_ONESIGNAL_GETNOTIF = "OneSignal_GetNotif";

  static const String TAG_ECONTRACT_SUBMIT_FORMPENGADUAN = "eContractSubmitFormPengaduan.json";
  static const String TAG_SUBMIT_LOG_DOWNLOAD = "submitLogDownload.json";
  static const String TAG_JUMLAH_DOWNLOAD = "GetJumlahDownload.json";
  static const String TAG_DOWNLOAD_ECONTRACT = "DownloadEContract.json";

  static List<Interceptor> dioInterceptors = [
    PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    )
  ];
}
