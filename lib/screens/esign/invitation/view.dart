import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/base/esign_blue_screen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/esign/invitation/logic.dart';

class EsigninvitationScreen extends StatelessWidget {
  const EsigninvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(EsigninvitationLogic());
    final state = Get.find<EsigninvitationLogic>().state;

    return GetBuilder<EsigninvitationLogic>(
        assignId: true,
        builder: (logic) {
          return EsignBlueScreen(
            title: "Isi Biodata",
            body: Obx(() => logic.is_loading.value
                ? Komponen.getLoadingWidget()
                : Form(
                    key: state.formKey,
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: state.tecNama,
                          decoration: const InputDecoration(
                              labelText: "Nama sesuai KTP (tanpa gelar)"),
                        ),
                        TextFormField(
                          controller: state.tecEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              const InputDecoration(labelText: "Email"),
                        ),
                        TextFormField(
                          controller: state.tecNIK,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: "Nomor KTP"),
                        ),
                        TextFormField(
                          controller: state.tecTmplahir,
                          decoration: const InputDecoration(
                              labelText: "Tempat kelahiran"),
                        ),
                        TextFormField(
                          controller: state.tecTgllahir,
                          decoration: const InputDecoration(
                              labelText: "Tanggal lahir"),
                          onTap: () {
                            logic.klikTgllahir(context);
                          },
                        ),
                        TextFormField(
                          buildCounter: (BuildContext context,
                                  {int? currentLength,
                                  int? maxLength,
                                  bool? isFocused}) =>
                              null,
                          maxLength: 16,
                          keyboardType: TextInputType.number,
                          controller: state.tecHP,
                          decoration: const InputDecoration(
                              labelText: "Nomor HP aktif"),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text("Jenis kelamin"),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                  title: const Text("Pria"),
                                  value: state.options_gender[0],
                                  groupValue: state.current_option_gender,
                                  onChanged: (value) {
                                    logic.handleOptionGender(value!);
                                  }),
                            ),
                            Expanded(
                                child: RadioListTile(
                                    title: const Text("Wanita"),
                                    value: state.options_gender[1],
                                    groupValue:
                                        state.current_option_gender,
                                    onChanged: (value) {
                                      logic.handleOptionGender(value!);
                                    })),
                          ],
                        ),
                        TextFormField(
                          controller: state.tecAlamat,
                          decoration:
                              const InputDecoration(labelText: "Alamat"),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: state.tecPropinsi,
                          decoration: const InputDecoration(
                              labelText: "Propinsi",
                              suffixIcon:
                                  Icon(Icons.arrow_drop_down_outlined)),
                          onTap: () =>
                              logic.dialogWilayah(Konstan.tag_propinsi),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: state.tecKabupaten,
                          decoration: const InputDecoration(
                              labelText: "Kabupaten",
                              suffixIcon:
                                  Icon(Icons.arrow_drop_down_outlined)),
                          onTap: () =>
                              logic.dialogWilayah(Konstan.tag_kabupaten),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: state.tecKecamatan,
                          decoration: const InputDecoration(
                              labelText: "Kecamatan",
                              suffixIcon:
                                  Icon(Icons.arrow_drop_down_outlined)),
                          onTap: () =>
                              logic.dialogWilayah(Konstan.tag_kecamatan),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: state.tecKelurahan,
                          decoration: const InputDecoration(
                              labelText: "Kelurahan",
                              suffixIcon:
                                  Icon(Icons.arrow_drop_down_outlined)),
                          onTap: () =>
                              logic.dialogWilayah(Konstan.tag_kelurahan),
                        ),
                        TextFormField(
                          buildCounter: (BuildContext context,
                                  {int? currentLength,
                                  int? maxLength,
                                  bool? isFocused}) =>
                              null,
                          controller: state.tecKodepos,
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: "Kode pos"),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        ElevatedButton(
                            onPressed: () => logic.submit(),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  )),
          );
        });
  }
}
