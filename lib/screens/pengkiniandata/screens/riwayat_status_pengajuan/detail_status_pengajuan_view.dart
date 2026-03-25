import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/riwayat_status_pengajuan/widgets/row_detail_permintaan.dart';

import '../../../../custom/container_menu.dart';
import '../../../../helper/Fungsi.dart';
import 'logic.dart';

class DetailStatusPengajuan extends StatelessWidget {
  const DetailStatusPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final pengajuanDetail = Get.arguments;
    String tanggalPengkinian =
        Fungsi.formatTanggalOnly(pengajuanDetail.createDate);

    final RiwayatStatusPengajuanLogic logic =
        Get.put(RiwayatStatusPengajuanLogic());

    return JmcareBarScreen(
      title: 'Detail Riwayat Status',
      body: Obx(
        () => logic.is_loading.value
            ? Komponen.getLoadingWidget()
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
                          'Detail Permintaan',
                          style: textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        RowDetailPermintaan(
                            label: 'ID Pengajuan',
                            value: pengajuanDetail.noTiket),
                        const SizedBox(
                          height: 12,
                        ),
                        RowDetailPermintaan(
                          label: 'Tipe Pengajuan',
                          value: pengajuanDetail.jenisPerubahanData ==
                                  'Penghapusan Data Pribadi'
                              ? pengajuanDetail.jenisPerubahanData ?? '-'
                              : 'Pengkinian ${pengajuanDetail.jenisPerubahanData}',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        RowDetailPermintaan(
                            label: 'Tanggal Pengajuan',
                            value: tanggalPengkinian),
                        const SizedBox(
                          height: 12,
                        ),
                        RowDetailPermintaan(
                            label: 'Status Pengajuan',
                            value: pengajuanDetail.status),
                        const SizedBox(
                          height: 12,
                        ),
                        RowDetailPermintaan(
                          label: 'Keterangan',
                          value: pengajuanDetail.keterangan,
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
                          'Unggahan Dokumen',
                          style: textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (pengajuanDetail.jenisPerubahanData ==
                            'Nama Lengkap') ...[
                          _buildDokumenSection(
                              'Dokumen KTP',
                              textTheme,
                              () =>
                                  logic.previewFileKtp(pengajuanDetail.idPdp)),
                          _buildDokumenSection('Dokumen KK', textTheme,
                              () => logic.previewFileKk(pengajuanDetail.idPdp)),
                          _buildDokumenSection(
                              'Surat Putusan Pengadilan',
                              textTheme,
                              () => logic
                                  .previewFilePendukung(pengajuanDetail.idPdp)),
                        ] else if (pengajuanDetail.jenisPerubahanData ==
                                'Alamat KTP' ||
                            pengajuanDetail.jenisPerubahanData ==
                                'Alamat Domisili') ...[
                          _buildDokumenSection(
                              'Dokumen KTP',
                              textTheme,
                              () =>
                                  logic.previewFileKtp(pengajuanDetail.idPdp)),
                          _buildDokumenSection(
                              'Dokumen BKR',
                              textTheme,
                              () => logic
                                  .previewFilePendukung(pengajuanDetail.idPdp)),
                        ] else ...[
                          _buildDokumenSection(
                              'Dokumen Pendukung',
                              textTheme,
                              () => logic
                                  .previewFilePendukung(pengajuanDetail.idPdp)),
                        ],
                      ],
                    ))
                  ],
                ),
              ),
      ),
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
