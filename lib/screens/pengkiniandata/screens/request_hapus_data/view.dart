import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_hapus_data/widgets/unggah_dokumen_section.dart';

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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () =>
                              logic.dialogKonfirmasiHapusdata(context),
                          child: Text(
                            "Submit",
                            style: textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ]),
              ),
      ),
    );
  }
}
