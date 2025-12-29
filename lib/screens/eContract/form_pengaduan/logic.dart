import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/eContract/form_pengaduan/state.dart';
import 'package:jmcare/service/EContractsubmitformpengaduanService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';

class FormpengaduanEContractLogic extends BaseLogic {

  final FormpengaduanEContractState state = FormpengaduanEContractState();

  @override
  void onInit() async {
    super.onInit();

    await getLemparan();

  }

  getLemparan() async {
    final user = await getStorage<LoginRespon>();
    state.tecNamaLengkap.text = user.data!.namaUser ?? Konstan.tag_strip;
    state.lemparan = Get.arguments[Konstan.tag_detail] ?? Konstan.tag_strip;
    state.tecAgreementNo.text = state.lemparan;
    state.login_user_id = int.parse(user.data!.loginUserId! ?? "0");
    state.nomor_hp = user.data!.noHp ?? Konstan.tag_strip;
    state.email = user.data!.email ?? Konstan.tag_strip;

    state.tecNomorHP.text = state.nomor_hp;
    state.tecEmail.text = state.email;
  }

  submit() async {
    if (state.formKey.currentState!.validate()){
      //submit form pengaduan
      is_loading.value = true;
      final hasil = await getService<EContractsubmitformpengaduanService>()!.submitFormPengaduan(
          state.login_user_id, state.tecNamaLengkap.text,
          state.tecNomorHP.text, state.tecAgreementNo.text,
          state.tecEmail.text, state.tecPesan.text
      );

      if (hasil == null){
        Fungsi.koneksiError();
      }else{
        if (hasil.code == Konstan.tag_100){
          Fungsi.warningToast(hasil.message!);
        }else{
          Get.offAllNamed(Konstan.rute_home);
          Fungsi.suksesToast(hasil.message ?? "Data berhasil disubmit");
        }
      }

      is_loading.value = false;
    }
  }
}