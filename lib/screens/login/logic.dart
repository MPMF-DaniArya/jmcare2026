import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/login/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jmcare/service/OnesignalUpdateIdService.dart';
import '../../model/api/LoginRespon.dart';
import '../../service/LoginService.dart';
import '../../service/Service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LoginLogic extends BaseLogic{

  var show_password = true.obs;
  final LoginState state = LoginState();

  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid){
      cekVersi();
    }
  }

  void showHidePassword(){
    if (show_password.value){
      show_password.value = false;
    }else{
      show_password.value = true;
    }
  }

  void doLogin(BuildContext context) async {
    if (state.formKey!.currentState!.validate()){
      is_loading.value = true;
      LoginRespon? loginRespon = await getService<LoginService>()!.doLogin(
          state.usernameController!.text.toString(),
          state.passwordController!.text.toString()
      );
      is_loading.value = false;

      if (loginRespon != null){
        if (loginRespon is LoginError || loginRespon.code == Konstan.tag_100){
          Fungsi.errorToast("Login gagal! Email/password salah, atau akun sudah dihapus!");
        }else if (loginRespon.code == Konstan.tag_200){
          OneSignal.Notifications.requestPermission(true);

          final osid = await OneSignal.User.getOnesignalId();
          await OneSignal.login(loginRespon.loginUserId!);
          await OneSignal.User.addAlias(Konstan.tag_onesignal_alias, loginRespon.noKtp ?? "");
          String? grade = loginRespon.grade!.toUpperCase() ?? "";
          await OneSignal.User.addTagWithKey(Konstan.tag_onesignal_alias, grade);
          await OneSignal.User.addEmail(loginRespon.email ?? "");
          await OneSignal.User.addSms(loginRespon.noHp ?? "");

          // print("os id ${osid!}");
          baseSaveStorage<LoginRespon>(loginRespon);

          //update onesignal id di tabel UserAcc jmcare
          final brespon = await getService<OnesignalUpdateIdService>()?.updateID(loginRespon.loginUserId!, osid ?? "");
          if (brespon == null){
            Fungsi.koneksiError();
          }else{
            if (brespon is BaseError){
              Fungsi.errorToast("Gagal update osid");
            }else{
              // Fungsi.suksesToast("Sukses update osid");
            }
          }
          Get.offAllNamed(Konstan.rute_register_pin);
        }
      }else{
        Fungsi.koneksiError();
      }
    }
  }

  void gotoHome(){
    Get.offAllNamed(Konstan.rute_home);
  }

  void pilihRegister(){
    Get.toNamed(Konstan.rute_pilih_register);
  }

  void resetPassword(){
    Get.toNamed(Konstan.rute_cek_nomor_hp);
  }

}
