import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/custom/ThousandsFormatter.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/klaim_asuransi/form_lanjut/logic.dart';
import 'package:jmcare/screens/klaim_asuransi/form_lanjut/state.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class FormlanjutScreen extends StatelessWidget {
  const FormlanjutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FormlanjutLogic logic = Get.put(FormlanjutLogic());
    final FormlanjutState state = Get.find<FormlanjutLogic>().state;

    return GetBuilder<FormlanjutLogic>(
      assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Formulir Klaim Asuransi",
            body: Obx(
                    () => logic.is_loading.value
                        ? Komponen.getLoadingWidget()
                        : Form(
                            child: ListView(
                              children: [

                                ExpansionTile(
                                  shape: const Border(),
                                  childrenPadding: const EdgeInsets.only(left: 30, right: 30),
                                  initiallyExpanded: state.intialExpand!,
                                  title: const Text("DATA TERTANGGUNG", style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: const Text("Lengkapi data sehubungan dengan tertanggung"),
                                  children: [
                                    TextFormField(
                                      enabled: false,
                                      controller: state.tecNomorPolisAsuransi,
                                      decoration: const InputDecoration(
                                          labelText: "* Nomor polis asuransi"
                                      ),
                                    ),
                                    TextFormField(
                                      enabled: false,
                                      controller: state.tecNamaTertanggung,
                                      decoration: const InputDecoration(
                                          labelText: "* Nama tertanggung"
                                      ),
                                    ),
                                    TextFormField(
                                      controller: state.tecAlamatTertanggung,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                          labelText: "* Alamat tertanggung"
                                      ),
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecNomorhpTertanggung,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: "* Nomor HP"
                                      ),
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecEmailTertanggung,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                          labelText: "Email"
                                      ),
                                    )
                                  ],
                                ),


                                ExpansionTile(
                                  shape: const Border(),
                                  childrenPadding: const EdgeInsets.only(left: 30, right: 30),
                                  initiallyExpanded: state.intialExpand!,
                                  title: const Text("DATA PELAPOR", style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: const Text("Lengkapi data sehubungan dengan pelapor"),
                                  children: [
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecNamaPelapor,
                                      decoration: const InputDecoration(
                                          labelText: "* Nama pelapor"
                                      ),
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecAlamatPelapor,
                                      decoration: const InputDecoration(
                                          labelText: "* Alamat pelapor"
                                      ),
                                    ),
                                    TextFormField(
                                      controller: state.tecNomorhpPelapor,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: "* Nomor HP"
                                      ),
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecEmailPelapor,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                          labelText: "Email"
                                      ),
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecHubunganDenganTertanggung,
                                      decoration: const InputDecoration(
                                          labelText: "Hubungan dengan tertanggung"
                                      ),
                                    )
                                  ],
                                ),


                                ExpansionTile(
                                  shape: const Border(),
                                  childrenPadding: const EdgeInsets.only(left: 30, right: 30),
                                  initiallyExpanded: state.intialExpand!,
                                  title: const Text("DATA KENDARAAN", style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: const Text("Data kendaraan menurut nomor kontrak"),
                                  children: [
                                    TextFormField(
                                      enabled: false,
                                      controller: state.tecMerkTipeKendaraan,
                                      decoration: const InputDecoration(
                                          labelText: "* Merk/tipe kendaraan"
                                      ),
                                    ),
                                    TextFormField(
                                      enabled: false,
                                      controller: state.tecTahunPembuatan,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: "* Tahun pembuatan"
                                      ),
                                    ),
                                    TextFormField(
                                      enabled: false,
                                      controller: state.tecNomorRangka,
                                      decoration: const InputDecoration(
                                          labelText: "* Nomor Rangka"
                                      ),
                                    ),
                                    TextFormField(
                                      enabled: false,
                                      controller: state.tecNomorMesin,
                                      decoration: const InputDecoration(
                                          labelText: "* Nomor Mesin"
                                      ),
                                    ),
                                    TextFormField(
                                      enabled: false,
                                      controller: state.tecNomorPolisi,
                                      decoration: const InputDecoration(
                                          labelText: "* Nomor Polisi"
                                      ),
                                    )
                                  ],
                                ),


                                ExpansionTile(
                                  shape: const Border(),
                                  childrenPadding: const EdgeInsets.only(left: 30, right: 30),
                                  initiallyExpanded: state.intialExpand!,
                                  title: const Text("DATA KEJADIAN", style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: const Text("Lengkapi data waktu terjadinya peristiwa"),
                                  children: [
                                    TextFormField(
                                      readOnly: true,
                                      onTap: (){
                                        logic.tapTglKejadian(context);
                                      },
                                      controller: state.tecTglKejadian,
                                      decoration: const InputDecoration(
                                          labelText: "* Tanggal dan jam kejadian",
                                        suffixIcon: Icon(Icons.calendar_month)
                                      ),
                                    ),
                                    DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        labelText: "Tempat Kejadian"
                                      ),
                                        value: state.selected_dropdownTempatKejadian,
                                        items: state.dropdownTempatKejadian,
                                        onChanged: (newValue){
                                          logic.setDropdownTempatKejadian(newValue);
                                        }
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecKecepatanSaatKejadian,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: "Kecepatan Saat Kejadian (km/jam)"
                                      ),
                                      inputFormatters: [ThousandsFormatter()],
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecNamaPengemudi,
                                      decoration: const InputDecoration(
                                          labelText: "Nama Pengemudi Saat Kejadian"
                                      ),
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecAlamatPengemudi,
                                      decoration: const InputDecoration(
                                          labelText: "Alamat Pengemudi"
                                      ),
                                    ),
                                    DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            labelText: "Jenis SIM"
                                        ),
                                        value: state.selected_dropdownJenisSIM,
                                        items: state.dropdownJenisSIM,
                                        onChanged: (newValue){
                                          logic.setDropdownJenisSIM(newValue);
                                        }
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecNomorSIM,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: "Nomor SIM"
                                      ),
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      onTap: (){
                                        logic.tapTglMasaBerlakuSIM(context);
                                      },
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecMasaBerlakuSIM,
                                      decoration: const InputDecoration(
                                          labelText: "Masa Berlaku SIM",
                                        suffixIcon: Icon(Icons.calendar_month)
                                      ),
                                    ),
                                    // SwitchListTile(value: value, onChanged: onChanged)

                                    const Padding(padding: EdgeInsets.only(top: 30)),
                                    const Text("Apakah pengemudi bekerja pada tertanggung?",
                                    style: TextStyle(
                                      fontSize: 16
                                    ),),
                                    RadioListTile(
                                      title: Text(Konstan.tag_ya.toUpperCase()),
                                        value: state.opsiPengemudiBekerjaPadaTertanggung[0],
                                        groupValue: state.selected_opsiPengemudiBekerjaPadaTertanggung,
                                        onChanged: (newValue){
                                          logic.setOpsi_PengemudiBekerjaPadaTertanggung(newValue.toString());
                                        }
                                    ),
                                    RadioListTile(
                                        title: Text(Konstan.tag_tidak.toUpperCase()),
                                        value: state.opsiPengemudiBekerjaPadaTertanggung[1],
                                        groupValue: state.selected_opsiPengemudiBekerjaPadaTertanggung,
                                        onChanged: (newValue){
                                          logic.setOpsi_PengemudiBekerjaPadaTertanggung(newValue.toString());
                                        }
                                    ),


                                    const Padding(padding: EdgeInsets.only(top: 30)),
                                    const Text("Apakah pengemudi menjalankan kendaraan atas perintah dari atau sepengetahuan tertanggung?",
                                      style: TextStyle(
                                          fontSize: 16
                                      ),),
                                    RadioListTile(
                                        title: Text(Konstan.tag_ya.toUpperCase()),
                                        value: state.opsiPengemudiSepengetahuanTertanggung[0],
                                        groupValue: state.selected_opsiPengemudiSepengetahuanTertanggung,
                                        onChanged: (newValue){
                                          logic.setOpsi_PengemudiSepengetahuanTertanggung(newValue.toString());
                                        }
                                    ),
                                    RadioListTile(
                                        title: Text(Konstan.tag_tidak.toUpperCase()),
                                        value: state.opsiPengemudiSepengetahuanTertanggung[1],
                                        groupValue: state.selected_opsiPengemudiSepengetahuanTertanggung,
                                        onChanged: (newValue){
                                          logic.setOpsi_PengemudiSepengetahuanTertanggung(newValue.toString());
                                        }
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecPenggunaanKendaraanSaatKejadian,
                                      decoration: const InputDecoration(
                                          labelText: "Penggunaan kendaraan saat kejadian"
                                      ),
                                    ),

                                    const Padding(padding: EdgeInsets.only(top: 30)),
                                    const Text("Apakah kejadian ini dilaporkan ke kepolisian?",
                                      style: TextStyle(
                                          fontSize: 16
                                      ),),
                                    RadioListTile(
                                        title: Text(Konstan.tag_ya.toUpperCase()),
                                        value: state.opsiKejadianDilaporanPolisi[0],
                                        groupValue: state.selected_opsiKejadianDilaporanPolisi,
                                        onChanged: (newValue){
                                          logic.setOpsi_KejadianDilaporkanPolisi(newValue.toString());
                                        }
                                    ),
                                    RadioListTile(
                                        title: Text(Konstan.tag_tidak.toUpperCase()),
                                        value: state.opsiKejadianDilaporanPolisi[1],
                                        groupValue: state.selected_opsiKejadianDilaporanPolisi,
                                        onChanged: (newValue){
                                          logic.setOpsi_KejadianDilaporkanPolisi(newValue.toString());
                                        }
                                    ),
                                    TextFormField(
                                      enabled: state.isEnableKejadianDilaporkanPolisi,
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecNamaPolsek,
                                      decoration: const InputDecoration(
                                          labelText: "Polsek / Polres"
                                      ),
                                    ),
                                  ],
                                ),


                                ExpansionTile(
                                  shape: const Border(),
                                  childrenPadding: const EdgeInsets.only(left: 30, right: 30),
                                  initiallyExpanded: state.intialExpand!,
                                  title: const Text("DATA KERUSAKAN KENDARAAN", style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: const Text("Lengkapi data kerusakan kendaraan"),
                                  children: [
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      enabled: true,
                                      controller: state.tecDimanaKendaraanSekarang,
                                      decoration: InputDecoration(
                                          labelText: state.tipeKlaim == Konstan.tag_kecelakaan ? "* Di manakah kendaraan saat ini?" : "Di manakah kendaraan saat ini?"
                                      ),
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      enabled: true,
                                      controller: state.tecSisiKendaraanRusak,
                                      decoration: InputDecoration(
                                          labelText: state.tipeKlaim == Konstan.tag_kecelakaan ? "* Sisi kendaraan mana yang rusak?" : "Sisi kendaraan mana yang rusak?"
                                      ),
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      enabled: true,
                                      controller: state.tecEstimasiNilaiKerugian,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          labelText: state.tipeKlaim == Konstan.tag_kecelakaan ? "* Berapa estimasi nilai kerugiannya? (Rp)" : "Berapa estimasi nilai kerugiannya? (Rp)"
                                      ),
                                      inputFormatters: [ThousandsFormatter()],

                                    ),

                                    const Padding(padding: EdgeInsets.only(top: 30)),
                                    Text( state.tipeKlaim == Konstan.tag_kecelakaan ?  "* Apakah ada pihak lain yang bertanggung jawab?" : "Apakah ada pihak lain yang bertanggung jawab?",
                                      style: const TextStyle(
                                          fontSize: 16
                                      ),),
                                    RadioListTile(
                                        title: Text(Konstan.tag_ya.toUpperCase()),
                                        value: state.opsiPihakLainBertanggungjawab[0],
                                        groupValue: state.selected_opsiPihakLainBertanggungjawab,
                                        onChanged: (newValue){
                                          logic.setOpsi_PihaklainBertanggungjawab(newValue.toString());
                                        }
                                    ),
                                    RadioListTile(
                                        title: Text(Konstan.tag_tidak.toUpperCase()),
                                        value: state.opsiPihakLainBertanggungjawab[1],
                                        groupValue: state.selected_opsiPihakLainBertanggungjawab,
                                        onChanged: (newValue){
                                          logic.setOpsi_PihaklainBertanggungjawab(newValue.toString());
                                        }
                                    ),

                                    TextFormField(
                                      enabled: true,
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecNamaPihakLain,
                                      decoration: InputDecoration(
                                          labelText: state.selected_opsiPihakLainBertanggungjawab == Konstan.tag_ya ? "* Nama pihak lain" : "Nama pihak lain"
                                      ),
                                    ),
                                    TextFormField(
                                      enabled: true,
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecAlamatPihakLain,
                                      decoration: InputDecoration(
                                          labelText: state.selected_opsiPihakLainBertanggungjawab == Konstan.tag_ya ? "* Alamat pihak lain" :"Alamat pihak lain"
                                      ),
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      enabled: true,
                                      controller: state.tecAsuransiPihakLain,
                                      decoration: InputDecoration(
                                          labelText: state.selected_opsiPihakLainBertanggungjawab == Konstan.tag_ya ? "* Nama asuransi pihak lain (jika ada)" :  "Nama asuransi pihak lain (jika ada)"
                                      ),
                                    ),
                                  ],
                                ),

                                ExpansionTile(
                                  shape: const Border(),
                                  childrenPadding: const EdgeInsets.only(left: 30, right: 30),
                                  initiallyExpanded: state.intialExpand!,
                                  title: const Text("DATA PIHAK KETIGA", style: TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: const Text("Lengkapi data pihak ketiga"),
                                  children: [
                                    TextFormField(
                                      enabled: true,
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecNamaPihakKetiga,
                                      decoration: const InputDecoration(
                                          labelText: "Nama pihak ketiga"
                                      ),
                                    ),
                                    TextFormField(
                                      enabled: true,
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecAlamatPihakKetiga,
                                      decoration: const InputDecoration(
                                          labelText: "Alamat pihak ketiga"
                                      ),
                                    ),
                                    TextFormField(
                                      enabled: true,
                                      textInputAction: TextInputAction.next,
                                      controller: state.tecNomorhpPihakKetiga,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: "Nomor telepon/HP pihak ketiga"
                                      ),
                                    ),


                                    const Padding(padding: EdgeInsets.only(top: 30)),
                                    const Text("Apa saja kerugian pihak ketiga?",
                                      style: TextStyle(
                                          fontSize: 16
                                      ),),
                                    CheckboxListTile(
                                      title: Text(state.checkboxKerugian[0]),
                                      value: state.isCheckboxKerugian[0],
                                      onChanged: (bool? newValue) {
                                        logic.handleCekKerugian(0,newValue!);
                                      },
                                      tristate: false,
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                      controlAffinity: ListTileControlAffinity.leading,
                                    ),
                                    CheckboxListTile(
                                      title: Text(state.checkboxKerugian[1]),
                                      value: state.isCheckboxKerugian[1],
                                      onChanged: (bool? newValue) {
                                        logic.handleCekKerugian(1,newValue!);
                                      },
                                      tristate: false,
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                      controlAffinity: ListTileControlAffinity.leading,
                                    ),
                                    CheckboxListTile(
                                      title: Text(state.checkboxKerugian[2]),
                                      value: state.isCheckboxKerugian[2],
                                      onChanged: (bool? newValue) {
                                        logic.handleCekKerugian(2,newValue!);
                                      },
                                      tristate: false,
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                      controlAffinity: ListTileControlAffinity.leading,
                                    ),


                                    const Padding(padding: EdgeInsets.only(top: 30)),
                                    const Text("Apakah kerugian pihak ketiga diasuransikan?",
                                      style: TextStyle(
                                          fontSize: 16
                                      ),),
                                    RadioListTile(
                                        title: Text(Konstan.tag_ya.toUpperCase()),
                                        value: state.opsiKerugianPihakketigaDiasuransikan[0],
                                        groupValue: state.selected_opsiKerugianPihakketigaDiasuransikan,
                                        onChanged: (newValue){
                                          logic.setOpsi_KerugianPihakketigaDiasuransikan(newValue.toString());
                                        }
                                    ),
                                    RadioListTile(
                                        title: Text(Konstan.tag_tidak.toUpperCase()),
                                        value: state.opsiKerugianPihakketigaDiasuransikan[1],
                                        groupValue: state.selected_opsiKerugianPihakketigaDiasuransikan,
                                        onChanged: (newValue){
                                          logic.setOpsi_KerugianPihakketigaDiasuransikan(newValue.toString());
                                        }
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      enabled: state.isEnableAsuransiPihakKetiga,
                                      controller: state.tecNamaAsuransiPihakKetiga,
                                      decoration: const InputDecoration(
                                          labelText: "Nama asuransi pihak ketiga"
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.only(top: 20)),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      enabled: true,
                                      controller: state.tecKronologiKejadian,
                                      maxLines: 5,
                                      decoration:  InputDecoration(
                                          labelText: "* Kronologi kejadian",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const Padding(padding: EdgeInsets.only(top: 40)),
                                const Divider(),
                                CheckboxListTile(
                                  title: Text(state.title_pernyataan),
                                  value: state.is_check_pernyataan,
                                  onChanged: (bool? newValue) {
                                    logic.handleCekpernyataan(newValue!);
                                  },
                                  tristate: false,
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                                const Divider(),
                                CheckboxListTile(
                                  title: Text(state.sayaBersedia),
                                  value: state.is_check_saya_bersedia,
                                  onChanged: (bool? newValue) {
                                    logic.handleCekSayaBersedia(newValue!);
                                  },
                                  tristate: false,
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                                const Divider(),
                                const Padding(padding: EdgeInsets.only(top: 10)),
                                const Text(
                                  "Tanda tangan di bawah",
                                  textAlign: TextAlign.center,
                                ),
                                const Padding(padding: EdgeInsets.only(top: 5)),
                                DottedBorder(
                                  color: Colors.grey,
                                  dashPattern: const [8, 4],
                                  strokeWidth: 2,
                                  child: SizedBox(
                                      height: 150,
                                      child: Stack(
                                        children: [
                                          Visibility(
                                              visible: !state.is_ada_riwayat,
                                              child: SfSignaturePad(
                                                key: state.signatureGlobalKey,
                                                backgroundColor: Colors.white,
                                                strokeColor: Colors.black,
                                                minimumStrokeWidth: 3.0,
                                                maximumStrokeWidth: 5.0,
                                              ),
                                          ),
                                          Visibility(
                                              visible: state.is_ada_riwayat,
                                              child: Image.memory(logic.dataFromBase64String(state.base64_tandatangan))
                                          ),
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                icon: const Icon(Icons.clear),
                                                onPressed: () {
                                                  logic.clearSignature();
                                                },
                                              ))
                                        ],
                                      )),
                                ),
                                const Padding(padding: EdgeInsets.only(top: 10)),
                                ElevatedButton(
                                    onPressed: () => logic.submitClaimDetail(),
                                    child: const Text(
                                      "Selanjutnya",
                                      style: TextStyle(color: Colors.white),
                                    ))

                              ],
                            ),
                    ),
            )
          );
        });
  }
}
