import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/riwayat_status_pengajuan/state.dart';
import 'package:get/get.dart';

class RiwayatStatusPengajuanLogic extends BaseLogic {
  final RiwayatStatusPengajuanState state = RiwayatStatusPengajuanState();
  var selectedCategory = 'Semua'.obs;

  List<HistoryModel> get filterredHistory {
    if (selectedCategory.value == 'Semua') {
      return state.historyList;
    }
    return state.historyList
        .where((item) => item.status == selectedCategory.value)
        .toList();
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }
}
