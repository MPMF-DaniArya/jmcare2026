import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/model/api/EpolisRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart';
import 'package:jmcare/model/sqlite/entity/EContract.dart';
import 'package:jmcare/model/sqlite/entity/Epolis.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pilihkontrak/state.dart';
import 'package:jmcare/service/DownloadepolisService.dart';
import 'package:jmcare/service/EContractdownloadService.dart';
import 'package:jmcare/service/EpolisService.dart';
import 'package:jmcare/service/JumlahdownloadService.dart';
import 'package:jmcare/service/PilihkontrakService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/SubmitlogdownloadService.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../helper/Konstan.dart';
import '../../model/api/BaseRespon.dart';
import '../../service/klaimasuransi/CheckclaimavailableService.dart';

class PilihkontrakLogic extends BaseLogic {
  final PilihkontrakState state = PilihkontrakState();
  var pilihKontrak = PilihkontrakRespon().obs;
  var realKontrak = PilihkontrakRespon();
  var jmlRow = 0.obs;
  var is_download = false.obs;
  var obsLoadJumlahDownload = false.obs;

  @override
  void onInit() {
    super.onInit();
    askPermission();
    //get argumen dari screen sebelumnya
    state.rute = Get.arguments['detail'];
    getListKontrak();
    var a = state.databaseHelper?.getEpolis();
    a?.then((value) {
      state.jmlEpolis = value.length;
      debugPrint('jml epolis ' + value.length.toString());
    });
  }

  void askPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.location,
      Permission.storage,
      Permission.notification,
      Permission.scheduleExactAlarm
    ].request();
  }

  void detail(int index) {
    switch (state.rute) {
      case Konstan.rute_agreement_card:
        Get.toNamed(Konstan.rute_agreement_card,
            arguments: {'detail': pilihKontrak.value.data![index].aGRMNTID});
        break;

      case Konstan.rute_epolis:
        getEpolis(index);
        break;

      case Konstan.rute_klaim_asuransi:
        checkClaimAvailable(index);
        break;

      case Konstan.rute_eContract:
        getEContract(index);
        break;
    }
  }

  //ini fungsi buat menu klaim asuransi
  //cek dulu apakah nomor kontrak yang dipilih
  //masih bisa klaim asuransi atau tidak
  //sebab kalau sudah pernah klaim asuransi dan diAPPROVE
  //udah ga bisa klaim lagi
  void checkClaimAvailable(int index) async {
    is_loading.value = true;
    final respon = await getService<CheckclaimavailableService>()
        ?.checkClaimAvailable(pilihKontrak.value.data![index].aGRMNTNO!);
    if (respon is BaseError || respon == null) {
      Fungsi.koneksiError();
    } else {
      if (respon.code == "200") {
        Get.offAndToNamed(Konstan.rute_klaimasuransi_detail_agreementinsco,
            arguments: {
              Konstan.tag_detail: pilihKontrak.value.data![index].aGRMNTNO,
              Konstan.tag_branch_name:
                  pilihKontrak.value.data![index].oFFICENAME
            });
      } else {
        Fungsi.errorToast(respon.message!);
      }
    }
    is_loading.value = false;
  }

  void getEContract(int index) async {
    try {
      is_download.value = true;
      await initializeDateFormatting('id_ID', null);
      //dialog untuk permission storage'
      // var statusStorage = await Permission.storage.request();
      final usiaGoLive = pilihKontrak.value.data![index].uSIAGOLIVE;
      final no_kontrak = pilihKontrak.value.data![index].aGRMNTNO;
      //tujuan dibuat var 'clean_no_kontrak' ini adalah untuk menghilangkan karakter spt / - , .
      //karena kalau var no_kontrak disimpan di sqlite
      //dan mengandung karakter / - , .
      //akan error, jadi harus simpan yang clean
      final cleanNoKontrak = no_kontrak!
          .replaceAll("/", "")
          .replaceAll(".", "")
          .replaceAll(Konstan.tag_strip, "")
          .replaceAll(",", "")
          .replaceAll(" ", "");
      // final String agreementNo = pilihKontrak.value.data![index].aGRMNTNO!;
      final authStorage = await getStorage<LoginRespon>();
      final String login_id = authStorage.data!.loginUserId!;
      int? jumlah;
      //cek apakah sudah pernah download eContract atau belum
      debugPrint("is_android");
      jumlah = await state.databaseHelper!.selectEContract(cleanNoKontrak);
      //jika tidak ada datanya di sqlite
      if (jumlah == 0) {
        debugPrint("belum pernah download");
        //sebelum hit API, cek dulu di folder Download, sudah ada filenya atau belum?
        //karena ada case: dia sudah download eAgreement, lalu uninstal jmcare
        //dia lalu instal jmcare lagi, pas di bagian ini dia error
        Directory? dir;
        if (Platform.isAndroid) {
          dir = Directory('/storage/emulated/0/Download/');
        } else {
          dir = await getApplicationDocumentsDirectory();
        }
        // final file_yang_sdh_ada = '/storage/emulated/0/Download/$no_kontrak' + '.pdf';
        if (usiaGoLive!.toLowerCase() == "available") {
          //kalau available, cek apakah sudah 3x download ini
          obsLoadJumlahDownload.value = true;
          final jumlah = await getService<JumlahdownloadService>()!
              .getJumlahDownload(
                  int.parse(login_id!), no_kontrak!, "eContract");
          obsLoadJumlahDownload.value = false;
          if (jumlah == null) {
            Fungsi.koneksiError();
          } else {
            if (jumlah.code == Konstan.tag_200) {
              //disable untuk maksimal 3x download
              //download dokumen EContract dari Google Cloud Platform
              obsLoadJumlahDownload.value = true;
              final hasil = await getService<EContractdownloadService>()!
                  .downloadDocument(no_kontrak);
              obsLoadJumlahDownload.value = false;
              if (hasil == null) {
                Fungsi.koneksiError();
                //kalau download error, arahkan ke form keluhan
                Get.toNamed(Konstan.rute_eContract, arguments: {
                  Konstan.tag_detail: pilihKontrak.value.data![index].aGRMNTNO
                });
              } else {
                //disini dia sukses dapat link
                if (hasil.code == Konstan.tag_200) {
                  var dt = DateTime.now().millisecondsSinceEpoch;
                  final String suffix = dt.toString();
                  // final String namaFile = "Econtract-$suffix.pdf";
                  String namaFile = "$no_kontrak.pdf";
                  debugPrint("msgg_ ${hasil.message!}");
                  if (hasil.message == null) {
                    Get.toNamed(Konstan.rute_eContract, arguments: {
                      Konstan.tag_detail:
                          pilihKontrak.value.data![index].aGRMNTNO
                    });
                    Fungsi.errorToast("File tidak tersedia!");
                    //kalau API download eContract sukses, tapi di Google Platform-nya error
                    //arahkan ke formulir keluhan
                  } else {
                    //disini dia sukses dapat link
                    //cek apakah ios atau android
                    if (Platform.isIOS) {
                      var time = DateTime.now().millisecondsSinceEpoch;
                      var dir = await getApplicationDocumentsDirectory();
                      var path = "${dir.path}/eContract-$time.pdf";
                      var file = File(path);
                      //download eContract di IOS
                      try {
                        var res = await Dio().download(hasil.message!, path);
                        Fungsi.suksesToast(
                            "File berhasil diunduh. Periksa di folder JMCare");
                        Get.toNamed(Konstan.rute_pdf_view,
                            arguments: {'detail': path});
                        //kalau download sukses, hit API submit download
                        //biar row nambah, soalnya kalau sudah 3x, ga bisa download lagi
                        obsLoadJumlahDownload.value = true;
                        final tambah =
                            await getService<SubmitlogdownloadService>()!
                                .submitLogDownload(int.parse(login_id),
                                    no_kontrak, "eContract");
                        obsLoadJumlahDownload.value = false;
                      } catch (e) {
                        Fungsi.errorToast("Terjadi error download file");
                        Get.toNamed(Konstan.rute_eContract, arguments: {
                          Konstan.tag_detail:
                              pilihKontrak.value.data![index].aGRMNTNO
                        });
                      }
                    } else {
                      //download eContract di Android
                      namaFile = "$no_kontrak" + "_" + suffix + ".pdf";
                      debugPrint("ganti_file " + namaFile);
                      final angka = await getService<DownloadepolisService>()!
                          .downloadEAgreement(
                              hasil.message!, namaFile, no_kontrak);
                      //simpan file URL di storage
                      Directory? dir;
                      try {
                        dir = Directory(
                            '/storage/emulated/0/Download/'); // for android
                        if (!await dir.exists()) {
                          dir = (await getExternalStorageDirectory())!;
                        }
                        //simpan nomor agreement di sqlite
                        saveEcontract(cleanNoKontrak,
                            "/storage/emulated/0/Download/$namaFile");
                        //preview PDF
                        Get.toNamed(Konstan.rute_pdf_view, arguments: {
                          'detail': '/storage/emulated/0/Download/$namaFile'
                        });
                        //kalau download sukses, hit API submit download
                        //biar row nambah, soalnya kalau sudah 3x, ga bisa download lagi
                        obsLoadJumlahDownload.value = true;
                        final tambah =
                            await getService<SubmitlogdownloadService>()!
                                .submitLogDownload(int.parse(login_id),
                                    no_kontrak, "eContract");
                        obsLoadJumlahDownload.value = false;
                        debugPrint('try opening file...');
                      } catch (err) {
                        Fungsi.errorToast(
                            "Gagal mendapatkan path folder: $err");
                        Get.toNamed(Konstan.rute_eContract, arguments: {
                          Konstan.tag_detail:
                              pilihKontrak.value.data![index].aGRMNTNO
                        });
                      }
                      // if (angka == 0){
                      //   Fungsi.warningToast("Nomor kontrak yang Anda pilih belum tersedia file e-Contract. Silakan menghubungi customer service atau mengisi form ini.");
                      //   Get.toNamed(Konstan.rute_eContract, arguments: {Konstan.tag_detail: pilihKontrak.value.data![index].aGRMNTNO});
                      // }else{
                      //
                      // }
                    }
                  }
                } else {
                  Fungsi.errorToast(hasil.message!);
                  Get.toNamed(Konstan.rute_eContract, arguments: {
                    Konstan.tag_detail: pilihKontrak.value.data![index].aGRMNTNO
                  });
                }
              }
            } else {
              Fungsi.errorToast(jumlah.message!);
            }
          }
        } else {
          if (usiaGoLive == "lebih dari 90 hari") {
            Get.toNamed(Konstan.rute_layanan_pengaduan);
            Fungsi.warningToast(
                "Nomor kontrak yang Anda pilih sudah lebih dari 90 hari dari tanggal golive. Silakan isi form kritik & saran / pengaduan berikut.");
          } else {
            Fungsi.warningToast(usiaGoLive);
          }
        }
      } else {
        // Fungsi.suksesToast("File sudah ada di folder Download!");
        //berarti sudah ada datanya di sqlite, jadi cari dulu pathnya
        var filepath =
            await state.databaseHelper!.getFilepathEContract(cleanNoKontrak);
        //cek dulu apakah file fisik ada di path tersebug
        if (File(filepath).existsSync()) {
          //kalau ada, langsung open filenya di preview PDF
          debugPrint('filepath $filepath');
          debugPrint('try opening file...');
          Get.toNamed(Konstan.rute_pdf_view, arguments: {'detail': filepath});
        } else {
          //kalau tidak ada, otomatis download file lagi
          //disable jumlah download maksimal 3x
          //hit api untuk mengetahui berapa kali download file ini
          obsLoadJumlahDownload.value = true;
          final jumlah = await getService<JumlahdownloadService>()!
              .getJumlahDownload(int.parse(login_id), no_kontrak!, "eContract");
          obsLoadJumlahDownload.value = false;
          if (jumlah == null) {
            Fungsi.koneksiError();
          } else {
            if (jumlah.code == Konstan.tag_200) {
              //disable maksimal 3x download....
              //download dokumen EContract dari Google Cloud Platform
              obsLoadJumlahDownload.value = true;
              final hasil = await getService<EContractdownloadService>()!
                  .downloadDocument(no_kontrak);
              obsLoadJumlahDownload.value = false;
              if (hasil == null) {
                Fungsi.koneksiError();
                //kalau download error, arahkan ke form keluhan
                Get.toNamed(Konstan.rute_eContract, arguments: {
                  Konstan.tag_detail: pilihKontrak.value.data![index].aGRMNTNO
                });
              } else {
                if (hasil.code == Konstan.tag_200) {
                  final String namaFile = "$no_kontrak.pdf";
                  debugPrint("msgg_ ${hasil.message!}");
                  if (hasil.message == null) {
                    Get.toNamed(Konstan.rute_eContract, arguments: {
                      Konstan.tag_detail:
                          pilihKontrak.value.data![index].aGRMNTNO
                    });
                    Fungsi.errorToast("File tidak tersedia!");
                    //kalau API download eContract sukses, tapi di Google Platform-nya error
                    //arahkan ke formulir keluhan
                  } else {
                    //ini kalau hit api sukses, dapat link
                    if (Platform.isIOS) {
                      var time = DateTime.now().millisecondsSinceEpoch;
                      var dir = await getApplicationDocumentsDirectory();
                      var path = "${dir.path}/eContract-$time.pdf";
                      var file = File(path);
                      //download eContract di IOS
                      try {
                        var res = await Dio().download(hasil.message!, path);
                        Fungsi.suksesToast(
                            "File berhasil diunduh. Periksa di folder JMCare");
                        Get.toNamed(Konstan.rute_pdf_view,
                            arguments: {'detail': path});
                        //kalau download sukses, hit API submit download
                        //biar row nambah, soalnya kalau sudah 3x, ga bisa download lagi
                        obsLoadJumlahDownload.value = true;
                        final tambah =
                            await getService<SubmitlogdownloadService>()!
                                .submitLogDownload(int.parse(login_id),
                                    no_kontrak, "eContract");
                        obsLoadJumlahDownload.value = false;
                      } catch (e) {
                        Fungsi.errorToast("Terjadi error download file");
                        Get.toNamed(Konstan.rute_eContract, arguments: {
                          Konstan.tag_detail:
                              pilihKontrak.value.data![index].aGRMNTNO
                        });
                      }
                    } else {
                      //download eContract di Android
                      final angka = await getService<DownloadepolisService>()!
                          .downloadEAgreement(
                              hasil.message!, namaFile, no_kontrak);
                      if (angka == 0) {
                        Fungsi.warningToast(
                            "Nomor kontrak yang Anda pilih belum tersedia file E-Contract. Silakan menghubungi customer service atau mengisi form ini.");
                        Get.toNamed(Konstan.rute_eContract, arguments: {
                          Konstan.tag_detail:
                              pilihKontrak.value.data![index].aGRMNTNO
                        });
                      } else {
                        //simpan file URL di storage
                        Directory? dir;
                        try {
                          dir = Directory(
                              '/storage/emulated/0/Download/'); // for android
                          if (!await dir.exists()) {
                            dir = (await getExternalStorageDirectory())!;
                          }
                          //simpan nomor agreement di sqlite
                          saveEcontract(cleanNoKontrak,
                              "/storage/emulated/0/Download/$namaFile");
                          //preview PDF
                          Get.toNamed(Konstan.rute_pdf_view, arguments: {
                            'detail': '/storage/emulated/0/Download/$namaFile'
                          });
                          //kalau download sukses, hit API submit download
                          //biar row nambah, soalnya kalau sudah 3x, ga bisa download lagi
                          obsLoadJumlahDownload.value = true;
                          final tambah =
                              await getService<SubmitlogdownloadService>()!
                                  .submitLogDownload(int.parse(login_id),
                                      no_kontrak, "eContract");
                          obsLoadJumlahDownload.value = false;
                        } catch (err) {
                          Fungsi.errorToast(
                              "Gagal mendapatkan path folder: $err");
                          Get.toNamed(Konstan.rute_eContract, arguments: {
                            Konstan.tag_detail:
                                pilihKontrak.value.data![index].aGRMNTNO
                          });
                        }
                      }
                    }
                  }
                } else {
                  Fungsi.errorToast(hasil.message!);
                  Get.toNamed(Konstan.rute_eContract, arguments: {
                    Konstan.tag_detail: pilihKontrak.value.data![index].aGRMNTNO
                  });
                }
              }
            } else {
              Fungsi.errorToast(jumlah.message!);
            }
          }
        }
      }
      is_download.value = false;
    } catch (e) {
      is_download.value = false;
      Fungsi.errorToast("Error download: $e");
    }
  }

  void getEpolis(int index) async {
    //dialog untuk permission storage
    // var status = await Permission.storage.request();
    // var statusManageExternalStorage = await Permission.manageExternalStorage.request();
    var statusStorage = await Permission.storage.request();
    // var statusAccessML = await Permission.accessMediaLocation.request();

    is_download.value = true;
    final String agreementNo = pilihKontrak.value.data![index].aGRMNTNO!;
    final authStorage = await getStorage<LoginRespon>();
    final String login_id = authStorage.data!.loginUserId!;
    int? jumlah;
    //cek apakah sudah pernah download epolis atau belum
    if (Platform.isAndroid) {
      jumlah = await state.databaseHelper!.selectEpolis(agreementNo);
      //jika belum pernah download
      if (jumlah == 0) {
        //download link api
        final epolis =
            await getService<EpolisService>()?.getEpolis(agreementNo, login_id);
        if (epolis is EpolisError || epolis == null) {
          Fungsi.errorToast("Gagal mendapatkan ePolis!");
        } else {
          var dt = DateTime.now().millisecondsSinceEpoch;
          final String suffix = dt.toString();
          final String namaFile = "Epolis-$suffix.pdf";
          if (epolis!.fileurl == null) {
            Fungsi.errorToast("File URL on JSON is null!");
          } else {
            if (Platform.isIOS) {
              var time = DateTime.now().millisecondsSinceEpoch;
              var dir = await getApplicationDocumentsDirectory();
              var path = "${dir.path}/epolis-$time.pdf";
              var file = File(path);
              var res = await Dio().download(epolis.fileurl!, path);
              Get.toNamed(Konstan.rute_pdf_view, arguments: {'detail': path});
              Fungsi.suksesToast(
                  "File berhasil diunduh. Periksa di folder JMCare");
            } else {
              await getService<DownloadepolisService>()!
                  .downloadEpolis(epolis.fileurl!, namaFile)
                  .then((value) async {
                Fungsi.suksesToast("File berhasil diunduh di folder Download!");
                //simpan file URL di storage
                Directory? dir;
                try {
                  if (Platform.isIOS) {
                    dir = await getApplicationDocumentsDirectory(); // for iOS
                  } else {
                    dir = Directory(
                        '/storage/emulated/0/Download/'); // for android
                    if (!await dir.exists())
                      dir = (await getExternalStorageDirectory())!;
                    //simpan nomor agreement di sqlite
                    saveSqlite(
                        agreementNo, "/storage/emulated/0/Download/$namaFile");
                    Get.toNamed(Konstan.rute_pdf_view, arguments: {
                      'detail': '/storage/emulated/0/Download/$namaFile'
                    });
                    debugPrint('try opening file...');
                  }
                } catch (err) {
                  Fungsi.errorToast("Gagal mendapatkan path folder: $err");
                }
              });
            }
          }
        }
      } else {
        Fungsi.suksesToast("File sudah ada di folder Download!");
        var filepath = await state.databaseHelper!.getFilepath(agreementNo);
        debugPrint('filepath $filepath');
        debugPrint('try opening file...');
        Get.toNamed(Konstan.rute_pdf_view, arguments: {'detail': filepath});
      }
    } else {
      final epolis =
          await getService<EpolisService>()?.getEpolis(agreementNo, login_id);
      var time = DateTime.now().millisecondsSinceEpoch;
      var dir = await getApplicationDocumentsDirectory();
      var path = "${dir.path}/epolis-$time.pdf";
      var file = File(path);
      var res = await Dio().download(epolis!.fileurl!, path);
      Get.toNamed(Konstan.rute_pdf_view, arguments: {'detail': path});
      Fungsi.suksesToast("File berhasil diunduh. Periksa di folder JMCare");
    }
    is_download.value = false;
  }

  void getListKontrak() async {
    is_loading.value = true;
    final authStorage = await getStorage<LoginRespon>();
    final String noKTP = authStorage.data!.noKtp!;
    final respon =
        await getService<PilihkontrakService>()?.getListKontrak(noKTP);
    if (respon == null) {
      Fungsi.errorToast("Tidak dapat menampilkan nomor kontrak!");
      jmlRow.value = 0;
    } else {
      if (respon is PilihkontrakError) {
        Fungsi.errorToast("Error : Tidak dapat menampilkan nomor kontrak!");
        jmlRow.value = 0;
      } else {
        pilihKontrak.value = respon;
        realKontrak.data = respon.data;
        jmlRow.value = realKontrak.data!.length;
      }
    }
    is_loading.value = false;
  }

  void filter() {
    if (state.tecSearch!.text.isEmpty || state.tecSearch!.text.length == 0) {
      pilihKontrak.value.data = realKontrak.data;
      jmlRow.value = realKontrak.data!.length;
    } else {
      var tmp = realKontrak.data;
      var filtered = tmp!
          .where((x) => x.aGRMNTNO!
              .toLowerCase()
              .contains(state.tecSearch!.text.toLowerCase()))
          .toList();
      pilihKontrak.value.data = filtered;
      jmlRow.value = pilihKontrak.value.data!.length;
    }
  }

  void saveSqlite(String agreementNo, String filepath) {
    DateTime now = DateTime.now();
    state.epolis = Epolis(
        agreement_no: agreementNo,
        filepath: filepath,
        create_date: now.millisecondsSinceEpoch.toString());
    state.databaseHelper!.insertEpolis(state.epolis!);
  }

  void saveEcontract(String agreementNo, String filepath) {
    DateTime now = DateTime.now();
    state.econtract = Econtract(
        agreement_no: agreementNo,
        filepath: filepath,
        create_date: now.millisecondsSinceEpoch.toString());
    state.databaseHelper!.insertEContract(state.econtract!);
  }
}
