import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_hapus_data/widgets/container_ketentuan_hapus_data.dart';
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

        final header = logic.headerPengajuan.value;
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
                        label: 'ID Pengajuan',
                        value: header.idPengajuan ?? '-'),
                    const SizedBox(height: 8),
                    RowDetailPermintaan(
                        label: 'Tipe Pengajuan',
                        value: header.tipePengajuan ?? '-'),
                    const SizedBox(height: 8),
                    RowDetailPermintaan(
                        label: 'Tanggal Pengajuan',
                        value: header.tanggalPengajuan ?? '-'),
                    const SizedBox(height: 8),
                    RowDetailPermintaan(
                        label: 'Status Pengajuan',
                        value: header.statusPengajuan ?? '-'),
                    const SizedBox(height: 8),
                    RowDetailPermintaan(
                        label: 'Keterangan', value: header.keterangan ?? '-'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              permintaanPerubahan.first.tipePerubahanData ==
                      'Penghapusan Data Pribadi'
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ContainerKetentuanHapusData(textTheme: textTheme),
                        const SizedBox(
                          height: 8,
                        ),
                        _buildDokumenSection(
                            'Dokumen Pendukung',
                            textTheme,
                            () => logic.previewFilePendukung(
                                permintaanPerubahan.first.id!)),
                      ],
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = permintaanPerubahan[index];

                        return Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: ContainerMenu(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Permintaan Perubahan #${index + 1}',
                                      style: textTheme.titleLarge!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                const Divider(thickness: 1.5),
                                const SizedBox(height: 12),
                                Align(
                                  alignment: AlignmentGeometry.centerLeft,
                                  child: Text('Jenis Data',
                                      style: textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  initialValue: item.jenisPerubahanData,
                                  readOnly: true,
                                  maxLines: 4,
                                  minLines: 1,
                                  style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black87),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 16),
                                    filled: true,
                                    fillColor: Get.isDarkMode
                                        ? const Color(0xFF353535)
                                        : Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Align(
                                  alignment: AlignmentGeometry.centerLeft,
                                  child: Text('Data Saat Ini',
                                      style: textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  initialValue: item.dataSaatIni,
                                  readOnly: true,
                                  maxLines: 4,
                                  minLines: 1,
                                  style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black87),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 16),
                                    filled: true,
                                    fillColor: Get.isDarkMode
                                        ? const Color(0xFF353535)
                                        : Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Align(
                                  alignment: AlignmentGeometry.centerLeft,
                                  child: Text('Perubahan Data',
                                      style: textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  initialValue: item.perubahanData,
                                  readOnly: true,
                                  maxLines: 4,
                                  minLines: 1,
                                  style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black87),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 16),
                                    filled: true,
                                    fillColor: Get.isDarkMode
                                        ? const Color(0xFF353535)
                                        : Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Divider(thickness: 1.5),
                                const SizedBox(
                                  height: 8,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Unggahan Dokumen',
                                      style: textTheme.titleMedium!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Unggahan dokumen sebagai bukti perubahan',
                                      style: textTheme.bodyMedium),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                if (item.jenisPerubahanData ==
                                    'Nama Lengkap') ...[
                                  _buildDokumenSection('Dokumen KTP', textTheme,
                                      () => logic.previewFileKtp(item.id!)),
                                  _buildDokumenSection('Dokumen KK', textTheme,
                                      () => logic.previewFileKk(item.id!)),
                                  _buildDokumenSection(
                                      'Dokumen Surat Putusan Pengadilan',
                                      textTheme,
                                      () =>
                                          logic.previewFilePendukung(item.id!)),
                                ] else if (item.jenisPerubahanData ==
                                        'Alamat Domisili' ||
                                    item.jenisPerubahanData ==
                                        'Alamat KTP') ...[
                                  _buildDokumenSection('Dokumen KTP', textTheme,
                                      () => logic.previewFileKtp(item.id!)),
                                  _buildDokumenSection(
                                      'Dokumen BKR',
                                      textTheme,
                                      () =>
                                          logic.previewFilePendukung(item.id!))
                                ] else if (item.jenisPerubahanData ==
                                        'Nomor Handphone' ||
                                    item.jenisPerubahanData ==
                                        'Alamat Email') ...[
                                  _buildDokumenSection(
                                      'Dokumen Pendukung',
                                      textTheme,
                                      () =>
                                          logic.previewFilePendukung(item.id!)),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                      itemCount: permintaanPerubahan.length)
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
