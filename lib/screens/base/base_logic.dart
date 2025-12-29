import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/EsignSentotpRespon.dart';
import 'package:jmcare/model/api/GradeRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/MpmiSubmitClaimDetail.dart';
import 'package:jmcare/model/api/MpmiSubmitClaimRegister.dart';
import 'package:jmcare/model/api/MpmiSubmitDocumentChecklist.dart';
import 'package:jmcare/model/api/PaginationuserRespon.dart';
import 'package:jmcare/model/session/RegisterpinModel.dart';
import 'package:jmcare/model/session/ResetPassModel.dart';
import 'package:jmcare/model/session/SelectedMethod.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/klaimasuransi/MpmiClaimDetailService.dart';
import 'package:jmcare/service/klaimasuransi/MpmiClaimRegisterService.dart';
import 'package:jmcare/service/klaimasuransi/MpmiDocumentChecklistService.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/Komponen.dart';
import '../../model/api/MpmiBaseRespon.dart';
import '../../model/api/SlideshowRespon.dart';
import '../../model/api/VersiModel.dart';
import '../../model/api/VersiRespon.dart';
import '../../service/VersiService.dart';
import '../../service/klaimasuransi/MpmiTokenService.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class BaseLogic extends GetxController {
  var is_loading = false.obs;
  final fungsi = Fungsi();
  var obsLoadVersi = false.obs;
  var obsVersiSalah = false.obs;
  var obsAppleVisibility = false.obs;

  void back(){
    Get.back();
  }

  void askPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.notification,
      Permission.scheduleExactAlarm
    ].request();
  }

  Future<bool> sudahRegisterPIN() async {
    final registerPINStorage = await getStorage<RegisterpinModel>();
    if (registerPINStorage.data == null) {
      return false;
    } else {
      if (registerPINStorage.data!.sudahRegister == false) {
        return false;
      } else {
        return true;
      }
    }
  }

  Future<String> getPIN() async {
    final registerPINstorage = await getStorage<RegisterpinModel>();
    if (registerPINstorage.data == null) {
      return "";
    } else {
      final String pin = registerPINstorage.data!.pin!;
      return pin;
    }
  }

  Future<bool> sudahLogin() async {
    final storageAuth = await getStorage<LoginRespon>();
    if (storageAuth.data?.loginUserId != null) {
      return true;
    } else {
      return false;
    }
  }

  void baseSaveStorage<T>(T? model) async {
    final storage = (await getStorage<T>());
    storage.setData(model);
    storage.save();
  }

  void doLogout(BuildContext context) async {
    await dialogLogout(context);
  }

  void clearSP() async {
    //kalau mau logout, loginrespon dikasih codenya = 0 ya...
    //soalnya fungsi clear sharedpref-nya ga jalan
    LoginRespon lr = LoginRespon(code: "0");
    baseSaveStorage<LoginRespon>(lr);
    ResetPassModel rpm = ResetPassModel();
    baseSaveStorage<ResetPassModel>(rpm);
    SelectedMethod sm = SelectedMethod();
    baseSaveStorage<SelectedMethod>(sm);
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear();
    OneSignal.logout();
    OneSignal.User.removeAlias(Konstan.tag_onesignal_alias);
  }

  Future<bool?> dialogLogout(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin akan logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
              child: const Text('TIDAK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            ElevatedButton(
              child: const Text('YA'),
              onPressed: () async {
                clearSP();
                Get.offNamedUntil(Konstan.rute_splash, (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> dialogSwitchAccount(
      BuildContext context, PaginationuserRespon respon, int index) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ganti akun'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin akan logout dan ganti akun?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () async {
                //clear session
                clearSP();
                //buat class LoginRespon dari pagination class
                LoginRespon lr = LoginRespon(
                    code: "200",
                    message: "Ganti akun",
                    status: "",
                    email: respon.data?[index].email,
                    grade: respon.data?[index].grade,
                    isAdmin: "0",
                    jenisKelamin: respon.data?[index].jenisKelamin,
                    jenisdebitur: respon.data?[index].jenisDebitur,
                    loginUserId: respon.data?[index].loginUserId,
                    namaUser: respon.data?[index].namaUser,
                    noHp: "",
                    tempatLahir: respon.data?[index].tempatLahir,
                    tglLahir: respon.data?[index].tglLahir,
                    noKk: respon.data?[index].noKtp,
                    noKtp: respon.data?[index].noKtp);
                //simpan loginrespon tadi di session
                baseSaveStorage<LoginRespon>(lr);
                //restart aplikasi ke splash screen
                Get.offNamedUntil(Konstan.rute_splash, (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> konversi(SlideshowRespon slideshowRespon) {
    List<Widget> hasil = List<Widget>.empty(growable: true);
    slideshowRespon.data?.forEach((e) {
      hasil.add(Komponen.slideBox(e.imgUrl!));
    });
    return hasil;
  }

  void setGradePoint(String gambar, int point) async {
    var gradeStorage = await getStorage<GradeRespon>();
    if (gradeStorage == null) {
      debugPrint('tidak ada di storage');
      point = 0;
      gambar = '';
    } else {
      var first = gradeStorage.data!.data!.first;
      point = first.point!.toString().isEmpty ? 0 : first.point!;
      String jenisMember = first.grade!;

      if (jenisMember.toLowerCase() == Konstan.tag_gold) {
        gambar = "assets/images/gold.png";
      } else if (jenisMember.toLowerCase() == Konstan.tag_bronze) {
        gambar = "assets/images/bronze.png";
      } else if (jenisMember.toLowerCase() == Konstan.tag_silver) {
        gambar = "assets/images/platinum.png";
      } else if (jenisMember.toLowerCase() == Konstan.tag_platinum) {
        gambar = "assets/images/platinum.png";
      } else {
        gambar = "";
      }
    }
  }

  Future<String> fetchTokenMpmi() async {
    final respon = await getService<MpmitokenService>()?.getToken();
    if (respon is MpmibaseError || respon == null){
      print("token error");
      return "";
    }else{
      print("token sukses");
      print(respon!.token!);
      //simpan token di session
      baseSaveStorage(respon);
      return respon.token!.toString();
    }
  }

  Future<String> getTokenMpmi() async {
    final token = await getStorage<MpmiBaseRespon>();
    if (token.data == null || token == null){
      return await fetchTokenMpmi();
    }else{
      return token.data!.token!;
    }
  }

  void thousandSeparator(TextEditingController tec){
    int a = int.parse(tec.text);
    final NumberFormat formatter = NumberFormat("##,##0");
    final b = formatter.format(a);
    tec.text = b;
  }

  Future<VersiModel> getVersiDevice() async{
    final info = await PackageInfo.fromPlatform();
    VersiModel versiModel = VersiModel();
    versiModel.appName = info.appName;
    versiModel.appVersion = info.version;
    versiModel.buildNumber = info.buildNumber.toString();
    versiModel.buildSignature = info.buildSignature.toString();
    versiModel.packageName = info.packageName;
    versiModel.installerStore = info.installerStore;

    print("app version " + versiModel.appVersion!);
    print("build number " + versiModel.buildNumber!);
    return versiModel;
  }

  void alertUpgradeAplikasi(String linkDownload){
    Get.defaultDialog(
      title: "Upgrade Aplikasi",
      content: Column(
        children: [
          const Text("Silakan uninstal aplikasi ini dan download aplikasi terbaru", textAlign: TextAlign.center,),
          ElevatedButton(onPressed: (){
            Get.back();
          }, child: const Text("OK"))
        ],
      ),
    );
  }

  void cekVersi() async {
    obsLoadVersi.value = true;
    var versiRespon = await getService<VersiService>()?.getVersion();
    if (versiRespon == null){
      Fungsi.errorToast("Gagal mendapatkan versi aplikasi");
    }else{
      if (versiRespon is VersiError) {
        debugPrint('versi error!');
      } else {
        var v = versiRespon.data!.first;
        debugPrint(v.versionCode);

        int sCode = int.parse(v.versionCode!); //kode dari api
        int sName = int.parse(v.versionName!); //name dari api
        String download_link = v.downloadLink ?? "";
        final versiDevice = await getVersiDevice();

        int iCode = int.parse(versiDevice.buildNumber!.replaceAll(".", ""));
        int iName = int.parse(versiDevice.appVersion!.replaceAll(".", ""));

        debugPrint("sCode $sCode");
        debugPrint("iCode $iCode");
        debugPrint("sName $sName");
        debugPrint("iName $iName");

        if (iName < sName) {
          alertUpgradeAplikasi(download_link);
          obsVersiSalah.value = true;
        }
      }
    }
    obsLoadVersi.value = false;
  }

  Uint8List dataFromBase64String(String base64String) {
    try{
      return base64Decode(base64String.replaceAll(RegExp(r'\s+'),''));
    }catch(e){
      return Uint8List(0);
    }
  }


}
