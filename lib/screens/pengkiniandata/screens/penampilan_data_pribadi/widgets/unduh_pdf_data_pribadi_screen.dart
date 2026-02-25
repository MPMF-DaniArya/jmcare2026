import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/state.dart';
import 'package:jmcare/screens/pin/auth/logic.dart';
import 'package:jmcare/screens/pin/auth/state.dart';
import 'package:pinput/pinput.dart';

class UnduhPdfDataPribadiScreen extends StatelessWidget {
  const UnduhPdfDataPribadiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PenampilanDataPribadiLogic logic =
        Get.put(PenampilanDataPribadiLogic());
    final PenampilanDataPribadiState state =
        Get.find<PenampilanDataPribadiLogic>().state;

    return JmcareBarScreen(
      title: "Masukkan PIN Anda",
      body: Padding(
        padding: const EdgeInsetsGeometry.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pin anda dibutuhkan untuk dapat mengunduh data pribadi anda!',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 18,
            ),
            Pinput(
              length: 6,
              controller: state.tecINPUT,
              obscureText: true,
              obscuringCharacter: "*",
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
                onPressed: () => logic.downloadDataPribadi(),
                child: const Text("Cek PIN")),
          ],
        ),
      ),
    );
  }
}
