
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/base/base_register_logic.dart';
import 'package:jmcare/screens/register/debitur/state.dart';
import 'package:jmcare/service/RegisterDebiturService.dart';
import '../../../service/Service.dart';

//di-extend dari BaseRegisterLogic
class RegisterDebiturLogic extends BaseRegisterLogic{

  final RegisterDebiturState state = RegisterDebiturState();

  @override
  void onInit() {
    super.onInit();
  }

  void back(){
    Get.back();
  }

  void doRegisterDebitur(BuildContext context) async {

    if (state.formKey!.currentState!.validate()){
      //cek apakah password dan confirm-nya sama
      if (state.passwordController!.text.toString() != state.ulangipasswordController!.text.toString()){
        Fungsi.warningToast("Password harus sama dengan pengulangannya");
        return;
      }
      //cek apakah email diisi dan valid
      if (state.emailController!.text.toString().isNotEmpty && !state.emailController!.text.toString().isEmail){
        Fungsi.warningToast("Email tidak valid");
        return;
      }
      //cek kalkulator password
      var isStrongPassword = Fungsi.passwordCalculator(state.passwordController!.text.toString());
      if (!isStrongPassword){
        Fungsi.warningToast(Konstan.tag_kekuatan_password);
        return;
      }

      is_loading.value = true;
      BaseRespon? baseRespon = await getService<RegisterDebiturService>()!.doRegister(
          state.ktpController!.text.toString(),
          state.hpController!.text.toString(),
          state.emailController!.text.toString(),
          state.passwordController!.text.toString(),
      );
      is_loading.value = false;

      if (baseRespon == null){
        Fungsi.koneksiError();
      }else{
        if (baseRespon is BaseError || baseRespon?.code == Konstan.tag_100){
          Fungsi.errorToast(baseRespon!.message!);
        }else if (baseRespon?.code == Konstan.tag_200){
          Fungsi.suksesToast("Register berhasil, silakan login");
          Get.offAllNamed(Konstan.rute_login);
        }
      }

    }
  }

}
