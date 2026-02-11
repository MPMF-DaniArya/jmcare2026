import 'package:flutter/material.dart';

import '../../../../../custom/container_menu.dart';
import '../../../../../helper/Konstan.dart';

class PentingUntukDiketahuiSection extends StatelessWidget {
  const PentingUntukDiketahuiSection({
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
              'Penting untuk Diketahui',
              style: textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(Konstan.tag_disclaimer_data_pribadi,
                style: textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.8))),
          ],
        ));
  }
}
