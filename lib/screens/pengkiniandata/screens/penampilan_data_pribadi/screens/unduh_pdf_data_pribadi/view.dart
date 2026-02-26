import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/screens/unduh_pdf_data_pribadi/logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/screens/unduh_pdf_data_pribadi/state.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../helper/Komponen.dart';

class UnduhPdfDataPribadiScreen extends StatelessWidget {
  const UnduhPdfDataPribadiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UnduhPdfDataPribadiLogic logic = Get.put(UnduhPdfDataPribadiLogic());
    final UnduhPdfDataPribadiState state =
        Get.find<UnduhPdfDataPribadiLogic>().state;

    return JmcareBarScreen(
      title: "Masukkan PIN Anda",
      // Bungkus body dengan Obx agar UI reaktif terhadap is_loading
      body: Obx(
        () => logic.is_loading.value
            ? Padding(
                padding: const EdgeInsets.all(24),
                child: Komponen.getLoadingWidget())
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Pin anda dibutuhkan untuk dapat mengunduh data pribadi anda!',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    Pinput(
                      length: 6,
                      controller: state.tecINPUT,
                      obscureText: true,
                      obscuringCharacter: "*",
                      autofocus: true,
                      enabled: !logic.is_loading.value,
                      onCompleted: (pin) => logic.downloadDataPribadi(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
