import 'package:flutter/material.dart';

import '../../../../../custom/container_menu.dart';
import '../../../../../helper/Konstan.dart';
import '../../widgets/row_ketentuan_pengkinian.dart';

class KetentuanPengkinianDataSection extends StatelessWidget {
  const KetentuanPengkinianDataSection({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ContainerMenu(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ketentuan Pengkinian Data',
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
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
            ketentuan: 'Permintaan akan diproses dalam waktu 3 hari kerja.',
            textTheme: textTheme),
        const SizedBox(
          height: 8,
        ),
        RowKetentuanPengkinian(
            ketentuan:
                'JACCS MPM Finance berhak melakukan penolakan permintaan apabila data/dokumen yang dicantumkan tidak sesuai, atau pengajuan tidak dilakukan oleh Subjek Data Pribadi sendiri.',
            textTheme: textTheme),
      ],
    ));
  }
}
