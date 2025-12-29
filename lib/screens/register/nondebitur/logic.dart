
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/screens/base/base_register_logic.dart';
import 'package:jmcare/screens/register/nondebitur/state.dart';
import 'package:jmcare/service/RegisterNonDebiturService.dart';
import '../../../service/Service.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class RegisterNonDebiturLogic extends BaseRegisterLogic{

  final RegisterNonDebiturState state = RegisterNonDebiturState();

  @override
  void onInit() {
    super.onInit();
    state.jeniskelaminController!.text = "1";
  }

  void back(){
    Get.back();
  }

  void tapTanggalLahir(BuildContext context){
    DatePicker.showDatePicker(context,
      showTitleActions: true,
      onChanged: (date){
          setTanggalLahir(date);
      },
      onConfirm: (date){
          setTanggalLahir(date);
      },
      currentTime: DateTime.now(), locale: LocaleType.en
    );
  }

  void setTanggalLahir(DateTime date){
    state.tgllahirController!.text = "${date.year}-${date.month}-${date.day}";
  }

  void setValue_DDJenisKelamin(dynamic newValue){
    String nv = newValue.toString();
    print('nv ' + nv);
    state.jeniskelaminController!.text = nv;
  }

  void doRegisterNonDebitur(BuildContext context) async {

    if (state.formKey!.currentState!.validate()){
      //cek apakah nama mengandung angka
      if (
            state.namaController!.text.contains("0") || state.namaController!.text.contains("1") ||
            state.namaController!.text.contains("2") || state.namaController!.text.contains("3") ||
            state.namaController!.text.contains("3") || state.namaController!.text.contains("4") ||
            state.namaController!.text.contains("5") || state.namaController!.text.contains("6") ||
            state.namaController!.text.contains("7") || state.namaController!.text.contains("8") ||
            state.namaController!.text.contains("9") || state.namaController!.text.contains("0")
      ){
        Fungsi.warningToast("Nama tidak boleh mengandung angka");
        return;
      }
      //cek apakah password dan confirm-nya sama
      if (state.passwordController!.text.toString() != state.ulangipasswordController!.text.toString()){
        Fungsi.warningToast("Password harus sama dengan pengulangannya");
        return;
      }
      //cek apakah email diisi dan validasinya
      if (state.emailController!.text.toString().isNotEmpty && !state.emailController!.text.toString().isEmail){
        Get.snackbar(Konstan.tag_error, "Email tidak valid");
        return;
      }
      //cek kekuatan password
      var isStrongPassword = Fungsi.passwordCalculator(state.passwordController!.text.toString());
      if (!isStrongPassword){
        Fungsi.errorToast(Konstan.tag_kekuatan_password);
        return;
      }

      is_loading.value = true;
      BaseRespon? baseRespon = await getService<RegisterNonDebiturService>()!.doRegister(
          state.namaController!.text.toString(),
          state.alamatController!.text.toString(),
          state.hpController!.text.toString(),
          state.emailController!.text.toString(),
          state.passwordController!.text.toString(),
          state.pekerjaanController!.text.toString(),
          state.ktpController!.text.toString(),
          state.tempatController!.text.toString(),
          state.tgllahirController!.text.toString(),
          state.jeniskelaminController!.text.toString()
      );
      is_loading.value = false;

      if (baseRespon == null){
        Fungsi.koneksiError();
      }else{
        if (baseRespon is BaseError || baseRespon?.code == "0") {
          Fungsi.errorToast("Registrasi gagal!");
          debugPrint('Register gagal!');
        } else {
          if (baseRespon!.message ==
              "Email, nomor HP atau nomor KTP ini sudah ada") {
            Fungsi.warningToast(
                "Email, nomor HP atau nomor KTP ini sudah ada. Silakan langsung login");
          } else {
            Fungsi.suksesToast("Registrasi berhasil");
            Get.offAllNamed(Konstan.rute_login);
          }
        }
      }

    }
  }

}
