import 'package:flutter/material.dart';

import '../../../../../custom/container_menu.dart';
import '../../../../../helper/Konstan.dart';
import '../../widgets/row_ketentuan_pengkinian.dart';

class ContainerKetentuanHapusData extends StatelessWidget {
  const ContainerKetentuanHapusData({
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
              'Ketentuan Penghapusan Data',
              style:
              textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(Konstan.tag_ketentuan_hapus_data,
                style: textTheme.bodyLarge),
            const SizedBox(
              height: 8,
            ),
            RowKetentuanPengkinian(
                ketentuan:
                'Penghapusan data bersifat permanen dan tidak dapat dibatalkan setelah disetujui.',
                textTheme: textTheme),
            const SizedBox(
              height: 8,
            ),
            RowKetentuanPengkinian(
                ketentuan:
                'Beberapa data mungkin harus disimpan karena kewajiban hukum atau peraturan.',
                textTheme: textTheme),
            const SizedBox(
              height: 8,
            ),
            RowKetentuanPengkinian(
                ketentuan:
                'Proses verifikasi identitas diperlukan untuk memastikan keamanan data Anda.',
                textTheme: textTheme),
            RowKetentuanPengkinian(
                ketentuan:
                'Permintaan akan diproses dalam waktu 3 hari kerja setelah verifikasi berhasil.',
                textTheme: textTheme),
            const SizedBox(
              height: 8,
            ),
            RowKetentuanPengkinian(
                ketentuan:
                'JACCS MPM Finance berhak melakukan penolakan permintaan apabila data tidak sesuai atau pengajuan bukan dilakukan oleh Subjek Data Pribadi sendiri.',
                textTheme: textTheme),
            const SizedBox(
              height: 8,
            ),
          ],
        ));
  }
}