import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/eContract/form_pengaduan/logic.dart';

class FormpengaduanEContractScreen extends StatelessWidget {
  const FormpengaduanEContractScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final logic = Get.put(FormpengaduanEContractLogic());
    final state = Get.find<FormpengaduanEContractLogic>().state;

    return GetBuilder<FormpengaduanEContractLogic>(
        assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Formulir Pengaduan",
            body: Form(
                key: state.formKey,
                child: ListView(
                  children: [

                    TextFormField(
                      decoration: InputDecoration(
                        label: Komponen.astericText("Nama lengkap"),
                        hintText: Konstan.tag_hint_nama_lengkap
                      ),
                      controller: state.tecNamaLengkap,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        return value!.isEmpty ? Konstan.tagrequired : null;
                      },
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        label: Komponen.astericText("Nomor kontrak"),
                          hintText: Konstan.tag_hint_nomor_kontrak
                      ),
                      controller: state.tecAgreementNo,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        return value!.isEmpty ? Konstan.tagrequired : null;
                      },
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        label: Komponen.astericText("Nomor HP"),
                          hintText: Konstan.tag_hint_nomor_hp
                      ),
                      controller: state.tecNomorHP,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value){
                        return value!.isEmpty ? Konstan.tagrequired : null;
                      },
                    ),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                          hintText: Konstan.tag_hint_email
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: state.tecEmail,
                      validator: (value){
                        return value!.isEmpty ? Konstan.tagrequired : null;
                      },
                    ),

                    TextFormField(
                      controller: state.tecPesan,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        label: Komponen.astericText("Keluhan / tanggapan"),
                          hintText: Konstan.tag_hint_keluhan
                      ),
                      validator: (value){
                        return value!.isEmpty ? Konstan.tagrequired : null;
                      },
                    ),

                    const Padding(padding: EdgeInsets.only(top: 5)),

                    Obx(
                            () => logic.is_loading.value
                                ? Komponen.getLoadingWidget()
                                :  FilledButton(
                                    onPressed: (){
                                      logic.submit();
                                    },
                                    child: const Text("Submit")
                                )
                    )

                  ],
                )
            )
          );
        }
    );
  }
}
