import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/GetRiwayatPpdRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/riwayat_status_pengajuan/state.dart';
import 'package:jmcare/service/GetRiyawatPdpService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';

class RiwayatStatusPengajuanLogic extends BaseLogic {
  final RiwayatStatusPengajuanState state = RiwayatStatusPengajuanState();
  var selectedCategory = 'Semua'.obs;

  var listRiwayat = <GetRiwayatPpdRespon>[].obs;

  @override
  onInit() {
    super.onInit();
    getHistoryPengkinian();
  }

  void getHistoryPengkinian() async {
    is_loading.value = true;

    try {
      final auth = await getStorage<LoginRespon>();

      String statusFilter = selectedCategory.value == 'Semua'
          ? ''
          : selectedCategory.value.toUpperCase();

      final dynamic response = await getService<GetRiyawatPdpService>()!
          .getRiwayatPdp(
              userId: int.tryParse(auth.data!.loginUserId!)!,
              status: statusFilter);

      if (response != null && response is List) {
        listRiwayat.value = response
            .map(
              (e) => GetRiwayatPpdRespon.fromJson(e),
            )
            .toList();
      } else if (response is GetRiwayatPdpError) {
        Fungsi.errorToast('Gagal Memuat Riwayat. Silahkan coba lagi nanti!');
      }
    } catch (e) {
      Fungsi.koneksiError();
    } finally {
      is_loading.value = false;
    }
  }

  List<GetRiwayatPpdRespon> get filterredHistory {
    if (selectedCategory.value == 'Semua') {
      return listRiwayat;
    }
    return listRiwayat
        .where((item) =>
            item.status!.toUpperCase() == selectedCategory.value.toUpperCase())
        .toList();
  }

  void changeCategory(String category) {
    selectedCategory.value = category;

    getHistoryPengkinian();
  }
}
