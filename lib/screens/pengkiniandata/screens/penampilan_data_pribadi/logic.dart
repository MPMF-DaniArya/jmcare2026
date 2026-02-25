import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/state.dart';

import '../../../../helper/Fungsi.dart';
import '../../../../model/session/RegisterpinModel.dart';
import '../../../pin/register/state.dart';

class PenampilanDataPribadiLogic extends BaseLogic {
  final PenampilanDataPribadiState state = PenampilanDataPribadiState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataPribadi();
  }

  void getDataPribadi() async {
    is_loading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    state.dummyData;
    is_loading.value = false;
  }

  void downloadDataPribadi() async {
    if (state.tecINPUT!.text.isEmpty) {
      Fungsi.errorToast("PIN harus diisi!");
      return;
    }
    if (state.tecINPUT!.text.length < 6) {
      Fungsi.errorToast("PIN minimal 6 angka");
      return;
    }
    final String savedPIN = await getPIN();
    if (savedPIN == state.tecINPUT!.text.toString()) {
      print('PIN cocok');
    } else {
      Fungsi.errorToast("PIN tidak cocok!");
    }
  }
}
