import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/riwayat_status_pengajuan/widgets/row_detail_permintaan.dart';

import '../../../../custom/container_menu.dart';

class DetailStatusPengajuan extends StatelessWidget {
  const DetailStatusPengajuan({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final pengajuanDetail = Get.arguments;

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
                RowDetailPermintaan(
                    label: 'ID Pengajuan', value: pengajuanDetail.id),
                const SizedBox(
                  height: 12,
                ),
                RowDetailPermintaan(
                    label: 'Tipe Pengajuan', value: pengajuanDetail.title),
                const SizedBox(
                  height: 12,
                ),
                RowDetailPermintaan(
                    label: 'Tanggal Pengajuan', value: pengajuanDetail.date),
                const SizedBox(
                  height: 12,
                ),
                RowDetailPermintaan(
                    label: 'Status Pengajuan', value: pengajuanDetail.status),
                const SizedBox(
                  height: 12,
                ),
                RowDetailPermintaan(
                  label: 'Keterangan',
                  value: pengajuanDetail.information,
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
                  'Ketentuan Penghapusan Data',
                  style: textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Divider(
                  thickness: 1.5,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
