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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Submit",
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
