import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/state.dart';

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
}
