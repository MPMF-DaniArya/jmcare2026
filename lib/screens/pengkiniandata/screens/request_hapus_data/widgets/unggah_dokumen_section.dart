import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Warna.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_hapus_data/logic.dart';

import '../../../../../custom/container_menu.dart';

class UnggahDokumenSection extends StatelessWidget {
  const UnggahDokumenSection({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ContainerMenu(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.upload,
            size: 50,
            color: Colors.green,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Unggah Dokumen Pendukung (Opsional)',
            style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Jika anda memiliki dokumen pendukung terkait permintaan penghapusan, unggah di sini. Maksimum 5MB, format PDF atau JPG.',
            style: textTheme.bodyMedium!.copyWith(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          buttonUploadDokumen(textTheme)
        ],
      ),
    );
  }

  Widget buttonUploadDokumen(TextTheme theme) {
    return GetBuilder<RequestHapusDataLogic>(
      builder: (logic) => logic.state.lampiran != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.insert_drive_file_outlined),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Text(
                          logic.state.lampiran!.files.single.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ))
                      ],
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        logic.state.lampiran = null;
                        logic.update();
                      }),
                ],
              ),
            )
          : SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                onPressed: () => logic.pickFile(),
                icon: const Icon(
                  Icons.upload_sharp,
                  color: Colors.white,
                ),
                label: Text(
                  'Pilih Dokumen',
                  style: textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Warna.hijau1,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
    );
  }
}
