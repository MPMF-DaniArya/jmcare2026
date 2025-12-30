import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jmcare/screens/home/logic.dart';
import 'package:jmcare/screens/home/state.dart';
import 'package:get/get.dart';
import '../../helper/Komponen.dart';
import '../../helper/Warna.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeLogic logic = Get.put(HomeLogic());
    final HomeState state = Get.find<HomeLogic>().state;

    return GetBuilder<HomeLogic>(
        assignId: true,
        builder: (logic) {
          return Obx(() => logic.obsLoadVersi.value
              ? Scaffold(
                  body: Center(
                  child: Komponen.getLoadingWidget(
                      loadingText: "Sedang memeriksa versi..."),
                ))
              : logic.obsVersiSalah.value
                  ? const Scaffold(
                      body: Center(
                          child: Text(
                              "Silakan uninstal aplikasi ini dan download aplikasi terbaru melalui playstore")),
                    )
                  : Scaffold(
                      //jika sdh login munculkan navigationdrawer
                      drawer: Obx(() => logic.sdhLogin.value
                          ? Komponen.getMainDrawer(
                              context,
                              () => logic.doLogout(context),
                              () => logic.dialogDeleteAkun(context))
                          : Container()),
                      body: SafeArea(
                        child: Stack(
                          children: [
                            Container(
                              height: 130,
                              decoration: const BoxDecoration(
                                  color: Colors.green,
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Colors.green, Warna.hijau]),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50))),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20, bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Komponen.getLogoPutih(),
                                      const Spacer(),

                                      Obx(
                                        () => logic.sdhLogin.value
                                            ?
                                            //kalau sudah login, tampilkan loading grade
                                            logic.loading_grade.value
                                                ? const CircularProgressIndicator(
                                                    color: Colors.white)
                                                : InkWell(
                                                    onTap: () {
                                                      logic.clickBadgeUser();
                                                    },
                                                    child: Row(
                                                      children: [
                                                        logic.icon_jenis_member
                                                                    .value ==
                                                                ''
                                                            ? const Icon(
                                                                Icons
                                                                    .supervised_user_circle,
                                                                color: Colors
                                                                    .white,
                                                                size: 30,
                                                              )
                                                            : Image.asset(
                                                                logic
                                                                    .icon_jenis_member
                                                                    .value,
                                                                height: 30,
                                                                width: 30,
                                                              ),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 4)),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Selamat datang, ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10),
                                                            ),
                                                            Text(
                                                              logic.nama_user
                                                                  .value,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12),
                                                            ),
                                                            // Row(
                                                            //   children:  [
                                                            //     Text(logic.point.value.toString(), style: const
                                                            //     TextStyle(color: Colors.white, fontSize: 10),),
                                                            //     const Text(" point", style: TextStyle(color: Colors.white, fontSize: 8),),
                                                            //   ],
                                                            // ),
                                                          ],
                                                        ),
                                                        logic.sdhLogin.value
                                                            ? state.isDebitur
                                                                        .replaceAll(
                                                                            " ",
                                                                            "") ==
                                                                    "1"
                                                                ? IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      logic
                                                                          .klikNotifikasi();
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .notifications,
                                                                      color: Colors
                                                                          .white,
                                                                    ))
                                                                : Container()
                                                            : const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25)),
                                                      ],
                                                    ))
                                            //kalau belum login tampilkan Container kosongan
                                            : Container(),
                                      ),
                                      // const Spacer()
                                    ],
                                  ),
                                  Expanded(
                                      child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Obx(() => (logic.is_loading.value)
                                          ? SizedBox(
                                              height: 300,
                                              child: Komponen
                                                  .getLoadingWidget()) //loading ditaruh di Sizedbox, biar ga ngegap kalo api bisa
                                          : logic.jmlArraySlideshow.value == 0
                                              ? SizedBox(
                                                  height: 300,
                                                  child: Card(
                                                      child: Komponen
                                                          .getNoInternet()),
                                                )
                                              : Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: 300,
                                                      child: CarouselSlider(
                                                          carouselController: state
                                                              .carouselController,
                                                          options:
                                                              CarouselOptions(
                                                                  autoPlay:
                                                                      true,
                                                                  viewportFraction:
                                                                      1.0,
                                                                  enlargeCenterPage:
                                                                      false,
                                                                  autoPlayInterval:
                                                                      const Duration(
                                                                          seconds:
                                                                              5),
                                                                  height: double
                                                                      .infinity,
                                                                  onPageChanged:
                                                                      (index,
                                                                          reason) {
                                                                    logic.setIndeksCarousel(
                                                                        index);
                                                                  }),
                                                          items: logic.konversi(
                                                              logic
                                                                  .arraySlideshow
                                                                  .value)),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: logic
                                                            .konversi(logic
                                                                .arraySlideshow
                                                                .value)
                                                            .asMap()
                                                            .entries
                                                            .map((entry) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              logic.state
                                                                  .carouselController!
                                                                  .animateToPage(
                                                                      entry
                                                                          .key);
                                                            },
                                                            child: Container(
                                                              width: logic.indeksCarousel
                                                                          .value ==
                                                                      entry.key
                                                                  ? 9.0
                                                                  : 6.0,
                                                              height: logic
                                                                          .indeksCarousel
                                                                          .value ==
                                                                      entry.key
                                                                  ? 9.0
                                                                  : 6.0,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8.0,
                                                                      horizontal:
                                                                          4.0),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: (Theme.of(context).brightness ==
                                                                              Brightness
                                                                                  .dark
                                                                          ? Colors
                                                                              .white
                                                                          : Warna
                                                                              .hijau)
                                                                      .withOpacity(logic.indeksCarousel.value ==
                                                                              entry.key
                                                                          ? 0.9
                                                                          : 0.4)),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      //jika belum login munculkan link untuk login/register
                                      Obx(() => logic.sdhLogin.value
                                          ? Container()
                                          : Komponen.linkMasukOrRegister(
                                              context)),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 20)),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 30)),
                                      Row(
                                        children: [
                                          Komponen.teksJudul("Menu Favorit"),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Obx(() => Switch(
                                                  value: logic.obsSwitch.value,
                                                  onChanged: (bool newValue) {
                                                    logic.changeTheme(newValue);
                                                  })),
                                              const Text("Dark Mode")
                                            ],
                                          )

                                          // TextButton(
                                          //     onPressed: (){
                                          //       logic.changeTheme();
                                          //     },
                                          //     child: const Text("Tema")
                                          // )
                                        ],
                                      ),

                                      const Padding(
                                          padding: EdgeInsets.only(top: 10)),

                                      Obx(
                                        () => logic.sdhLogin
                                                .value //cek apakah sudah login apa belum
                                            ? (state.isDebitur
                                                        .replaceAll(" ", "") ==
                                                    "1") //kalo yg login debitur, munculkan menu debitur
                                                ? Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    spacing: 20.0,
                                                    runSpacing: 20.0,
                                                    children: [
                                                      Komponen.homeButtonMenu(
                                                          Icons.room,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Jaringan Kami",
                                                          () => logic
                                                              .klikJaringanKami()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.security,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Ganti Password",
                                                          () => logic
                                                              .klikGantiPassword()),
                                                      Komponen.homeButtonMenu(
                                                          Icons
                                                              .handshake_outlined,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "eContract",
                                                          () => logic
                                                              .klikeContract()),
                                                      logic.is_loading_pengkiniandata
                                                              .value
                                                          ? const CircularProgressIndicator()
                                                          : Visibility(
                                                              visible: (logic
                                                                          .obsAppleVisibility
                                                                          .value ==
                                                                      false ||
                                                                  Platform
                                                                      .isAndroid),
                                                              //ini kalau akunnya si anik (login user id 68, menu Pengkinian data dihide dulu, biar ga ketahuan Apple)
                                                              child: Komponen.homeButtonMenu(
                                                                  Icons
                                                                      .dataset_linked,
                                                                  Warna.hijau1,
                                                                  Warna.hijau2,
                                                                  "Pengkinian Data",
                                                                  () => logic
                                                                      .klikPengkinianData()),
                                                            ),
                                                      // Komponen.homeButtonMenu(
                                                      //     Icons.sign_language,
                                                      //     Warna.hijau1,
                                                      //     Warna.hijau2,
                                                      //     "eSign",
                                                      //         () => logic.klikEsignHome()
                                                      // ),
                                                      Komponen.homeButtonMenu(
                                                          Icons.garage,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Klaim Asuransi",
                                                          () => logic
                                                              .klikKlaimAsuransi()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.cable,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Status Klaim \nAsuransi",
                                                          () => logic
                                                              .klikStatusKlaimAsuransi()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.payments_sharp,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Riwayat Pembayaran",
                                                          () => logic
                                                              .klikAgreementCard()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.queue_sharp,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Antrian Online",
                                                          () => logic
                                                              .klikAntrianOnline()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.policy,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "ePolis",
                                                          () => logic
                                                              .klikEpolis()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.feedback,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          'Layanan Pengaduan',
                                                              () => logic.klikLayananPengaduan()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.question_mark,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "FAQ",
                                                          () =>
                                                              logic.klikFAQ()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.delete,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Hapus akun",
                                                          () => logic
                                                              .dialogDeleteAkun(
                                                                  context)),
                                                      Komponen.homeButtonMenu(
                                                          Icons.logout,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Logout",
                                                          () => logic
                                                              .dialogLogout(
                                                                  context)),
                                                    ],
                                                  )
                                                : Wrap(
                                                    //kalo yang login nondebitur, munculkan menu nondebitur
                                                    alignment:
                                                        WrapAlignment.center,
                                                    spacing: 20.0,
                                                    runSpacing: 20.0,
                                                    children: [
                                                      Komponen.homeButtonMenu(
                                                          Icons.room,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Jaringan Kami",
                                                          () => logic
                                                              .klikJaringanKami()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.feedback,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          'Layanan Pengaduan',
                                                              () => logic.klikLayananPengaduan()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.security,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Ganti Password",
                                                          () => logic
                                                              .klikGantiPassword()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.queue_sharp,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Antrian Online",
                                                          () => logic
                                                              .klikAntrianOnline()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.question_mark,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "FAQ",
                                                          () =>
                                                              logic.klikFAQ()),
                                                      Komponen.homeButtonMenu(
                                                          Icons.delete,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Hapus akun",
                                                          () => logic
                                                              .dialogDeleteAkun(
                                                                  context)),
                                                      Komponen.homeButtonMenu(
                                                          Icons.logout,
                                                          Warna.hijau1,
                                                          Warna.hijau2,
                                                          "Logout",
                                                          () => logic
                                                              .dialogLogout(
                                                                  context)),
                                                    ],
                                                  )
                                            : Wrap(
                                                //kalau belum login, munculkan menu nondebitur juga
                                                alignment: WrapAlignment.center,
                                                spacing: 20.0,
                                                runSpacing: 20.0,
                                                children: [
                                                  Komponen.homeButtonMenu(
                                                      Icons.room,
                                                      Warna.hijau1,
                                                      Warna.hijau2,
                                                      "Jaringan Kami",
                                                      () => logic
                                                          .klikJaringanKami()),
                                                  Komponen.homeButtonMenu(
                                                      Icons.queue_sharp,
                                                      Warna.hijau1,
                                                      Warna.hijau2,
                                                      "Antrian Online",
                                                      () => logic
                                                          .klikAntrianOnline()),
                                                  Komponen.homeButtonMenu(
                                                      Icons.question_mark,
                                                      Warna.hijau1,
                                                      Warna.hijau2,
                                                      "FAQ",
                                                      () => logic.klikFAQ()),
                                                ],
                                              ),
                                      ),

                                      const Padding(
                                          padding: EdgeInsets.only(top: 50)),

                                      Komponen.teksJudul(
                                          "Info Produk dan Melayani"),

                                      const Padding(
                                          padding: EdgeInsets.only(top: 10)),

                                      Obx(
                                        () => logic.is_loading.value ||
                                                logic.arrayProduk.value == null
                                            ? SizedBox(
                                                height: 200,
                                                child:
                                                    Komponen.getLoadingWidget())
                                            : logic.jmlProduk.value == 0
                                                ? SizedBox(
                                                    height: 100,
                                                    child: Card(
                                                        child: Komponen
                                                            .getNoInternet()))
                                                : Komponen.getProdukListView(
                                                    logic.arrayProduk.value),
                                      ),

                                      const Padding(
                                          padding: EdgeInsets.only(top: 30)),

                                      // Komponen.teksJudul("Info Promosi"),
                                      //
                                      // const Padding(padding: EdgeInsets.only(top: 10)),
                                      //
                                      // Obx(
                                      //       () => logic.is_loading.value || logic.arrayPromo.value == null
                                      //         ? SizedBox(height: 200, child: Komponen.getLoadingWidget())
                                      //         : logic.jmlPromo.value == 0
                                      //           ? SizedBox(height: 100, child: Card(child: Komponen.getNoInternet()))
                                      //           : Komponen.getPromoListView(logic.arrayPromo.value),
                                      // ),

                                      const Padding(
                                          padding: EdgeInsets.only(top: 20)),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: AppBar(
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                automaticallyImplyLeading: true,
                              ),
                            ),
                          ],
                        ),
                      )));
        });
  }
}
