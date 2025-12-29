import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/layanan_pengaduan/logic.dart';
import 'package:jmcare/screens/layanan_pengaduan/state.dart';
import 'package:jmcare/screens/layanan_pengaduan/widgets/lampiran_image_picker.dart';

import '../../helper/Konstan.dart';

class LayananPengaduanScreen extends StatelessWidget {
  const LayananPengaduanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LayananPengaduanLogic logic = Get.put(LayananPengaduanLogic());
    final LayananPengaduanState state = Get.find<LayananPengaduanLogic>().state;

    return JmcareBarScreen(
      title: 'Formulir Kritik & Saran / Pengaduan',
      body: SingleChildScrollView(
        child: GetBuilder<LayananPengaduanLogic>(
          assignId: true,
          builder: (logic) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsetsGeometry.all(12),
                child: Obx(() => logic.is_loading.value
                    ? Padding(
                        padding: const EdgeInsetsGeometry.only(top: 150),
                        child: Komponen.getLoadingWidget(),
                      )
                    : Form(
                        key: state.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                                alignment: AlignmentGeometry.centerLeft,
                                child: Komponen.astericText('Nama Lengkap')),
                            MyReadOnlyITextFormField(
                              controller: state.tecNamaLengkap,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                                alignment: AlignmentGeometry.centerLeft,
                                child: Komponen.astericText('Nomor HP')),
                            MyReadOnlyITextFormField(
                              controller: state.tecNoHp,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                                alignment: AlignmentGeometry.centerLeft,
                                child: Komponen.astericText('Email')),
                            MyReadOnlyITextFormField(
                              controller: state.tecEmail,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Obx(
                              () {
                                if (logic.isDebitur.value &&
                                    logic.ddNomorKontrak.isNotEmpty) {
                                  return Column(
                                    children: [
                                      Align(
                                          alignment:
                                              AlignmentGeometry.centerLeft,
                                          child: Komponen.astericText(
                                              'No Agreement')),
                                      DropdownButtonFormField<String>(
                                          isExpanded: true,
                                          items: logic.ddNomorKontrak,
                                          value: logic.idxDdNomorKontrak
                                                      .value ==
                                                  ""
                                              ? null
                                              : logic.idxDdNomorKontrak.value,
                                          onChanged: (newValue) {
                                            logic.setDDNomorKontrak(newValue!);
                                          }),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const Align(
                                          alignment:
                                              AlignmentGeometry.centerLeft,
                                          child: Text('Tipe Unit')),
                                      MyReadOnlyITextFormField(
                                        controller: state.tecTipeUnit,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const Align(
                                          alignment:
                                              AlignmentGeometry.centerLeft,
                                          child: Text('No. Plat')),
                                      MyReadOnlyITextFormField(
                                        controller: state.tecNoPlat,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                            Align(
                                alignment: AlignmentGeometry.centerLeft,
                                child: Komponen.astericText(
                                    'Kritik & Saran / Pengaduan')),
                            TextFormField(
                              controller: state.tecKritikDanSaran,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              minLines: 1,
                              maxLines: 5,
                              validator: (value) {
                                return value!.isEmpty
                                    ? Konstan.tagrequired
                                    : null;
                              },
                              decoration: const InputDecoration(
                                  hintText:
                                      'Tuliskan kritik & saran / pengaduan anda...'),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Align(
                              alignment: AlignmentGeometry.centerLeft,
                              child: Text('Lampiran (opsional)',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: Konstan.tag_default_font)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const LampiranImagePicker(),
                            const SizedBox(
                              height: 41,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    logic.submit(context);
                                  },
                                  child: const Text("Submit")),
                            ),
                          ],
                        ),
                      )),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyReadOnlyITextFormField extends StatelessWidget {
  const MyReadOnlyITextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      textInputAction: TextInputAction.next,
    );
  }
}
