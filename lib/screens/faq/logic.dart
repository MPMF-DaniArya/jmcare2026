import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/FaqRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/faq/state.dart';
import 'package:jmcare/service/FaqService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:jmcare/storage/storage.dart';

class FaqLogic extends BaseLogic {

  final FaqState state = FaqState();
  var jmlRow = 0.obs;
  var obsIsSearch = false.obs;
  var obsFaqRespon = FaqRespon().obs;
  var realFaq = FaqRespon();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    allFAQ();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    state.dispose();
    super.onClose();
  }

  Future<bool> hariYangSama() async {
    final faqRespon = await getStorage<FaqRespon>();
    if (faqRespon == null || faqRespon.data == null){
     return true;
    }else{
      final pertama = faqRespon.data!.data!.first;
      final lastUpdate = DateTime.parse(pertama.createDate!);
      final DateTime now = DateTime.now();
      if (now.year == lastUpdate.year && now.month == lastUpdate.month && now.day == lastUpdate.day){
        return true;
      }else{
        return false;
      }
    }
  }


  void allFAQ() async {
    obsIsSearch.value = false;
    state.tecSearch!.text = "";
    //cek session dulu apakah pernah simpan faq
    final faq = await getStorage<FaqRespon>();
    final bedaHari = await hariYangSama();
    if (faq.data == null || bedaHari == false ){
      print("Tidak ada data faq");
      //hit api buat get faq
      is_loading.value = true;
      obsIsSearch.value = false;
      state.tecSearch!.text = "";
      var respon = await getService<FaqService>()?.getFAQ(0, "");
      if (respon is FaqError || respon == null){
        jmlRow.value = 0;
        realFaq = FaqRespon();
        Fungsi.koneksiError();
      }else{
        obsFaqRespon.value = respon!;
        //untuk setiap field createDate diubah jadi datetime sekarang
        //nanti dicompare sama datetime now
        respon.data!.forEach((e) {
          e.createDate = DateTime.now().toString();
        });
        respon.data!.forEach((e) {
          print(e.createDate);
        });
        //simpan hasil faq ke session
        baseSaveStorage<FaqRespon>(respon!);
        realFaq.data = respon!.data;
        jmlRow.value = respon.data!.length;
      }
      is_loading.value = false;
    }else{
      //faq session ditampilkan di view
      print("FAQ sudah ada");
      obsFaqRespon.value = faq.data!;
      jmlRow.value = obsFaqRespon.value.data!.length;
    }
  }

  void filterFAQ() async {
    if (state.tecSearch!.text.isNotEmpty){
      state.words.clear();
      state.words![state.tecSearch!.text] = HighlightedWord(textStyle: TextStyle(backgroundColor: Colors.yellow));
      obsIsSearch.value = true;
      is_loading.value = true;
      final respon = await getService<FaqService>()?.getFAQ(1, state.tecSearch!.text);
      if (respon is FaqError || respon == null){
        jmlRow.value = 0;
        realFaq = FaqRespon();
        Fungsi.errorToast("Gagal memproses FAQ");
      }else{
        obsFaqRespon.value = respon!;
        realFaq.data = respon!.data;
        jmlRow.value = respon.data!.length;
      }
      is_loading.value = false;
    }else{
      obsIsSearch.value= false;
    }
  }
}