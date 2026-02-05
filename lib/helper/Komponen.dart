import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/helper/Warna.dart';
import 'package:jmcare/model/api/AgreementcardRespon.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart' as pilihkontrak;
import 'package:jmcare/model/api/AgreementinscoRespon.dart' as agrmntInsco;
import 'package:jmcare/model/api/ProdukRespon.dart';
import 'package:jmcare/model/api/PromoRespon.dart';
import 'package:jmcare/model/api/RiwayatantrianRespon.dart' as riwayatantrian;
import 'package:jmcare/model/api/AntriansekarangRespon.dart' as antriansekarang;
import 'package:get/get.dart';
import 'dart:math' as math show sin, pi, sqrt;
import 'package:flutter/animation.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart' as la;
import 'package:jmcare/model/api/FormawalRespon.dart' as far;

class Komponen {
  static Widget teksPDK() {
    return const Text(
        "JACCS MPM Finance Indonesia berkomitmen untuk melindungi data dan/atau informasi milik pemohon serta tidak akan melakukan perubahan, penambahan, menyalin atau memberikan informasi/data pemohon kepada pihak lain selain pihak yang diizinkan dan/atau pihak-pihak yang dinyatakan dengan tegas dalam Pernyataan Pemohon. Ringkasan Kebijakan Perlindungan Data Pribadi secara lengkap dapat diakses di website JACCS MPM Finance Indonesia pada alamat www.jaccs-mpmfinance.com.",
        textAlign: TextAlign.center);
  }

  static Widget astericText(String label) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: "* ",
            style: TextStyle(color: Colors.red),
          ),
          TextSpan(text: label),
        ],
      ),
      style: const TextStyle(fontSize: 12),
    );
  }

  static Widget getNoInternet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/nowifi.png", height: 50, width: 50),
        const Text("JARINGAN OFFLINE")
      ],
    );
  }

  static Widget getCardRiwayatFormawal(
      far.FormawalRespon data,
      int index,
      Function klikFormKlaim,
      Function klikUploadDokumen,
      Function klikLihatSurat) {
    double diameterLingkaran = 30;
    Color warnaLingkaran = Warna.orange2;
    Color warnaGrey = Warna.greyMuda;
    int levelStatusKlaim = 0;
    switch (data.data![index].statusKlaim) {
      case Konstan.tag_status_klaim_new:
        levelStatusKlaim = 1;
        break;
      case Konstan.tag_status_klaim_rjc:
        levelStatusKlaim = 1;
        break;
      case Konstan.tag_status_klaim_return:
        levelStatusKlaim = 1;
        break;
      case Konstan.tag_status_klaim_req:
        levelStatusKlaim = 2;
        break;
      case Konstan.tag_status_klaim_apv:
        levelStatusKlaim = 2;
        break;
      case Konstan.tag_status_klaim_insco_apv:
        levelStatusKlaim = 3;
        break;
      case Konstan.tag_status_klaim_apv_grc:
        levelStatusKlaim = 3;
        break;
      case Konstan.tag_status_klaim_decision_rjc:
        levelStatusKlaim = 3;
        break;
      case Konstan.tag_status_klaim_vrf:
        levelStatusKlaim = 4;
        break;
      case Konstan.tag_status_klaim_fin:
        levelStatusKlaim = 5;
        break;
    }

    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Column(
            children: [
              data.data![index].noRegistrasi! == ""
                  ? const Text("-")
                  : Text(
                      data.data![index].noRegistrasi!,
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
              Text(
                data.data![index].createDate!,
                style: const TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                  onPressed: () {
                    klikFormKlaim();
                  },
                  child: const Text("FORM KLAIM")),
              const Padding(padding: EdgeInsets.only(left: 5)),
              OutlinedButton(
                  onPressed: () {
                    klikUploadDokumen();
                  },
                  child: const Text("UPLOAD DOKUMEN"))
            ],
          ),
          Table(
            border: TableBorder.all(color: Colors.green, width: 0.5),
            children: <TableRow>[
              TableRow(children: <Widget>[
                const Padding(
                    padding: EdgeInsets.all(5), child: Text("Nomor kontrak")),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(data.data![index].agreementNo!)),
              ]),
              TableRow(children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Nomor tertanggung"),
                ),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(data.data![index].namaTertanggung!)),
              ]),
              TableRow(children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Nomor polis asuransi"),
                ),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(data.data![index].nomorPolisAsuransi!)),
              ]),
              TableRow(children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Tanggal kejadian"),
                ),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(data.data![index].tglKejadian!)),
              ]),
              TableRow(children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Jenis klaim"),
                ),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(data.data![index].rEASONDESCR!)),
              ]),
              TableRow(children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Surat keputusan"),
                ),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: (data.data![index].statusKlaim ==
                            Konstan.tag_status_klaim_insco_apv)
                        ? TextButton(
                            onPressed: () {
                              klikLihatSurat();
                            },
                            child: const Text("Lihat surat"))
                        : (data.data![index].statusKlaim ==
                                Konstan.tag_status_klaim_decision_rjc)
                            ? TextButton(
                                onPressed: () {
                                  klikLihatSurat();
                                },
                                child: const Text("Lihat surat"))
                            : data.data![index].statusKlaim ==
                                    Konstan.tag_status_klaim_rjc
                                ? const Text("REJECTED")
                                : const Text("TIDAK TERSEDIA")),
              ]),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          Stack(
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 8, left: 30, right: 30),
                  child: Divider(color: Warna.greyMuda)),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: diameterLingkaran,
                          height: diameterLingkaran,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            color: levelStatusKlaim <= 0
                                ? warnaGrey
                                : warnaLingkaran,
                          )),
                      const Text(
                        "Laporan\nAwal\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: diameterLingkaran,
                          height: diameterLingkaran,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            color: levelStatusKlaim <= 1
                                ? warnaGrey
                                : warnaLingkaran,
                          )),
                      const Text(
                        "Form\nKlaim\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: diameterLingkaran,
                          height: diameterLingkaran,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            color: levelStatusKlaim <= 2
                                ? warnaGrey
                                : warnaLingkaran,
                          )),
                      const Text(
                        "Insco\nApproval\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: diameterLingkaran,
                          height: diameterLingkaran,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            color: levelStatusKlaim <= 3
                                ? warnaGrey
                                : warnaLingkaran,
                          )),
                      const Text(
                        "Verifikasi\nDokumen\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: diameterLingkaran,
                          height: diameterLingkaran,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            color: levelStatusKlaim <= 4
                                ? warnaGrey
                                : warnaLingkaran,
                          )),
                      const Text(
                        "Pencairan\n\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  static Widget homeButtonMenu(IconData ic, Color warna1, Color warna2,
      String teksMenu, Function onKlik) {
    return InkWell(
        onTap: () {
          onKlik();
        },
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [warna1, warna1, warna2])),
              child: Icon(
                ic,
                size: 20,
                color: Colors.white,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Text(
              teksMenu.replaceAll(" ", "\n"),
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ));
  }

  static Widget pullDowntoRefresh() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.refresh,
          color: Colors.green,
        ),
        Text(
          "Tarik ke bawah untuk menampilkan data",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  static Widget getCardOption(
      {required String title,
      required String subtitle,
      required int radioValue,
      required int groupValue,
      required Function changeGroupValue}) {
    return Card(
      elevation: 4,
      child: Row(
        children: [
          Radio(
            value: radioValue,
            groupValue: groupValue,
            onChanged: (value) {
              changeGroupValue();
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }

  static Widget getLogoHijau() {
    return Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 100),
            child: Image.asset("assets/images/jmcare_hijau.png")));
  }

  static AppBar getAppBar(BuildContext context, String title,
      [PreferredSizeWidget? bottomTab]) {
    return AppBar(
      bottom: bottomTab,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.green,
              Warna.hijau,
            ])),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  static AppBar getAppBarEsign(BuildContext context, String title,
      [PreferredSizeWidget? bottomTab]) {
    return AppBar(
      bottom: bottomTab,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.blue,
              Color.fromARGB(255, 11, 116, 229),
            ])),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  static Widget getMainDrawer(
      BuildContext context, Function onLogout, Function onDeleteAccount) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
      child: ListView(
        children: [
          Container(
              height: 200,
              decoration: const BoxDecoration(
                  color: Warna.hijau,
                  image: DecorationImage(
                      filterQuality: FilterQuality.low,
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/drawer_bg.png"))),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 180,
                          height: 80,
                          child: Card(
                              elevation: 12.0,
                              color: Colors.white,
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                      "assets/images/ic_logo_jaccs.png"))))),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          )))
                ],
              )),
          ListTile(
            // tileColor: Colors.white,
            title: const Text('Logout'),
            onTap: () {
              onLogout();
            },
          ),
          ListTile(
            // tileColor: Colors.white,
            title: const Text('Hapus akun'),
            onTap: () {
              onDeleteAccount();
            },
          ),
          Container(
            color: Colors.white,
            constraints: const BoxConstraints(maxHeight: double.infinity),
          )
        ],
      ),
    );
  }

  static Widget menuUtama(
      BuildContext context, String urlImage, String titleMenu, Function klik) {
    return Expanded(
        flex: 1,
        child: InkWell(
            onTap: () {
              klik();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.75,
                  child: Image.asset(
                    urlImage,
                  ),
                ),
                Text(
                  titleMenu,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                )
              ],
            )));
  }

  static Widget getCardAntrianSekarang(antriansekarang.Data respon,
      {bool? showAnda}) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const VerticalDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //jika nomor antrian berawalan K atau C (input dari JMCARE)
                  //maka tampilkan baris nama customer
                  //selain itu hide
                  (respon.nOANTRIAN!.substring(0, 1) == "K") ||
                          (respon.nOANTRIAN!.substring(0, 1) == "C")
                      ? showAnda == true
                          //hanya menampilkan nama customer untuk login id yang bersangkutan
                          //jika bukan id-nya, hide nama customer
                          ? respon.nAMAPENGUNJUNG!.length >= 15
                              ? Text(
                                  "Nama \t\t\t\t\t\t\t\t\t\t: " +
                                      respon.nAMAPENGUNJUNG!.substring(0, 15),
                                  style: TextStyle(fontSize: 12),
                                )
                              : Text(
                                  "Nama \t\t\t\t\t\t\t\t\t\t: " +
                                      respon.nAMAPENGUNJUNG!.substring(
                                          0, respon.nAMAPENGUNJUNG!.length),
                                  style: TextStyle(fontSize: 12),
                                )
                          : Container()
                      : Container(),

                  Text(
                    "No. antrian \t: ${respon.nOANTRIAN!}",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    respon.sTATUSPROGRESS!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Spacer(),
              showAnda == true
                  ? const Flexible(
                      child: RawChip(
                          label: Text(
                            "ANDA",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          backgroundColor: Colors.green))
                  : Container()
            ],
          )),
    );
  }

  static Widget getCardRiwayatantrian(
      riwayatantrian.Data respon, BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: respon.sUDAHKADALUWARSA! > 0
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).dialogBackgroundColor,
            ), // Adds a gradient backg
            child: Column(
              children: [
                const Text("NOMOR ANTRIAN"),
                Text(
                  respon.nOANTRIAN!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.green),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Divider(
                  height: 1.0,
                  // color: Colors.grey,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.green,
                      size: 50,
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Text(
                      respon.tGLKEDATANGAN!.substring(0, 2),
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.watch,
                              size: 15,
                              color: Colors.green,
                            ),
                            Text(respon.jAMKEDATANGAN!)
                          ],
                        ),
                        Text(respon.tGLKEDATANGAN!
                            .substring(3, 11)
                            .replaceAll("-", " "))
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          respon.nOPLAT!.replaceAll("\r\n", ""),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.green,
                        ),
                        Text(respon.oFFICENAME!)
                      ],
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Divider(
                  height: 1.0,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    respon.iSFINISHED! == "0"
                        ? Container()
                        : const Chip(
                            label: Text("SELESAI"),
                            labelStyle: TextStyle(color: Colors.green),
                          ),
                    const Spacer(),
                    respon.iSFINISHED! == "0"
                        ? chipKuisioner_TidakTersedia()
                        : respon.sUDAHKUISIONER! == 0
                            ? chipKuisioner_Tersedia()
                            : chipKuisioner_TidakTersedia()
                  ],
                ),
              ],
            )),
        //ini untuk lubang sebelah kiri
        Positioned(
            left: -15,
            top: 57,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: respon.sUDAHKADALUWARSA! > 0
                          ? Theme.of(context).dividerColor
                          : Theme.of(context).dividerColor),
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: Theme.of(context).canvasColor),
            ))
      ],
    );
  }

  static Widget chipKuisioner_Tersedia() {
    return const Chip(
      label: Text(
        "Survey tersedia",
        style: TextStyle(fontSize: 10),
      ),
      backgroundColor: Colors.purple,
      labelStyle: TextStyle(color: Colors.white),
    );
  }

  static Widget chipKuisioner_TidakTersedia() {
    return const Chip(
        elevation: 1.0,
        label: Text(
          "Survey tidak tersedia",
          style: TextStyle(fontSize: 10),
        ),
        backgroundColor: Colors.deepOrange,
        labelStyle: TextStyle(color: Colors.white));
  }

  static Widget getCardKontrak(pilihkontrak.Data respon) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green, Warna.hijau],
          ),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      // Adds a gradient background and rounded corners to the container
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    respon.aGRMNTNO!,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  // Adds a title to the card
                  const Spacer(),
                  Stack(
                    children: List.generate(
                      2,
                      (index) => Container(
                        margin: EdgeInsets.only(left: (15 * index).toDouble()),
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: Colors.white54),
                      ),
                    ),
                  )
                  // Adds a stack of two circular containers to the right of the title
                ],
              ),
              Text(
                respon.pLATNO!,
                style: const TextStyle(color: Colors.white60),
              ) // Adds a subtitle to the card
            ],
          ),
          Text(respon.merkType!,
              style: const TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight
                      .bold)) // Adds a price to the bottom of the card
        ],
      ),
    );
  }

  static Widget getBottomSheet(BuildContext context, String title,
      double tinggi, Widget contentSubmenu) {
    return FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          height: tinggi,
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )))
                  ],
                ),
                const Divider(),
                contentSubmenu
              ],
            ),
          ),
        ));
  }

  static Widget subMenu(
      BuildContext context, String imageUrl, String title, String routeName) {
    return Expanded(
        flex: 1,
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, routeName);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.6,
                  child: Image.asset(imageUrl),
                ),
                FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ],
            )));
  }

  static Widget getLogoPutih() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SizedBox(
          width: 120,
          height: 80,
          child: Image.asset("assets/images/ic_jmcare_putih.png"),
        ),
      ),
    );
  }

  static Widget linkMasukOrRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              Get.offAndToNamed(Konstan.rute_login);
            },
            child: const Text(
              "Masuk",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        const Text(" atau "),
        TextButton(
            onPressed: () {
              Get.toNamed(Konstan.rute_pilih_register);
            },
            child: const Text(
              "Register",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  static Widget widgetWelcome(
      String imageAsset, String title, bool panahKiri, boolPanahKanan) {
    return Row(
      children: [
        Visibility(
          visible: panahKiri,
          child: const Expanded(flex: 0, child: Icon(Icons.arrow_left)),
        ),
        Expanded(
            flex: 5,
            child: ListView(
              children: [
                Image.asset(
                  imageAsset,
                  fit: BoxFit.fill,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            )),
        Visibility(
          visible: boolPanahKanan,
          child: const Expanded(flex: 0, child: Icon(Icons.arrow_right)),
        ),
      ],
    );
  }

  static Widget slideBox(String url) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            url,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return const SizedBox(
                height: 300,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.green,
                  ),
                ),
              );
            },
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ));
  }

  static Widget getProdukListView(ProdukRespon produkRespon) {
    return SizedBox(
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: produkRespon.data == null ? 0 : produkRespon.data!.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  //cek dulu apakah jalan di android atau ios
                  //kalau android, tampilkan screen Keterangan
                  //kalau ios, diamkan saja (biar gak disikat apple)
                  Get.toNamed(Konstan.rute_detail_slide, arguments: {
                    'detail': Platform.isAndroid
                        ? produkRespon.data![index].descriptionId
                        : Konstan.tag_tidak_ada_data
                  });
                },
                child: getBoxPromo(
                  produkRespon.data![index].imgUrl2!,
                  produkRespon.data![index].nameId!,
                  produkRespon.data![index].descriptionId!,
                ));
          },
        ));
  }

  static Widget getBoxPromo(
      String imageUrl, String title, String descriptionID) {
    return SizedBox(
      height: 200,
      width: 150,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                height: 130,
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return SizedBox(
                      height: 130,
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            Konstan.tag_default_img_produk,
                            height: 130,
                            fit: BoxFit.fill,
                          )
                          // Icon(Icons.image_not_supported_outlined, color: Colors.green,),
                          // Text("Gagal memuat gambar",
                          //   style: TextStyle(
                          //       fontStyle: FontStyle.italic,
                          //     fontSize: 10
                          //   ),
                          // )
                        ],
                      )));
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                      height: 130,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ));
                },
              ),
            ),
            SizedBox(
                height: 40,
                child: Center(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                )))
          ],
        ),
      ),
    );
  }

  static Widget getPromoListView(PromoRespon promoRespon) {
    return SizedBox(
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: promoRespon.data == null ? 0 : promoRespon.data!.length,
          itemBuilder: (context, index) {
            return InkWell(
                //cek dulu apakah jalan di android atau ios
                //kalau android, tampilkan screen Keterangan
                //kalau ios, diamkan saja (biar gak disikat apple)
                onTap: () {
                  Get.toNamed(Konstan.rute_detail_slide, arguments: {
                    'detail': Platform.isAndroid
                        ? promoRespon.data![index].descriptionId
                        : Konstan.tag_tidak_ada_data
                  });
                },
                child: getBoxPromo(
                  promoRespon.data![index].imgUrl!,
                  promoRespon.data![index].titleId!,
                  promoRespon.data![index].descriptionId!,
                ));
          },
        ));
  }

  static Widget teksMerah(String caption) {
    return Text(
      caption,
      style: const TextStyle(color: Colors.red),
    );
  }

  static Widget teksJudul(String caption) {
    return Text(
      caption,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  static Widget getTidakAdaData() {
    return const Center(child: Text("Tidak ada data"));
  }

  static Widget randomLoadingWidget() {
    var random = Random().nextInt(19);
    double ukuran = 50;
    switch (random) {
      case 0:
        return la.LoadingAnimationWidget.waveDots(
            color: Warna.hijau1, size: ukuran);
      case 1:
        return la.LoadingAnimationWidget.inkDrop(
            color: Warna.hijau1, size: ukuran);
      case 2:
        return la.LoadingAnimationWidget.twistingDots(
            leftDotColor: Warna.hijau1,
            rightDotColor: Warna.orange2,
            size: ukuran);
      case 3:
        return la.LoadingAnimationWidget.threeRotatingDots(
            color: Warna.hijau1, size: ukuran);
      case 4:
        return la.LoadingAnimationWidget.staggeredDotsWave(
            color: Warna.hijau1, size: ukuran);
      case 5:
        return la.LoadingAnimationWidget.fourRotatingDots(
            color: Warna.hijau1, size: ukuran);
      case 6:
        return la.LoadingAnimationWidget.fallingDot(
            color: Warna.hijau1, size: ukuran);
      case 7:
        return la.LoadingAnimationWidget.fallingDot(
            color: Warna.hijau1, size: ukuran);
      case 8:
        return la.LoadingAnimationWidget.discreteCircle(
            color: Warna.hijau1, size: ukuran);
      case 9:
        return la.LoadingAnimationWidget.threeArchedCircle(
            color: Warna.hijau1, size: ukuran);
      case 10:
        return la.LoadingAnimationWidget.bouncingBall(
            color: Warna.hijau1, size: ukuran);
      case 12:
        return la.LoadingAnimationWidget.hexagonDots(
            color: Warna.hijau1, size: ukuran);
      case 13:
        return la.LoadingAnimationWidget.beat(
            color: Warna.hijau1, size: ukuran);
      case 14:
        return la.LoadingAnimationWidget.twoRotatingArc(
            color: Warna.hijau1, size: ukuran);
      case 15:
        return la.LoadingAnimationWidget.horizontalRotatingDots(
            color: Warna.hijau1, size: ukuran);
      case 16:
        return la.LoadingAnimationWidget.newtonCradle(
            color: Warna.hijau1, size: ukuran);
      case 17:
        return la.LoadingAnimationWidget.stretchedDots(
            color: Warna.hijau1, size: ukuran);
      case 18:
        return la.LoadingAnimationWidget.halfTriangleDot(
            color: Warna.hijau1, size: ukuran);
      case 19:
        return la.LoadingAnimationWidget.dotsTriangle(
            color: Warna.hijau1, size: ukuran);
      default:
        return la.LoadingAnimationWidget.flickr(
            leftDotColor: Warna.hijau1,
            rightDotColor: Warna.orange2,
            size: ukuran);
    }
  }

  static Widget getLoadingWidget({String? loadingText}) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        randomLoadingWidget(),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          loadingText ?? Konstan.tag_now_loading,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    ));
  }

  static Widget cardAgreementInsco(agrmntInsco.Data data) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nomor kontrak",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 11),
                  ),
                  Text(
                    data.aGRMNTNO!,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    "Nama tertanggung",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
                  ),
                  Text(
                    data.pOLICYNAME!,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    "Nomor polis asuransi",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
                  ),
                  Text(
                    data.pOLICYNO!,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    "Perusahaan asuransi",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
                  ),
                  Text(
                    data.iNSCOBRANCHNAME!,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    "Jenis pertanggungan",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
                  ),
                  Text(
                    data.mAINCVGTYPENAME!,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_circle_right,
              color: Colors.green,
            )
          ],
        ));
  }

  static Widget getLoadingKodeposWidget() {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LinearProgressIndicator(),
        Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          "Mencari kodepos...",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        )
      ],
    ));
  }

  // static Widget getLoadingWidget() {
  //   var random = Random().nextInt(19);
  //   return Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children:  [
  //           la.LoadingAnimationWidget.flickr(
  //               leftDotColor: Warna.hijau1,
  //               rightDotColor: Warna.orange2,
  //               size: 25
  //           ),
  //           const Padding(padding: EdgeInsets.only(top: 10)),
  //           const Text(
  //             Konstan.tag_now_loading,
  //             textAlign: TextAlign.center,
  //             style: TextStyle(color: Colors.grey),
  //           )
  //         ],
  //       ));
  // }

  static Widget getGpsLoading() {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RippleAnimation(
          color: Warna.hijau1,
          delay: Duration(milliseconds: 300),
          repeat: true,
          minRadius: 35,
          ripplesCount: 3,
          duration: Duration(milliseconds: 6 * 300),
          child: CircleAvatar(
            minRadius: 5,
            maxRadius: 5,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          Konstan.tag_gps_searching,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        )
      ],
    ));
  }

  static Widget getDownloadWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        randomLoadingWidget(),
        Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          Konstan.tag_downloading,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        )
      ],
    ));
  }

  static TableRow getRowSpacer(double tinggi) {
    return TableRow(
      children: <Widget>[
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.top,
            child: SizedBox(
              height: tinggi,
            )),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.top,
            child: SizedBox(
              height: tinggi,
            )),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.top,
            child: SizedBox(
              height: tinggi,
            )),
      ],
    );
  }

  static Widget getWidgetAgreementCard(
      String judul, String subjudul, String angka) {
    Random random = Random();
    int i = random.nextInt(5);
    debugPrint(i.toString());

    late Color c;
    switch (i) {
      case 0:
        {
          c = Colors.green;
        }
        break;
      case 1:
        {
          c = Colors.orange;
        }
        break;
      case 2:
        {
          c = Colors.red;
        }
        break;
      case 3:
        {
          c = Colors.black;
        }
        break;
      case 4:
        {
          c = Colors.purple;
        }
        break;
      default:
        {
          c = Colors.green;
        }
        break;
    }

    return IntrinsicWidth(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          judul,
          textAlign: TextAlign.end,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Flexible(child: Divider(color: c, thickness: 1.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subjudul,
              style: const TextStyle(fontSize: 10.0),
            ),
            const Padding(padding: EdgeInsets.only(right: 5)),
            Text(
              angka,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0),
            )
          ],
        )
      ],
    ));
  }

  static Widget getWidgetHeaderAgreementCard(
      BuildContext context, AgreementcardRespon respon) {
    var header = respon.data!.first;
    return Container(
        padding: const EdgeInsets.all(20),
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: FixedColumnWidth(10),
            2: IntrinsicColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(
              children: <Widget>[
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard(
                      "Tanggal kontrak", "", header.dUEDT!),
                ),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container()),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard(
                      "Kantor cabang", "", header.oFFICENAME!),
                ),
              ],
            ),
            Komponen.getRowSpacer(20),
            TableRow(
              children: <Widget>[
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard(
                      "Nomor kontrak", "", header.aGRMNTNO!),
                ),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container()),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard(
                      "Atas nama", "", header.cUSTNAME!),
                ),
              ],
            ),
            Komponen.getRowSpacer(20),
            TableRow(
              children: <Widget>[
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard(
                      "Denda dibayarkan",
                      Konstan.tag_rupiah,
                      Fungsi.formatNumberDouble(header.lCINSTPAIDAMTAAM!)),
                ),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container()),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard(
                      "Hutang biaya",
                      Konstan.tag_rupiah,
                      Fungsi.formatNumberDouble(header.vISITFEE!)),
                ),
              ],
            ),
            Komponen.getRowSpacer(20),
            TableRow(
              children: <Widget>[
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard(
                      "Sisa denda keterlambatan",
                      Konstan.tag_rupiah,
                      Fungsi.formatNumberDouble(header.oSLCINST!)),
                ),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container()),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container()),
              ],
            ),
          ],
        ));
  }
}
