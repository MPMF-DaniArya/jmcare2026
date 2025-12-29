import 'dart:io';

import 'package:jmcare/helper/Fungsi.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/klaim_asuransi/kontak_insco/state.dart';

class KontakinscoLogic extends BaseLogic{

  final KontakinscoState state = KontakinscoState();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  launchWhatsapp() async {
    print("launch wha");
    if (Platform.isAndroid) {
      // add the [https]
      launchUrl( Uri.parse("https://wa.me/+628111588676")); // new line
    } else {
      // add the [https]
      launchUrl( Uri.parse("https://wa.me/+628111588676"));
    }
  }

  launchPhone() async {
    print("launch phone");
    if (Platform.isAndroid) {
      // add the [https]
      launchUrl( Uri.parse("tel:1500676")); // new line
    } else {
      // add the [https]
      launchUrl( Uri.parse("tel:1500676"));
    }

  }

}