import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/klaim_asuransi/kontak_insco/logic.dart';
import 'package:jmcare/screens/klaim_asuransi/kontak_insco/state.dart';

class KontakinscoScreen extends StatelessWidget {
  const KontakinscoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final KontakinscoLogic logic = Get.put(KontakinscoLogic());
    final KontakinscoState state = Get.find<KontakinscoLogic>().state;

    return GetBuilder<KontakinscoLogic>
      (
        assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Kontak Insco",
            body: ListView(
              children: [
                ListTile(
                  title: const Text("Customer Care"),
                  leading: Image.asset("assets/images/whatsapp.png"),
                  subtitle: const Text("Hubungkan dengan Whatsapp Customer Care Insco"),
                  onTap: () {
                    logic.launchWhatsapp();
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text("Hotline Service"),
                  leading: Image.asset("assets/images/phone.png"),
                  subtitle: const Text("Hubungkan dengan hotline service Insco"),
                  onTap: (){
                    logic.launchPhone();
                  },
                )
              ],
            ),
          );
        }
    );
  }
}
