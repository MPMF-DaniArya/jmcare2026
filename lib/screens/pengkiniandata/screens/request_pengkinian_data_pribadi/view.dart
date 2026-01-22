import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/custom/container_menu.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';

import 'logic.dart';

class RequestPengkinianDataPribadiScreen extends StatelessWidget {
  const RequestPengkinianDataPribadiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final logic = Get.put(RequestPengkinianDataPribadiLogic());
    final state = Get.find<RequestPengkinianDataPribadiLogic>().state;

    return JmcareBarScreen(
        title: 'Permintaan Perubahan',
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            ContainerMenu(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ketentuan Pengkinian Data',
                  style: textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(Konstan.tag_ketentuan_pengkinian_data,
                    style: textTheme.bodyMedium),
                const SizedBox(
                  height: 8,
                ),
                _rowKetentuanPengkinianData(
                    'Proses verifikasi identitas diperlukan untuk memastikan keamanan data Anda.',
                    textTheme),
                const SizedBox(
                  height: 8,
                ),
                _rowKetentuanPengkinianData(
                    'Proses verifikasi identitas diperlukan untuk memastikan keamanan data Anda.',
                    textTheme),
                const SizedBox(
                  height: 8,
                ),
                _rowKetentuanPengkinianData(
                    'Proses verifikasi identitas diperlukan untuk memastikan keamanan data Anda.',
                    textTheme),
              ],
            )),
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
                        return _buildFormCard(logic, index, textTheme);
                      })),
                ],
              ),
            ),
            Obx(() {
              if (state.formList.length < state.maxForms) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300),
                        onPressed: logic.addNewForm,
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
        ));
  }

  Widget _rowKetentuanPengkinianData(String ketentuan, TextTheme textTheme) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 24,
            color: Colors.green,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              ketentuan,
              style: textTheme.bodyMedium,
            ),
          )
        ]);
  }

  Widget _buildFormCard(
      RequestPengkinianDataPribadiLogic logic, int index, TextTheme textTheme) {
    final item = logic.state.formList[index];

    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: ContainerMenu(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Permintaan Perubahan #${index + 1}",
                    style: textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  if (index > 0)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => logic.removeForm(index),
                    )
                ],
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Jenis Data',
                        style: textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text: " *",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontFamily: Konstan.tag_default_font)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: item['input1'],
                decoration: InputDecoration(
                  labelText: "Input Pertama",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              Text('Data Saat Ini',
                  style: textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: 'Sementara',
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Perubahan Data',
                        style: textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text: " *",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontFamily: Konstan.tag_default_font)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: item['input2'],
                decoration: InputDecoration(
                  labelText: "Input Kedua",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
