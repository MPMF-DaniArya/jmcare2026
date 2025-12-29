import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/esign_blue_screen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/esign/registrasi/logic.dart';

class EsignRegisterScreen extends StatelessWidget {
  const EsignRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(EsignRegisterLogic());
    final state = Get.find<EsignRegisterLogic>().state;

    return GetBuilder<EsignRegisterLogic>(
        assignId: true,
        builder: (logic) {
          return EsignBlueScreen(
              title: "Foto dan Password",
              body: Form(
                key: state.formKey,
                child: ListView(
                  children: [
                    InkWell(
                      onTap: () {
                        logic.showPicker(context, "KTP");
                      },
                      child: DottedBorder(
                        color: Colors.grey,
                        dashPattern: const [8, 4],
                        strokeWidth: 2,
                        child: SizedBox(
                            height: 150,
                            child: Stack(
                              children: [
                                state.imageKTP == null
                                    ? const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Tap disini untuk mengambil foto KTP",
                                          style: TextStyle(
                                              color: Colors.grey),
                                        ))
                                    : Align(
                                        alignment: Alignment.center,
                                        child:
                                            Image.file(state.imageKTP!)),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        logic.clearFoto("KTP");
                                      },
                                    ))
                              ],
                            )),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    InkWell(
                      onTap: () {
                        logic.showPicker(context, "Profil");
                      },
                      child: DottedBorder(
                        color: Colors.grey,
                        dashPattern: const [8, 4],
                        strokeWidth: 2,
                        child: SizedBox(
                            height: 150,
                            child: Stack(
                              children: [
                                state.imageProfil == null
                                    ? const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Tap disini untuk mengambil foto selfi",
                                          style: TextStyle(
                                              color: Colors.grey),
                                        ))
                                    : Align(
                                        alignment: Alignment.center,
                                        child: Image.file(
                                            state.imageProfil!)),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        logic.clearFoto("Profil");
                                      },
                                    ))
                              ],
                            )),
                      ),
                    ),

                    const Padding(padding: EdgeInsets.only(top: 10)),

                    Obx(() {
                      return TextFormField(
                        controller: state.tecPassword,
                        obscureText: logic.show_pass.value,
                        decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  logic.show_pass_action();
                                },
                                icon: logic.show_pass.value
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(
                                        Icons.remove_red_eye_outlined))),
                      );
                    }),

                    Obx(() {
                      return TextFormField(
                        controller: state.tecUlangpassword,
                        obscureText: logic.show_ulangi_pass.value,
                        decoration: InputDecoration(
                            labelText: "Ulangi password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  logic.show_ulangi_pass_action();
                                },
                                icon: logic.show_ulangi_pass.value
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(
                                        Icons.remove_red_eye_outlined))),
                      );
                    }),

                    // CheckboxListTile(
                    //   title: const Text("Saya bersedia menerima penawaran produk"),
                    //   value: state.is_check_penawaran,
                    //   onChanged: (bool? newValue) {
                    //     logic.handleCekpenawaran(newValue!);
                    //   },
                    //   tristate: false,
                    //   activeColor: Colors.green,
                    //   checkColor: Colors.white,
                    //   controlAffinity: ListTileControlAffinity.leading,
                    // ),
                    // CheckboxListTile(
                    //   title: Text(state.title_pernyataan),
                    //   value: state.is_check_pernyataan,
                    //   onChanged: (bool? newValue) {
                    //     logic.handleCekpernyataan(newValue!);
                    //   },
                    //   tristate: false,
                    //   activeColor: Colors.green,
                    //   checkColor: Colors.white,
                    //   controlAffinity: ListTileControlAffinity.leading,
                    // ),
                    // const Padding(padding: EdgeInsets.only(top: 10)),

                    const Padding(padding: EdgeInsets.only(top: 10)),

                    Obx(() {
                      return logic.is_loading.value
                          ? Komponen.getLoadingWidget()
                          : ElevatedButton(
                              onPressed: () => logic.submit(),
                              child: const Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ));
                    }),
                  ],
                ),
              ));
        });
  }
}
