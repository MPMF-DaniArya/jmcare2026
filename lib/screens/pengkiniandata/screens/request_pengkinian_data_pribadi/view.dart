import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/custom/container_menu.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/widgets/row_ketentuan_pengkinian.dart';

import 'logic.dart';

class RequestPengkinianDataPribadiScreen extends StatefulWidget {
  const RequestPengkinianDataPribadiScreen({super.key});

  @override
  State<RequestPengkinianDataPribadiScreen> createState() =>
      _RequestPengkinianDataPribadiScreenState();
}

class _RequestPengkinianDataPribadiScreenState
    extends State<RequestPengkinianDataPribadiScreen> {
  bool _isAgreed = false;

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
                RowKetentuanPengkinian(
                    ketentuan:
                        'Proses verifikasi identitas diperlukan untuk memastikan keamanan data Anda.',
                    textTheme: textTheme),
                const SizedBox(
                  height: 8,
                ),
                RowKetentuanPengkinian(
                    ketentuan:
                        'Permintaan akan diproses dalam waktu 3 hari kerja.',
                    textTheme: textTheme),
                const SizedBox(
                  height: 8,
                ),
                RowKetentuanPengkinian(
                    ketentuan:
                        'JACCS MPM Finance berhak melakukan penolakan permintaan apabila data/dokumen yang dicantumkan tidak sesuai, atau pengajuan tidak dilakukan oleh Subjek Data Pribadi sendiri.',
                    textTheme: textTheme),
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
            Row(
              children: [
                Checkbox(
                  value: _isAgreed,
                  onChanged: (value) {
                    setState(() {
                      _isAgreed = value!;
                    });
                  },
                ),
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Saya telah membaca dan menyetujui ',
                        style: textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => print('Link Ditekan'),
                        child: Text(
                          "syarat dan ketentuan penghapusan data pribadi.",
                          style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
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
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
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
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Colors.green,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Unggah Dokumen Pendukung',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Unggah dokumen pendukung sebagai bukti perubahan.',
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.8)),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.upload_sharp),
                      label: const Text('Pilih Dokumen'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Status: Dokumen berhasil diunggah.',
                      style: textTheme.labelMedium!.copyWith(color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.8))
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
