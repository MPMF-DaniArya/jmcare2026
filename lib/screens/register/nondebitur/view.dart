
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/base/jmcare_green_screen.dart';
import 'package:jmcare/screens/register/nondebitur/logic.dart';
import '../../../helper/Komponen.dart';
import '../../../helper/Konstan.dart';

class RegisterNonDebiturScreen extends StatelessWidget {
  const RegisterNonDebiturScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(RegisterNonDebiturLogic());
    final state = Get.find<RegisterNonDebiturLogic>().state;
    return GetBuilder<RegisterNonDebiturLogic>(
      assignId: true,
      builder: (logic) {
        return JmcareBarScreen(
          title: "Register Non Debitur",
          body: Form(
            key: state.formKey,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: state.namaController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.man),
                      labelText: "Nama"
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Konstan.tagrequired;
                    }
                    return null;
                  },
                ),
                Visibility(
                  visible: state.vis,
                  child:
                  TextFormField(
                    controller: state.alamatController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.home),
                        labelText: "Alamat"
                    ),
                  ),),
                Visibility(
                  visible: state.vis,
                    child:
                  TextFormField(
                    buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
                    controller: state.ktpController,
                    maxLength: 16,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.credit_card),
                        labelText: "Nomor KTP"
                    ),
                  )),
                TextFormField(
                  buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
                  controller: state.hpController,
                  textInputAction: TextInputAction.next,
                  maxLength: 16,
                  keyboardType: TextInputType.number,
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
                Visibility(
                    visible: state.vis,
                      child:
                  TextFormField(
                    controller: state.emailController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.mail),
                        labelText: "Email"
                    ),
                  )),
                Visibility(
                  visible: state.vis,
                    child:
                  TextFormField(
                    controller: state.pekerjaanController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.sensor_occupied),
                        labelText: "Pekerjaan"
                    ),
                  )),
                Visibility(
                  visible: state.vis,
                      child:
                  TextFormField(
                    controller: state.tempatController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.home),
                        labelText: "Tempat lahir"
                    ),
                  )),
                Visibility(
                  visible: state.vis,
                    child:
                  TextFormField(
                    controller: state.tgllahirController,
                    readOnly: true,
                    onTap: (() => logic.tapTanggalLahir(context)),
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month),
                        labelText: "Tanggal lahir"
                    ),
                  )),
                Visibility(
                  visible: state.vis,
                    child:
                  DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "Jenis kelamin"
                      ),
                      items: state.ddJenisKelamin,
                      onChanged: (newValue){
                        logic.setValue_DDJenisKelamin(newValue);
                      }
                  )),
                Obx(() {
                  return TextFormField(
                    onChanged: ((e) => logic.checkPasswordStrength(e)),
                    controller: state.passwordController,
                    obscureText: logic.show_password_1.value,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
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
                    keyboardType: TextInputType.visiblePassword,
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
                      logic.doRegisterNonDebitur(context);
                    },
                      child: const Text("REGISTER")),),
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
