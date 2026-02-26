import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/state.dart';
import 'package:jmcare/service/GetDetailSdpService.dart';
import 'package:jmcare/service/Service.dart';

import '../../../../model/api/LoginRespon.dart';
import '../../../../storage/storage.dart';

class PenampilanDataPribadiLogic extends BaseLogic {
  final PenampilanDataPribadiState state = PenampilanDataPribadiState();

  @override
  void onInit() {
    super.onInit();
    getDataPribadi();
  }

  void getDataPribadi() async {
    is_loading.value = true;
    try {
      final auth = await getStorage<LoginRespon>();
      final dataSdpRespon = await getService<GetDetailSdpService>()!
          .getDetailSdp(login_user_id: int.tryParse(auth.data!.loginUserId!)!);

      if (dataSdpRespon != null) {
        state.namaLengkapUser = dataSdpRespon.namaLengkap ?? '-';
        state.nomorIdUser = dataSdpRespon.nomorId ?? '-';
        state.tempatTanggalLahirUser =
            "${dataSdpRespon.tempatLahir ?? '-'}, ${dataSdpRespon.tanggalLahir ?? '-'}";
        // state.alamatSesuaiIdUser = dataSdpRespon.alamatSesuaiId ?? '-';
        state.alamatDomisiliUser = dataSdpRespon.alamatDomisili ?? '-';
        state.nomorTeleponUser = dataSdpRespon.noTelepon ?? '-';
        // state.nomorKontrakUser = dataSdpRespon.nomorKontrak ?? '-'; // Tambahkan nomor kontrak jika ada di API
        
        update(); // PENTING: Memanggil update agar GetBuilder di UI merespon perubahan data
      }
    } catch (e) {
      print("Error getDataPribadi: $e");
      Fungsi.koneksiError();
    } finally {
      is_loading.value = false;
    }
  }
}
