import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jmcare/helper/Warna.dart';

class SecurityBlockerApp extends StatelessWidget {
  const SecurityBlockerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(FontAwesomeIcons.exclamationTriangle, color: Colors.red, size: 100),
              const SizedBox(height: 30),
              const Text(
                "Keamanan Perangkat Terdeteksi",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              const Text(
                "Mohon maaf, demi keamanan data Anda, aplikasi JM CARE tidak dapat dijalankan pada perangkat yang telah di-root, menggunakan emulator, atau memiliki Developer Mode aktif.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Warna.hijau1),
                onPressed: () => SystemNavigator.pop(),
                child: const Text("Tutup Aplikasi", style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}