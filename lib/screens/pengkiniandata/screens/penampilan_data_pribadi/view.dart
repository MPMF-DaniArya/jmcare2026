import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/state.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/widgets/informasi_data_pribadi_section.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/widgets/penting_untuk_diketahui_section.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/widgets/unduh_data_pribadi_section.dart';

import '../../../../helper/Komponen.dart';
import 'logic.dart';

class PenampilanDataPribadiScreen extends StatelessWidget {
  const PenampilanDataPribadiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final PenampilanDataPribadiLogic logic =
        Get.put(PenampilanDataPribadiLogic());
    final PenampilanDataPribadiState state =
        Get.find<PenampilanDataPribadiLogic>().state;

    return JmcareBarScreen(
      title: 'Tampilan Permintaan',
      body: Obx(() => logic.is_loading.value
          ? Center(child: Komponen.getLoadingWidget())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InformasiDataPribadiSection(
                      textTheme: textTheme, state: state),
                  const SizedBox(
                    height: 16,
                  ),
                  UnduhDataPribadiSection(textTheme: textTheme),
                  const SizedBox(
                    height: 16,
                  ),
                  PentingUntukDiketahuiSection(textTheme: textTheme)
                ],
              ),
            )),
    );
  }
}
