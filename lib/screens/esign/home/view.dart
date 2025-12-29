import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/esign_blue_screen.dart';
import 'package:jmcare/screens/esign/home/logic.dart';
import 'package:jmcare/screens/esign/home/state.dart';

class EsignhomeScreen extends StatelessWidget {
  const EsignhomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EsignhomeLogic logic = Get.put(EsignhomeLogic());
    final EsignhomeState state = Get.find<EsignhomeLogic>().state;

    return GetBuilder<EsignhomeLogic>(
        assignId: true,
        builder: (logic) {
          return EsignBlueScreen(
            title: "Menu eSignHub",
            body: Obx(() => ListView(
              children: [

                ListTile(
                  leading: logic.is_loading.value ? const CircularProgressIndicator(color: Colors.blue,) : Image.asset("assets/images/logoesign.png"),
                  title: const Text("Registrasi eSignHub"),
                  subtitle: const Text("Daftarkan akun Anda ke eSignHub"),
                  onTap: (){
                    logic.cekRegistrasiEsign(context);
                  },
                ),

                ListTile(
                  leading: Image.asset("assets/images/logoesign.png"),
                  title: const Text("Login eSignHub"),
                  subtitle: const Text("Masuk ke dalam eSignHub"),
                  onTap: (){
                    logic.loginEsignHub();
                  },
                ),

                ListTile(
                  leading: Image.asset("assets/images/logoesign.png"),
                  title: const Text("Kotak masuk"),
                  subtitle: const Text("Periksa dokumen Anda di kotak masuk"),
                  onTap: (){
                    logic.notAvailable();
                  },
                  enabled: false,
                ),

                ListTile(
                  leading: Image.asset("assets/images/logoesign.png"),
                  title: const Text("Tanda tangan"),
                  subtitle: const Text("Berikan tanda tangan digital pada dokumen Anda"),
                  onTap: (){
                    logic.notAvailable();
                  },
                  enabled: false,
                ),

                ListTile(
                  leading: Image.asset("assets/images/logoesign.png"),
                  title: const Text("Status tanda tangan"),
                  subtitle: const Text("Periksa status penandatanganan pada dokumen"),
                  onTap: (){
                    logic.notAvailable();
                  },
                  enabled: false,
                ),

                ListTile(
                  leading: Image.asset("assets/images/logoesign.png"),
                  title: const Text("Materai"),
                  subtitle: const Text("Permintaan materai pada dokumen Anda"),
                  onTap: (){
                    logic.notAvailable();
                  },
                  enabled: false,
                ),

                ListTile(
                  leading: Image.asset("assets/images/logoesign.png"),
                  title: const Text("Status materai"),
                  subtitle: const Text("Periksa status permintaan materai"),
                  onTap: (){
                    logic.notAvailable();
                  },
                  enabled: false,
                ),

                ListTile(
                  leading: Image.asset("assets/images/logoesign.png"),
                  title: const Text("Download"),
                  subtitle: const Text("Unduh dokumen Anda pada device ini"),
                  onTap: (){
                    logic.notAvailable();
                  },
                  enabled: false,
                ),

                ListTile(
                  leading: logic.loadingUnsigned.value ? const CircularProgressIndicator(color: Colors.blue,) : Image.asset("assets/images/logoesign.png"),
                  title: const Text("Periksa dokumen"),
                  subtitle: const Text("Cek jumlah dokumen Anda yang belum ditanda tangani"),
                  onTap: (){
                    logic.unsignedDocEsign();
                  },
                )
              ],
            ),)
          );
        });
  }
}
