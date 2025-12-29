import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/register/debitur/logic.dart';
import '../../../helper/Komponen.dart';
import '../../../helper/Konstan.dart';

class RegisterDebiturScreen extends StatelessWidget {
  const RegisterDebiturScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(RegisterDebiturLogic());
    final state = Get.find<RegisterDebiturLogic>().state;

    return GetBuilder<RegisterDebiturLogic>(
      assignId: true,
      builder: (logic) {
        return JmcareBarScreen(
          title: "Register Debitur",
          body: Form(
            key: state.formKey,
            child: ListView(
              children: [
                TextFormField(
                  buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
                  controller: state.ktpController,
                  maxLength: 16,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.credit_card),
                      labelText: "Nomor KTP"
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Konstan.tagrequired;
                    }
                    return null;
                  },
                ),

                TextFormField(
                  buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
                  controller: state.hpController,
                  maxLength: 16,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.phone_android),
                      labelText: "Nomor HP"
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Konstan.tagrequired;
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: state.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.mail),
                      labelText: "Email"
                  ),
                ),

                Obx(() {
                  return TextFormField(
                    onChanged: ((e) => logic.checkPasswordStrength(e)),
                    controller: state.passwordController,
                    textInputAction: TextInputAction.next,
                    obscureText: logic.show_password_1.value,
                    decoration:  InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(onPressed: (){
                          logic.showHidePassword_1();
                        },
                            icon: logic.show_password_1.value ? const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined))
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Konstan.tagrequired;
                      }
                      return null;
                    },
                  );
                }),

                const Padding(padding: EdgeInsets.only(top: 5)),

                const Padding(padding: EdgeInsets.only(left: 10),
                  child: Text(Konstan.tag_kekuatan_password, style: TextStyle(fontSize: 10),),
                ),

                const Padding(padding: EdgeInsets.only(top: 5)),

                Obx(() {
                  return Padding(padding: const EdgeInsets.only(
                      left: 10),
                      child: Text(
                          logic.password_strength.value
                              ? "Password kuat"
                              : "Password lemah",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: logic.password_strength.value ? Colors.green : Colors.red,
                              fontSize: 10)
                      )
                  );
                }),

                Obx(() {
                  return TextFormField(
                    controller: state.ulangipasswordController,
                    obscureText: logic.show_password_2.value,
                    textInputAction: TextInputAction.done,
                    decoration:  InputDecoration(
                        labelText: "Ulangi password",
                        suffixIcon: IconButton(onPressed: (){
                          logic.showHidePassword_2();
                        },
                            icon: logic.show_password_2.value ? const Icon(Icons.remove_red_eye) : const Icon(Icons.remove_red_eye_outlined))
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Konstan.tagrequired;
                      }
                      return null;
                    },
                  );
                }),

                const Padding(padding: EdgeInsets.only(top: 20)),

                Obx(() =>  logic.is_loading.value == true ? Komponen.getLoadingWidget():
                ElevatedButton(onPressed: (){
                  logic.doRegisterDebitur(context);
                }, child: const Text("REGISTER")),),

                const Padding(padding: EdgeInsets.only(top: 10)),

                OutlinedButton(
                    onPressed: (){
                      logic.back();
                    },
                    child: const Text("Kembali")
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Komponen.teksPDK()
              ],
            )
          ),
        );
      },
    );
  }
}
