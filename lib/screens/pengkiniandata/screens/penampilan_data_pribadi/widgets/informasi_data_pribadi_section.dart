import 'package:flutter/material.dart';

import '../../../../../custom/container_menu.dart';
import '../state.dart';

class InformasiDataPribadiSection extends StatelessWidget {
  const InformasiDataPribadiSection(
      {super.key, required this.textTheme, required this.state});

  final TextTheme textTheme;
  final PenampilanDataPribadiState state;

  @override
  Widget build(BuildContext context) {
    return ContainerMenu(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi Data Pribadi Anda',
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(
          thickness: 1.5,
        ),
        const SizedBox(
          height: 12,
        ),
        _buildRow('Nama Lengkap', state.dummyData['nama'], textTheme),
        const SizedBox(
          height: 12,
        ),
        _buildRow('Nomor ID', state.dummyData['id'].toString(), textTheme),
        const SizedBox(
          height: 12,
        ),
        _buildRow('Tempat, Tanggal Lahir',
            state.dummyData['tempatTanggalLahir'], textTheme),
        const SizedBox(
          height: 12,
        ),
        _buildRow(
            'Alamat Sesuai ID', state.dummyData['alamatSesuaiId'], textTheme),
        const SizedBox(
          height: 12,
        ),
        _buildRow(
            'Alamat Domisili', state.dummyData['alamatDomisili'], textTheme),
        const SizedBox(
          height: 12,
        ),
        _buildRow('Nomor Telepon', state.dummyData['nomorTelepon'], textTheme),
        const SizedBox(
          height: 12,
        ),
        _buildRow('Nomor Kontrak', state.dummyData['nomorKontrak'], textTheme),
      ],
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
