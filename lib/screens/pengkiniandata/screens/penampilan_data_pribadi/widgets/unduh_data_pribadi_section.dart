import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/penampilan_data_pribadi/widgets/unduh_pdf_data_pribadi_screen.dart';

import '../../../../../custom/container_menu.dart';
import '../../../../../helper/Konstan.dart';

class UnduhDataPribadiSection extends StatelessWidget {
  const UnduhDataPribadiSection({super.key, required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ContainerMenu(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Unduh Data Pribadi',
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(
          thickness: 1.5,
        ),
        const SizedBox(
          height: 12,
        ),
        ElevatedButton(
            onPressed: () => Get.toNamed(Konstan.rute_unduh_pdf_data_pribadi),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.download),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  'Unduh PDF Data Pribadi',
                  style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        const SizedBox(
          height: 12,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline,
              size: 24,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                Konstan.tag_pdf_data_pribadi,
                style: textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.8)),
              ),
            )
          ],
        )
      ],
    ));
  }
}
