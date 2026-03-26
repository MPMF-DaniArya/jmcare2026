import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/riwayat_status_pengajuan/detail_status_pengajuan/logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/riwayat_status_pengajuan/widgets/row_detail_permintaan.dart';

import '../../../../../custom/container_menu.dart';
import '../../../../../helper/Fungsi.dart';
import '../logic.dart';

class DetailStatusPengajuan extends StatelessWidget {
  const DetailStatusPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailStatusPengajuanLogic logic =
        Get.put(DetailStatusPengajuanLogic());
    final textTheme = Theme.of(context).textTheme;

    return JmcareBarScreen(
      title: 'Detail Riwayat Status',
      body: Obx(() {
        if (logic.is_loading.value) {
          return Komponen.getLoadingWidget();
        }

        final Map<String, dynamic> detail = Get.arguments;
        final permintaanPerubahan = logic.listPengajuanDetail;

        return SingleChildScrollView(
          child: Column(
            children: [
              ContainerMenu(
                child: Column(
                  children: [
                    Text('Detail Permintaan',
                        style: textTheme.titleLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const Divider(thickness: 1.5),
                    RowDetailPermintaan(
                        label: 'ID Pengajuan', value: detail['noTiket'] ?? '-'),
                    const SizedBox(height: 8,),
                    RowDetailPermintaan(
                      label: 'Tipe Pengajuan',
                      value: permintaanPerubahan[0].jenisPerubahanData ==
                              'Penghapusan Data Pribadi'
                          ? 'Penghapusan Data Pribadi'
                          : 'Pengkinian Data Pribadi',
                    ),
                    const SizedBox(height: 8,),
                    RowDetailPermintaan(
                        label: 'Tanggal Pengajuan',
                        value: detail['tanggalPengkinian'] ?? '-'),
                    const SizedBox(height: 8,),
                    RowDetailPermintaan(
                        label: 'Status Pengajuan',
                        value: detail['status'] ?? '-'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // ContainerMenu(
              //   child: Column(
              //     children: [
              //       Text('Unggahan Dokumen',
              //           style: textTheme.titleLarge!
              //               .copyWith(fontWeight: FontWeight.bold)),
              //       const Divider(thickness: 1.5),
              //       if (detail.jenisPerubahanData == 'Nama Lengkap') ...[
              //         _buildDokumenSection('Dokumen KTP', textTheme,
              //             () => logic.previewFileKtp(detail.idPdp!)),
              //         _buildDokumenSection('Dokumen KK', textTheme,
              //             () => logic.previewFileKk(detail.idPdp!)),
              //       ] else ...[
              //         _buildDokumenSection('Dokumen Pendukung', textTheme,
              //             () => logic.previewFilePendukung(detail.idPdp!)),
              //       ],
              //     ],
              //   ),
              // )
            ],
          ),
        );
      }),
    );
  }
}

Widget _buildDokumenSection(
    String label, TextTheme textTheme, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.titleMedium),
        const SizedBox(height: 8),
        ButtonDokumen(
          textTheme: textTheme,
          onPressed: onTap,
        ),
      ],
    ),
  );
}

class ButtonDokumen extends StatelessWidget {
  const ButtonDokumen(
      {super.key, required this.textTheme, required this.onPressed});

  final TextTheme textTheme;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10)),
            backgroundColor: Colors.green),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.fileLines,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              'Lihat Dokumen',
              style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            )
          ],
        ));
  }
}
