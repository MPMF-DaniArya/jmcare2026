import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/NotifRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/onesignal/notif/state.dart';
import 'package:jmcare/service/OnesignalgetnotifService.dart';
import 'package:jmcare/service/PostReadNotifikasiService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';

import '../../../helper/Konstan.dart';
import '../../../service/CekkuisionerService.dart';

class OnesignalnotifLogic extends BaseLogic {
  final OnesignalnotifState state = OnesignalnotifState();
  var obsNotifRespon = NotifRespon().obs;
  var obsRowCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getNotif();
  }

  void getNotif() async {
    is_loading.value = true;
    final auth = await getStorage<LoginRespon>();
    final login_user_id = auth.data!.loginUserId;
    final respon =
        await getService<OnesignalgetnotifService>()?.getNotif(login_user_id!);
    if (respon == null) {
      obsRowCount.value = 0;
      Fungsi.koneksiError();
    } else {
      if (respon is NotifError) {
        obsRowCount.value = 0;
        Fungsi.errorToast("Gagal memproses notifikasi");
      } else {
        obsNotifRespon.value = respon;
        obsRowCount.value = respon.data!.length;
      }
    }
    is_loading.value = false;
  }

  void isReadNotifikasi(String idNotifikasi, Data itemNotif) async {
    // menandai notif telah dibaca di lokal tanpa refresh atau update status di api lalu get lagi data isread yang baru
    if (itemNotif.isRead == '0') {
      int index = obsNotifRespon.value.data!.indexOf(itemNotif);
      if (index != -1) {
        obsNotifRespon.value.data![index].isRead = '1';

        obsNotifRespon.refresh();
      }

      getService<PostReadNotifikasiService>()!
          .isReadNotifikasi(idNotifikasi: idNotifikasi)
          .catchError(
            (e) => debugPrint('Error Update isRead di server: $e'),
          );
    }

    // cek apakah notif kuisioner
    if (itemNotif.namaNotif!.toUpperCase() == 'KUISIONER') {
      try {
        final authStorage = await getStorage<LoginRespon>();
        final userID = authStorage.data!.loginUserId;

        final baseRespon = await getService<CekkuisionerService>()
            ?.cekKuisioner(userID!, itemNotif.onesignalId!);

        if (baseRespon != null && baseRespon.code == "200") {
          Fungsi.warningToast(baseRespon.message!);
        } else {
          Get.toNamed(Konstan.rute_kuisioner, arguments: {
            Konstan.tag_id_antrian: itemNotif.onesignalId,
            'isFromNotif': true
          });
        }
      } catch (e) {
        Get.back();
        Fungsi.errorToast("Gagal mengecek status kuisioner");
      }
      return;
    }

    // ke detail notif jika bukan kuisioner
    Get.toNamed(Konstan.rute_detail_notif, arguments: itemNotif);
  }
}
