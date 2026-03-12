import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fungsi {
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static String formatNumberDouble(double number) {
    return Fungsi.thousandSeparator(int.parse(number.round().toString()));
  }

  static String splitNamaUser(String namaUser) {
    try {
      String hasil = "";
      var baru = namaUser.split(' ');
      if (baru.isEmpty) {
        hasil = namaUser;
      } else {
        if (baru.length == 1) {
          hasil = namaUser;
        } else {
          String namaDepan = baru.first;
          String namaBelakang = baru.last;
          namaBelakang = namaBelakang.substring(0, 1);
          hasil = "$namaDepan $namaBelakang";
        }
      }
      return hasil;
    } catch (e) {
      return namaUser;
    }
  }

  static warningToast(String message) {
    Get.snackbar(Konstan.tag_warning, '😢 $message',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.teal,
        icon: const Icon(
          Icons.warning_amber,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 3),
        forwardAnimationCurve: Curves.bounceInOut);
  }

  static suksesToast(String message) {
    Get.snackbar(Konstan.tag_sukses, '😊 $message',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.green,
        icon: const Icon(
          Icons.thumb_up_off_alt,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 3),
        forwardAnimationCurve: Curves.bounceInOut);
  }

  static errorToast(String message) {
    Get.snackbar(Konstan.tag_error, '🥹 $message',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 4),
        forwardAnimationCurve: Curves.bounceInOut);
  }

  static koneksiError() {
    errorToast("😢 Jaringan atau server mengalami kendala!");
  }

  static String generateOTP(int length) {
    const ch = '0123456789';
    Random r = Random();
    var hasil = String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
    return hasil;
  }

  static String bintang(String input) {
    String hasil = "";
    int panjang = input.length;
    int counter = 0;

    if (panjang == 0 || panjang == 1 || panjang == 2) {
      hasil = input;
    } else {
      if (panjang == 3 || panjang == 4) {
        counter = 0;
        input.runes.forEach((element) {
          if (counter == 0 || counter == panjang) {
            var c = String.fromCharCode(element);
            hasil += c;
          } else {
            hasil += "*";
          }
          counter += 1;
        });
      } else {
        counter = 0;
        input.runes.forEach((element) {
          if (counter == 0 ||
              counter == 1 ||
              counter == panjang - 1 ||
              counter == panjang - 2 ||
              counter == panjang - 3) {
            var c = String.fromCharCode(element);
            hasil += c;
          } else {
            hasil += "*";
          }
          counter += 1;
        });
      }
    }
    print("Hasil bintang " + hasil);
    return hasil;
  }

  static String enamDua(String nomorHP) {
    String hasil = "";
    if (nomorHP.isEmpty) {
      hasil = "";
    } else {
      if (nomorHP.startsWith("0")) {
        int panjang = nomorHP.length;
        String sisa = nomorHP.substring(1, panjang);
        hasil = "62" + sisa;
      } else {
        hasil = nomorHP;
      }
    }
    print("Hasil enamdua " + hasil);
    return hasil;
  }

  static bool passwordCalculator(String password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
    // RegExp numReg = RegExp(r".*[0-9].*");
    // RegExp letterReg = RegExp(r".*[A-Za-z].*");
    //
    // if (!letterReg.hasMatch(password) || !numReg.hasMatch(password)) {
    //   return false;
    // } else {
    //   return true;
    // }
  }

  static toastBelumLogin() {
    warningToast(Konstan.tag_belum_login);
  }

  static Future<void> cekFingerprint(BuildContext context) async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate) {
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (availableBiometrics.isNotEmpty) {
        debugPrint("available bio");
        try {
          final bool didAuthenticate = await auth.authenticate(
              localizedReason: 'Gunakan sidik jari sebagai alternatif PIN',
              options: const AuthenticationOptions(useErrorDialogs: false));
          if (didAuthenticate) {
            Navigator.popAndPushNamed(context, '/home');
          } else {
            warningToast("Silakan memasukkan PIN");
          }
        } on PlatformException catch (e) {
          errorToast(e.message.toString());
        }
      } else {
        debugPrint("not available bio");
      }
    }
  }

  static logOut(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
  }

  static Future<bool?> dialogLogout(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah Anda yakin akan logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static String formatTanggal(String tanggalYYYYmmdd) {
    try {
      var tgl = DateFormat("yyyy-MM-ddThh:mm:ss").parse(tanggalYYYYmmdd);
      var tgla = DateFormat('dd MMM yyyy hh:mm:ss').format(tgl);
      return tgla;
    } catch (e) {
      var tgl = DateFormat("dd-MM-yyyy hh:mm:ss").parse(tanggalYYYYmmdd);
      var tgla = DateFormat('dd MMM yyyy hh:mm:ss').format(tgl);
      return tgla;
    }
  }

  static String formatNumber(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static String thousandSeparator(int str) {
    var formatter = NumberFormat('##,##0');
    return formatter.format(str);
  }

  static bool isToday(String tgl) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tanggal = DateTime.parse(tgl);
    if (today == tanggal) {
      debugPrint("hari ini");
      return true;
    } else {
      debugPrint("bukan hari ini");
      return false;
    }
  }

  // fungsi untuk membuat kalimat format title case (Hanya huruf awal yang kapital)
  static String formatTitleCase(String? text) {
    if (text == null) return "-";

    String cleanText = text.replaceAll(RegExp(r'^[a-zA-Z0-9+]+\s*,\s*'), '');

    String checkEmpty = cleanText
        .replaceAll(RegExp(r'RT\s*/\s*RW'), '')
        .replaceAll('Kel.', '')
        .replaceAll('Kec.', '')
        .replaceAll(',', '')
        .replaceAll('-', '')
        .trim();

    if (checkEmpty.isEmpty) return "-";

    return cleanText.toLowerCase().split(' ').map((word) {
      String cleanWord = word.replaceAll(RegExp(r'[^\w]'), '');
      if (cleanWord == 'rt' || cleanWord == 'rw') return word.toUpperCase();

      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return word;
    }).join(' ');
  }

  static String formatTanggalOnly(String? tanggalDanWaktu) {
    DateFormat inputFormat = DateFormat("dd MMM yyyy HH:mm:ss");
    DateFormat outputFormat = DateFormat("dd MMM yyyy");

    String dateDisplay = "-";

    if (tanggalDanWaktu != null && tanggalDanWaktu.isNotEmpty) {
      try {
        // parse ke DateTime
        DateTime dateTime = inputFormat.parse(tanggalDanWaktu);
        // format ke String
        return dateDisplay = outputFormat.format(dateTime);
      } catch (e) {
        // jika format dari API tidak sesuai, tampilkan string aslinya atau '-'
        debugPrint("Error parsing date: $e");
        return dateDisplay = tanggalDanWaktu ?? "-";
      }
    } else {
      return dateDisplay = "-";
    }
  }

  // fungsi untuk membedakan ekstensi file berdasarkan magic bytes dari base64 file
  static String getFileExtension(Uint8List bytes) {
    // magic bytes untuk .pdf
    if (bytes[0] == 0x25 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x44 &&
        bytes[3] == 0x46) {
      return '.pdf';
    }

    // magic bytes untuk .jpg
    if (bytes[0] == 0xFF &&
        bytes[1] == 0xD8 &&
        bytes[2] == 0xFF) {
      return '.jpg';
    }

    return '.pdf';
  }
}
