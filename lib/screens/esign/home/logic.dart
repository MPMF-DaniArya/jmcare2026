import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/CekRegistrasiesignRespon.dart';
import 'package:jmcare/model/api/EsignRequestStampRespon.dart';
import 'package:jmcare/model/api/EsignSentotpRespon.dart';
import 'package:jmcare/model/api/EsigncekstampRespon.dart';
import 'package:jmcare/model/api/EsigndownloadRespon.dart';
import 'package:jmcare/model/api/EsignsignRespon.dart';
import 'package:jmcare/model/api/EsignstatussignRespon.dart';
import 'package:jmcare/model/api/EsignunsignedRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/esign/home/state.dart';
import 'package:jmcare/service/CekRegistrasiesignService.dart';
import 'package:jmcare/service/EsignRequestStampService.dart';
import 'package:jmcare/service/EsignSentotpService.dart';
import 'package:jmcare/service/EsignUnsignedService.dart';
import 'package:jmcare/service/EsigncekstampService.dart';
import 'package:jmcare/service/EsigndownloadService.dart';
import 'package:jmcare/service/EsignsignService.dart';
import 'package:jmcare/service/EsignstatussignService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../../model/api/CekRegistrasiesignRequest.dart';

class EsignhomeLogic extends BaseLogic {
  final EsignhomeState state = EsignhomeState();
  final loadingUnsigned = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // sentOtp();
    // signDocument();
    // cekStatus();
    // downloadDoc();
    // requestStamp();
    // cekStamp();
    // unduhPDF();
  }

  // void unduhPDF() async {
  //   Directory? dir;
  //   dir = Directory('/storage/emulated/0/Download/'); // for android
  //   if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
  //   File fileImg;
  //   final base64 = "JVBERi0xLjcKMS";
  //   final decodedBytes = base64Decode(base64);
  //   // final directory = await getApplicationDocumentsDirectory();
  //   fileImg = File('${dir.path}/test.pdf');
  //   print(fileImg.path);
  //   fileImg.writeAsBytesSync(List.from(decodedBytes));
  // }

  void notAvailable() {
    Fungsi.errorToast("Menu ini masih belum tersedia");
  }

  // void cekStamp() async {
  //   final refnumber = "001";
  //   final respon = await getService<EsigncekstampService>()?.cekStamp(refnumber);
  //   if (respon is EsigncekstampError){
  //     Fungsi.errorToast("Error check stamp");
  //   }else{
  //     if (respon!.status!.code! == 0){
  //       final s = respon!.checkStampingStatus!.first;
  //       Fungsi.suksesToast("Berhasil request stamp " + s.documentId!);
  //     }else{
  //       Fungsi.errorToast(respon!.status!.message!);
  //     }
  //   }
  // }

  // void requestStamp() async {
  //   final refnumber = "001";
  //   final respon = await getService<EsignRequestStampService>()?.requestStamp(refnumber);
  //   if (respon is EsignRequestStampError){
  //     Fungsi.errorToast("Error request stamp");
  //   }else{
  //     if (respon!.status!.code! == 0){
  //       Fungsi.suksesToast("Berhasil request stamp");
  //     }else{
  //       Fungsi.errorToast(respon!.status!.message!);
  //     }
  //   }
  // }

  // void downloadDoc() async {
  //   final docid = "00155D0B-7502-A236-11EF-27B90B75B071";
  //   final respon = await getService<EsigndownloadService>()?.load(docid);
  //   if (respon is EsigndownloadError){
  //     Fungsi.errorToast("Error download");
  //   }else{
  //     if (respon!.status!.code! == 0){
  //       Fungsi.suksesToast(respon.pdfBase64!.substring(0,20));
  //     }else{
  //       Fungsi.errorToast(respon.status!.message!);
  //     }
  //   }
  // }

  //
  // void cekStatus() async {
  //   final refNumber = "002";
  //   final respon = await getService<EsignstatussignService>()?.checkStatus(refNumber);
  //   if (respon is EsignstatussignError){
  //     Fungsi.errorToast("Error check status");
  //   }else{
  //     if (respon!.status!.code! == 0){
  //       final pertama = respon.statusSigning!.first!;
  //       final dua = pertama.signer!.first!;
  //       Fungsi.suksesToast("Sign status pertama " + dua!.signStatus!.toString());
  //     }else{
  //       Fungsi.errorToast(respon.status!.message!);
  //     }
  //   }
  // }

  // void sentOtp() async {
  //   var user = await getStorage<LoginRespon>();
  //   final hp = user.data!.noHp;
  //   final email = user.data!.email;
  //   final refNumber = "001";
  //   final respon = await getService<EsignsentotpService>()?.getOTP(hp!, email!, refNumber);
  //   if (respon is EsignsentotpError){
  //     Fungsi.errorToast("Error sent otp");
  //   }else{
  //     if (respon!.status!.code == 0){
  //       Fungsi.suksesToast("Silakan cek OTP di nomor whatsapp Anda");
  //     }else{
  //       Fungsi.errorToast(respon.status!.message!);
  //     }
  //   }
  // }

  // void signDocument() async {
  //   final auth = await getStorage<LoginRespon>();
  //   final email = auth.data!.email;
  //   List<String> docs = List<String>.empty(growable: true);
  //   final docId = "00155D0B-7502-A236-11EF-27CD6A6A6031";
  //   docs.add(docId);
  //   final otp = "453506";
  //
  //   final respon = await getService<EsignsignService>()?.sign(docs, email!, "Password123!", otp);
  //   if (respon is EsignsignError){
  //     Fungsi.errorToast("Error!");
  //   }else{
  //     if (respon!.status!.code! == 0){
  //       Fungsi.suksesToast("Proses sign berhasil!");
  //     }else{
  //       Fungsi.errorToast(respon!.status!.message!);
  //     }
  //   }
  // }

  void cekRegistrasiEsign(BuildContext context) async {
    is_loading.value = true;
    final loginStorage = await getStorage<LoginRespon>();
    final String noKTP = loginStorage.data!.noKtp!;
    var audit = Audit(callerId: Endpoint.TAG_ESIGN_CALLER_ID);

    var body = CekRegistrasiesignRequest(
        audit: audit, dataType: "NIK", userData: noKTP);
    final cekRegistrasi = await getService<CekRegistrasiesignService>()
        ?.cekRegistrasi(noKTP);
    if (cekRegistrasi is CekregistrasiesignError || cekRegistrasi == null) {
      Fungsi.errorToast("Gagal cek registrasi Esign!");
    } else {
      if (cekRegistrasi!.status!.code! == 0) {
        dialogLoginEsign(context);
      } else {
        dialogRegisterEsign(context);
      }
    }
    is_loading.value = false;
  }

  Future<bool?> dialogRegisterEsign(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register eSignHub'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Anda belum terdaftar di eSignHub. Apakah Anda akan registrasi sekarang?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Get.back();
                // Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () async {
                Get.offNamed(Konstan.rute_esign_invitation);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> dialogLoginEsign(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login eSignHub'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Anda sudah terdaftar di eSignHub. Apakah Anda akan login ke eSignHub sekarang?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () async {
                Get.offNamed(Konstan.rute_esign,
                    arguments: {'detail': Endpoint.base_url_esign});
              },
            ),
          ],
        );
      },
    );
  }

  void loginEsignHub() {
    Get.toNamed(Konstan.rute_esign, arguments: {'detail': Endpoint.TAG_ESIGN_PORTAL});
  }

  void unsignedDocEsign() async {
    loadingUnsigned.value = true;
    final auth = await getStorage<LoginRespon>();
    final email = auth.data!.email;

    final respon =
        await getService<EsignunsignedService>()?.getUnsigned(email!);
    if (respon is EsignunsignedError) {
      Fungsi.errorToast("Tidak dapat memproses data!");
    } else {
      if (respon!.status!.code! == 0) {
        final total = respon.totalUnsignedDocuments!;
        if (total.toString() == "0") {
          Fungsi.suksesToast(
              "Anda tidak mempunyai dokumen yang harus ditanda tangani");
        } else {
          Fungsi.warningToast("Anda mempunyai $total dokumen yang harus ditanda tangani");
        }
      } else {
        if (respon.status!.message != null) {
          Fungsi.errorToast("${respon.status!.message!},  Anda belum terdaftar di eSignHub");
        }
      }
    }
    loadingUnsigned.value = false;
  }
}
