import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/NotifRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/onesignal/notif/state.dart';
import 'package:jmcare/service/OnesignalgetnotifService.dart';
import 'package:jmcare/service/PostReadNotifikasiService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';

import '../../../helper/Konstan.dart';

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

    Get.toNamed(Konstan.rute_detail_notif, arguments: itemNotif);
  }
}
