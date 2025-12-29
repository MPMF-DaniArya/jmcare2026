import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/gantipassword/state.dart';
import 'package:jmcare/service/GantipasswordService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';

class GantipasswordLogic extends BaseLogic {

  final GantipasswordState state = GantipasswordState();
  var obsVis0 = false.obs;
  var obsVis1 = false.obs;
  var obsVis2 = false.obs;


  @override
  void onInit() {
    super.onInit();
  }

  void handleVis(int index){
    switch (index) {
      case 0:
        obsVis0.value = !obsVis0.value;
        break;
      case 1:
        obsVis1.value = !obsVis1.value;
        break;
      case 2:
        obsVis2.value = !obsVis2.value;
        break;
    }
  }
  //
  submit() async {
    if (state.formKey.currentState!.validate()){
      if (state.tecUlangpassword.text != state.tecNewpassword.text){
        Fungsi.warningToast("Password baru harus sama dengan pengulangannya");
        return;
      }
      final isStrongPassword = Fungsi.passwordCalculator(state.tecNewpassword.text.toString());
      if (!isStrongPassword){
        Fungsi.warningToast("Kata sandi harus terdiri dari 6-20 karakter dengan setidaknya satu angka, satu karakter huruf besar, dan satu karakter khusus");
        return;
      }
      is_loading.value = true;
      final user = await getStorage<LoginRespon>();
      final login_user_id = user.data!.loginUserId;

      final hasil = await getService<GantipasswordService>()!.gantiPassword(int.parse(login_user_id!), state.tecOldpassword.text, state.tecNewpassword.text);
      if (hasil == null){
        Fungsi.koneksiError();
      }else{
        if (hasil.code == Konstan.tag_200){
          Get.offAllNamed(Konstan.rute_home);
          Fungsi.suksesToast(hasil.message ?? "Password berhasil diubah");
        }else{
          Fungsi.errorToast(hasil.message ?? "Gagal mengubah password!");
        }
      }
      is_loading.value = false;
    }
    
  }
}