import 'package:flutter/material.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/state.dart';
import 'package:jmcare/service/GetDetailSdpService.dart';
import 'package:jmcare/service/Service.dart';

import '../../../../model/api/LoginRespon.dart';
import '../../../../model/api/SubjekDataPribadiRespon.dart';
import '../../../../storage/storage.dart';

class PenampilanDataPribadiLogic extends BaseLogic {
  final PenampilanDataPribadiState state = PenampilanDataPribadiState();

  @override
  void onInit() {
    super.onInit();
    getDataPribadi();
  }

  // fungsi untuk mengambil data pribadi user
  void getDataPribadi() async {
    is_loading.value = true;
    try {
      final auth = await getStorage<LoginRespon>();
      final dataSdpRespon = await getService<GetDetailSdpService>()!
          .getDetailSdp(login_user_id: int.tryParse(auth.data!.loginUserId!)!);


      if (dataSdpRespon != null) {
        if (dataSdpRespon is SubjekDataPribadiError) {
          Fungsi.errorToast(
              "Terjadi masalah. Tidak dapat menampilkan data pribadi!");
        } else {
          baseSaveStorage<SubjekDataPribadiRespon>(dataSdpRespon);

          String rawAlamatIdUser =
              '${dataSdpRespon.alamatLegalAlamat}, RT ${dataSdpRespon.alamatLegalRt}/ RW ${dataSdpRespon.alamatLegalRw}, Kel. ${dataSdpRespon.alamatLegalKelurahan}, Kec. ${dataSdpRespon.alamatLegalKecamatan}, ${dataSdpRespon.alamatLegalKota}, ${dataSdpRespon.alamatLegalKodepos}';
          String rawTempatTanggalLahir =
              "${dataSdpRespon.tempatLahir}, ${dataSdpRespon.tanggalLahir}";
          String? rawAlamatDomisili = dataSdpRespon.alamatDomisili;

          state.namaLengkapUser =
              Fungsi.formatTitleCase(dataSdpRespon.namaLengkap);
          state.nomorIdUser = Fungsi.formatTitleCase(dataSdpRespon.nomorId);
          state.tempatTanggalLahirUser =
              Fungsi.formatTitleCase(rawTempatTanggalLahir);
          state.alamatDomisiliUser = Fungsi.formatTitleCase(rawAlamatDomisili);
          state.nomorTeleponUser =
              Fungsi.formatTitleCase(dataSdpRespon.noTelepon);
          state.alamatSesuaiIdUser = Fungsi.formatTitleCase(rawAlamatIdUser);
          state.nomorKontrakUser =
              Fungsi.formatTitleCase(dataSdpRespon.noKontrak);
          update();
        }
      }
    } catch (e) {
      Fungsi.koneksiError();
    } finally {
      is_loading.value = false;
    }
  }
}
