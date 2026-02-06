import 'package:flutter/material.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/riwayat_status_pengajuan/widgets/row_detail_permintaan.dart';

import '../../../../custom/container_menu.dart';

class DetailStatusPengajuan extends StatelessWidget {
  const DetailStatusPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return JmcareBarScreen(
      title: 'Detail Riwayat Status',
      body: SingleChildScrollView(
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
                const RowDetailPermintaan(
                    label: 'ID Pengajuan', value: 'Contoh dulu'),
                const SizedBox(
                  height: 12,
                ),
                const RowDetailPermintaan(
                    label: 'Tipe Pengajuan', value: 'Contoh Dulu'),
                const SizedBox(
                  height: 12,
                ),
                const RowDetailPermintaan(
                    label: 'Tanggal Pengajuan', value: 'Contoh Dulu'),
                const SizedBox(
                  height: 12,
                ),
                const RowDetailPermintaan(
                    label: 'Status Pengajuan', value: 'Contoh Dulu'),
                const SizedBox(
                  height: 12,
                ),
                const RowDetailPermintaan(
                    label: 'Keterangan', value: 'Testing testing Testing testing Testing testing Testing testing'),
              ],
            )),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
