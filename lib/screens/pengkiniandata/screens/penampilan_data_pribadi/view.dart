import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/state.dart';
import 'package:jmcare/custom/container_menu.dart';

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
                  ContainerMenu(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Data Pribadi Anda',
                        style: textTheme.titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        thickness: 1.5,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildRow(
                          'Nama Lengkap', state.dummyData['nama'], textTheme),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildRow('Nomor Id', state.dummyData['id'].toString(),
                          textTheme),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildRow('Tempat, Tanggal Lahir',
                          state.dummyData['tempatTanggalLahir'], textTheme),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildRow('Alamat Sesuai Id',
                          state.dummyData['alamatSesuaiId'], textTheme),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildRow('Alamat Domisili',
                          state.dummyData['alamatDomisili'], textTheme),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildRow('Nomor Telepon', state.dummyData['nomorTelepon'],
                          textTheme),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildRow('Nomor Kontrak', state.dummyData['nomorKontrak'],
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
                        'Informasi Data Pribadi Anda',
                        style: textTheme.titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        thickness: 1.5,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.download),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Unduh PDF Data Pribadi',
                                style: textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 24,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Text(
                              Konstan.tag_pdf_data_pribadi,
                              style: textTheme.bodyMedium!
                                  .copyWith(color: Colors.black54),
                            ),
                          )
                        ],
                      )
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
                        'Penting untuk Diketahui',
                        style: textTheme.titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                        thickness: 1.5,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        Konstan.tag_disclaimer_data_pribadi,
                        style: textTheme.bodyMedium!.copyWith(color: Colors.black54),
                      ),
                    ],
                  ))
                ],
              ),
          )),
    );
  }

  Widget _buildRow(String label, String value, TextTheme textTheme) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        label,
        style: textTheme.bodyMedium!
            .copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
      ),
      Text(
        value,
        style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
      )
    ]);
  }
}
