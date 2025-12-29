import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/gantipassword/logic.dart';
import 'package:jmcare/screens/gantipassword/state.dart';

import '../../helper/Konstan.dart';

class GantipasswordScreen extends StatelessWidget {
  const GantipasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(GantipasswordLogic());
    final state = Get.find<GantipasswordLogic>().state;

    return GetBuilder<GantipasswordLogic>(
        assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Ganti Password",
            body: Form(
              key: state.formKey,
              child: ListView(
                children: [

                  Obx(() =>
                  TextFormField(
                    controller: state.tecOldpassword,
                    obscureText: !logic.obsVis0.value,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Password lama",
                        suffixIcon: ExcludeFocus(child: IconButton(
                            onPressed: () => logic.handleVis(0),
                            icon: logic.obsVis0.value ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)
                        ),)
                    ),
                    validator: (value){
                      return value!.isEmpty ? Konstan.tagrequired : null;
                    },
                  )),

                  Obx(() =>
                      TextFormField(
                        controller: state.tecNewpassword,
                        obscureText: !logic.obsVis1.value,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Password baru",
                          suffixIcon: ExcludeFocus(child: IconButton(
                              onPressed: () => logic.handleVis(1),
                              icon: logic.obsVis1.value ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)
                          ),)
                        ),
                        validator: (value){
                          return value!.isEmpty ? Konstan.tagrequired : null;
                        },
                      )),

                  Obx(() =>
                      TextFormField(
                        controller: state.tecUlangpassword,
                        obscureText: !logic.obsVis2.value,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: "Ulangi password baru",
                          suffixIcon: IconButton(
                              onPressed: () => logic.handleVis(2),
                              icon: logic.obsVis2.value ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)
                          ),
                        ),
                        validator: (value){
                          return value!.isEmpty ? Konstan.tagrequired : null;
                        },
                      )),


                  const Padding(padding: EdgeInsets.only(top: 5)),

                  Obx(
                          () => logic.is_loading.value
                              ? Komponen.getLoadingWidget()
                              : FilledButton(
                                    onPressed: logic.submit,
                                    child: const Text("Ganti password")
                                )
                  )
                ],
            ),)
          );
        }
    );
  }
}
