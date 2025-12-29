import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/NotifRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/onesignal/notif/state.dart';
import 'package:jmcare/service/OnesignalgetnotifService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';

class OnesignalnotifLogic extends BaseLogic {

  final OnesignalnotifState state = OnesignalnotifState();
  var obsNotifRespon = NotifRespon().obs;
  var obsRowCount = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getNotif();
  }

  void getNotif() async {
    is_loading.value = true;
    final auth = await getStorage<LoginRespon>();
    final login_user_id = auth.data!.loginUserId;
    final respon = await getService<OnesignalgetnotifService>()?.getNotif(login_user_id!);
    if (respon == null){
      obsRowCount.value = 0;
      Fungsi.koneksiError();
    }else{
      if (respon is NotifError){
        obsRowCount.value = 0;
        Fungsi.errorToast("Gagal memproses notifikasi");
      }else{
        obsNotifRespon.value = respon;
        obsRowCount.value = respon.data!.length;
      }
    }
    is_loading.value = false;
  }
}
