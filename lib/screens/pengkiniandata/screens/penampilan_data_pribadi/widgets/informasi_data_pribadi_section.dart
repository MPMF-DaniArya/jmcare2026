import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/logic.dart';

import '../../../../../custom/container_menu.dart';

class InformasiDataPribadiSection extends StatelessWidget {
  const InformasiDataPribadiSection({super.key, required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ContainerMenu(
        child: GetBuilder<PenampilanDataPribadiLogic>(
      assignId: true,
      builder: (logic) {
        final state = logic.state;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informasi Data Pribadi Anda',
              style:
                  textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(
              height: 12,
            ),
            _buildRow('Nama Lengkap', state.namaLengkapUser, textTheme),
            const SizedBox(
              height: 12,
            ),
            _buildRow('Nomor ID', state.nomorIdUser, textTheme),
            const SizedBox(
              height: 12,
            ),
            _buildRow('Tempat, Tanggal Lahir', state.tempatTanggalLahirUser,
                textTheme),
            const SizedBox(
              height: 12,
            ),
            _buildRow('Alamat Sesuai ID', state.dummyData['alamatSesuaiId'],
                textTheme),
            const SizedBox(
              height: 12,
            ),
            _buildRow('Alamat Domisili', state.alamatDomisiliUser, textTheme),
            const SizedBox(
              height: 12,
            ),
            _buildRow('Nomor Telepon', state.nomorTeleponUser, textTheme),
            const SizedBox(
              height: 12,
            ),
            _buildRow(
                'Nomor Kontrak', state.dummyData['nomorKontrak'], textTheme),
          ],
        );
      },
    ));
  }
}

Widget _buildRow(String label, String value, TextTheme textTheme) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 45,
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        )
      ]);
}
