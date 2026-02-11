import 'package:flutter/material.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_hapus_data/widgets/unggah_dolumen_section.dart';

import 'widgets/container_ketentuan_hapus_data.dart';

class RequestHapusDataScreen extends StatefulWidget {
  const RequestHapusDataScreen({super.key});

  @override
  State<RequestHapusDataScreen> createState() => _RequestHapusDataScreenState();
}

class _RequestHapusDataScreenState extends State<RequestHapusDataScreen> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return JmcareBarScreen(
      title: 'Permintaan Hapus',
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          ContainerKetentuanHapusData(textTheme: textTheme),
          const SizedBox(
            height: 16,
          ),
          UnggahDokumenSection(textTheme: textTheme),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Checkbox(
                value: _isAgreed,
                onChanged: (value) {
                  setState(() {
                    _isAgreed = value!;
                  });
                },
              ),
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Saya telah membaca dan menyetujui ',
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => print('Link Ditekan'),
                      child: Text(
                        "syarat dan ketentuan penghapusan data pribadi.",
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isAgreed ? () {} : null,
              child: Text(
                "Submit",
                style: textTheme.titleMedium!.copyWith(
                    fontWeight: _isAgreed ? FontWeight.bold : FontWeight.normal,
                    color: _isAgreed
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
