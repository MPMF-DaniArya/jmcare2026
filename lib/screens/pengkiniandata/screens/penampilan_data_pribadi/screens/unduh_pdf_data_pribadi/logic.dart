import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/screens/unduh_pdf_data_pribadi/state.dart';

import '../../../../../../helper/Fungsi.dart';

class UnduhPdfDataPribadiLogic extends BaseLogic {
  final UnduhPdfDataPribadiState state = UnduhPdfDataPribadiState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    state.tecINPUT.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    state.tecINPUT.dispose();
    super.onClose();
  }

  void downloadDataPribadi() async {
    final inputPin = state.tecINPUT.text;

    if (inputPin.isEmpty) {
      Fungsi.errorToast("PIN harus diisi!");
      return;
    }
    if (inputPin.length < 6) {
      Fungsi.errorToast("PIN minimal 6 angka");
      return;
    }
    is_loading.value = true;

    try {
      final String savedPIN = await getPIN();

      if (savedPIN == inputPin) {
        Fungsi.suksesToast('Pin cocok, sukses mengunduh data...');
      } else {
        Fungsi.errorToast("PIN tidak cocok!");
        state.tecINPUT.clear();
      }
    } catch (e) {
      Fungsi.errorToast('Terjadi kesalahan sistem');
    } finally {
      is_loading.value = false;
    }
  }
}
