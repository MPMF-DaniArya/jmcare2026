import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/custom/container_menu.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_pengkinian_data_pribadi/widgets/ketentuan_pengkinian_data_section.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_pengkinian_data_pribadi/widgets/perbarui_informasi_pribadi_section.dart';

import 'logic.dart';

class RequestPengkinianDataPribadiScreen extends StatefulWidget {
  const RequestPengkinianDataPribadiScreen({super.key});

  @override
  State<RequestPengkinianDataPribadiScreen> createState() =>
      _RequestPengkinianDataPribadiScreenState();
}

class _RequestPengkinianDataPribadiScreenState
    extends State<RequestPengkinianDataPribadiScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final logic = Get.put(RequestPengkinianDataPribadiLogic());
    final state = Get.find<RequestPengkinianDataPribadiLogic>().state;

    return JmcareBarScreen(
        title: 'Permintaan Perubahan',
        body: SingleChildScrollView(
          child: Form(
            key: state.formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              KetentuanPengkinianDataSection(textTheme: textTheme),
              const SizedBox(
                height: 16,
              ),
              ContainerMenu(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Perbarui Informasi Pribadi Anda',
                      style: textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                        'Anda dapat mengajukan beberapa permintaan perubahan sekaligus.',
                        style: textTheme.bodyMedium),
                    Obx(() => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.formList.length,
                        itemBuilder: (context, index) {
                          return PerbaruiInformasiPribadiSection(
                            textTheme: textTheme,
                            index: index,
                            logic: logic,
                          );
                        })),
                    Obx(() {
                      if (state.formList.length < state.maxForms) {
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade300),
                                onPressed: logic.addFormBaru,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      size: 24,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Tambah Entri Baru",
                                      style: textTheme.bodyMedium!.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: logic.submitData,
                  child: Text(
                    "Submit",
                    style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
