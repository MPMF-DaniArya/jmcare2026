import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_hapus_data/widgets/unggah_dokumen_section.dart';

import '../../../../helper/Warna.dart';
import 'logic.dart';
import 'widgets/container_ketentuan_hapus_data.dart';

class RequestHapusDataScreen extends StatefulWidget {
  const RequestHapusDataScreen({super.key});

  @override
  State<RequestHapusDataScreen> createState() => _RequestHapusDataScreenState();
}

class _RequestHapusDataScreenState extends State<RequestHapusDataScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final logic = Get.put(RequestHapusDataLogic());
    final state = Get.find<RequestHapusDataLogic>().state;

    return JmcareBarScreen(
      title: 'Permintaan Hapus',
      body: Obx(
        () => logic.is_loading.value
            ? Komponen.getLoadingWidget()
            : SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ContainerKetentuanHapusData(textTheme: textTheme),
                      const SizedBox(
                        height: 16,
                      ),
                      UnggahDokumenSection(textTheme: textTheme),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: () => logic.isSetuju.value =
                                    !logic.isSetuju.value,
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.fastOutSlowIn,
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: logic.isSetuju.value
                                            ? Warna.hijau1
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                        // Lebih rounded = lebih modern
                                        border: Border.all(
                                          color: logic.isSetuju.value
                                              ? Warna.hijau1
                                              : Colors.grey.shade400,
                                          width: 2,
                                        ),
                                      ),
                                      child: logic.isSetuju.value
                                          ? const Icon(Icons.check,
                                              size: 18, color: Colors.white)
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: 'Saya telah membaca dan menyetujui',
                                    style: textTheme.bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        ' syarat dan ketentuan penghapusan data pribadi',
                                    style: textTheme.bodyMedium!.copyWith(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold)),
                              ])),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: logic.isSetuju.value
                                ? () => logic.dialogKonfirmasiHapusdata(context)
                                : null,
                            child: Text(
                              "Submit",
                              style: textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
      ),
    );
  }
}
