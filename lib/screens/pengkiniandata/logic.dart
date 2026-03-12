  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:jmcare/helper/Fungsi.dart';
  import 'package:jmcare/model/api/BaseRespon.dart';
  import 'package:jmcare/screens/base/base_logic.dart';
  import 'package:jmcare/screens/pengkiniandata/state.dart';
  import 'package:jmcare/service/CekSebelumHapusSpdService.dart';
  import 'package:jmcare/service/Service.dart';

  import '../../helper/Konstan.dart';
  import '../../model/api/LoginRespon.dart';
  import '../../storage/storage.dart';

  class PengkiniandataLogic extends BaseLogic {
    final PengkiniandataState state = PengkiniandataState();

    void cekSebelumHapusSdp() async {
      is_loading.value = true;
      await Future.delayed(const Duration(milliseconds: 1200));
      try {
        final auth = await getStorage<LoginRespon>();
        final response = await getService<CekSebelumHapusSpdService>()!
            .cekSebelumHapusSdp(idUser: int.tryParse(auth.data!.loginUserId!)!);

        if (response != null) {
          if (response is BaseError) {
            Fungsi.errorToast('Terjadi masalah. Silahkan coba lagi nanti!');
          } else {
            if (response.code == Konstan.tag_100) {
              Get.defaultDialog(
                title: "Pemberitahuan",
                titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                contentPadding: const EdgeInsets.all(20),
                content: Column(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: Colors.orange,
                      size: 70,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Penghapusan Data Ditolak',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mohon maaf, Anda tidak dapat menghapus data pribadi karena masih memiliki kontrak aktif di JACCS MPM Finance Indonesia. Penghapusan data hanya dapat dilakukan setelah seluruh kewajiban kontrak terpenuhi.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                confirm: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Mengerti',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            } else {
              Get.toNamed(Konstan.rute_request_penghapusan_data_pribadi);
            }
          }
        }
      } catch (e) {
        Fungsi.errorToast("Terjadi kesalahan sistem.");
      } finally {
        is_loading.value = false;
      }
    }
  }
