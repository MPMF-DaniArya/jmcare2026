import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/session/RegisterpinModel.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pin/register/state.dart';

class RegisterpinLogic extends BaseLogic {
  final RegisterpinState state = RegisterpinState();

  @override
  void onClose() {
    // TODO: implement onClose
    state.tecPin1!.dispose();
    state.tecPin2!.dispose();
    state.focusNodePin2.dispose();
    super.onClose();
  }

  void savePIN() async {
    if (state.tecPin1!.text.isEmpty || state.tecPin2!.text.isEmpty) {
      Fungsi.errorToast("Mohon lengkapi kedua kolom PIN Anda.");
      return;
    }
    if (state.tecPin1!.text.toString() != state.tecPin2!.text.toString()) {
      Fungsi.errorToast("Konfirmasi PIN tidak sesuai. Silakan cek kembali.");
      return;
    }
    if (state.tecPin1!.text.length < 6 || state.tecPin2!.text.length < 6) {
      Fungsi.errorToast("PIN harus terdiri dari 6 digit angka.");
      return;
    }
    //simpan pin di session
    var registerpinModel = RegisterpinModel(
        sudahRegister: true, pin: state.tecPin1!.text.toString());
    baseSaveStorage(registerpinModel);
    Fungsi.suksesToast("PIN Anda berhasil didaftarkan!");
    Get.offAllNamed(Konstan.rute_home);
  }
}
