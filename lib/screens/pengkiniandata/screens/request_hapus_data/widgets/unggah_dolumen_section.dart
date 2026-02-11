import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          SizedBox(
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.upload,
                    size: 24,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Pilih Dokumen",
                    style: textTheme.bodyMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
