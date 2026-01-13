import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';

class DetailNotifikasiView extends StatelessWidget {
  const DetailNotifikasiView({super.key});


  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;

    return JmcareBarScreen(
      title: 'Notifikasi',
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
             data.judulNotif ?? 'Tidak ada Judul', textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(height: 8,),
            Text(
             data.isi ?? 'Tidak ada isi', textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8,),
            Text(
             data.createDate ?? 'Tidak ada tanggal',
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey),
            )
          ],
        ),
      )),
    );
  }
}
