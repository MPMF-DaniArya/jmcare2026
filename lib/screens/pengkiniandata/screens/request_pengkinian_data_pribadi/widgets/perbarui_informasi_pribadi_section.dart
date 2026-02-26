import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/pengkiniandata/screens/request_pengkinian_data_pribadi/logic.dart';

import '../../../../../custom/container_menu.dart';
import '../../../../../helper/Konstan.dart';

class PerbaruiInformasiPribadiSection extends StatelessWidget {
  const PerbaruiInformasiPribadiSection(
      {super.key,
      required this.textTheme,
      required this.logic,
      required this.index});

  final TextTheme textTheme;
  final RequestPengkinianDataPribadiLogic logic;
  final int index;

  @override
  Widget build(BuildContext context) {
    final item = logic.state.formList[index];
    List<String> pilihan = logic.getJenisDataTersedia(index);
    String? currentValue = logic.state.formList[index]['jenisDataTerpilih'];

    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: ContainerMenu(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Permintaan Perubahan #${index + 1}",
                  style: textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                if (index > 0)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => logic.hapusForm(index),
                  )
              ],
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Jenis Data',
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const TextSpan(
                      text: " *",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontFamily: Konstan.tag_default_font)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: currentValue,
              isExpanded: true,
              hint: const Text(
                '---Pilih Jenis Data---',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pilih jenis data terlebih dahulu';
                }
                return null;
              },
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              items: pilihan.map((String val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              }).toList(),
              onChanged: (value) {
                logic.updateJenisDataTerpilih(index, value);
              },
            ),
            const SizedBox(height: 16),
            Text('Data Saat Ini',
                style: textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: 'Testing',
              readOnly: true,
              maxLines: 4,
              minLines: 1,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Perubahan Data',
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const TextSpan(
                      text: " *",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontFamily: Konstan.tag_default_font)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: item['tecDataBaru'],
              minLines: 1,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Data perubahan tidak boleh kosong';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                hintText: 'Masukkan data baru',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            GetBuilder<RequestPengkinianDataPribadiLogic>(
              builder: (logic) {
                final formItem = logic.state.formList[index];
                FilePickerResult? lampiran = formItem['lampiran'];
                String namaFile = formItem['namaFile'] ?? "";
                
                bool isWajibUploadDokumen =
                    logic.jenisDataWajibUploadDokumen.contains(currentValue);

                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                      color: isWajibUploadDokumen ? Colors.redAccent : Colors.green,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Unggah Dokumen Pendukung',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface)),
                            if (isWajibUploadDokumen)
                              const TextSpan(
                                  text: " *",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontFamily: Konstan.tag_default_font)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Unggah dokumen pendukung sebagai bukti perubahan.',
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.8)),
                      ),
                      const SizedBox(height: 16),
                      lampiran != null
                          ? Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  )),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(
                                            Icons.insert_drive_file_outlined),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                            child: Text(
                                          namaFile,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ))
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        logic.hapusFile(index);
                                      }),
                                ],
                              ),
                            )
                          : ElevatedButton.icon(
                              onPressed: () => logic.pilihFile(index),
                              icon: const Icon(Icons.upload_sharp),
                              label: const Text('Pilih Dokumen'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isWajibUploadDokumen
                                    ? Colors.redAccent
                                    : Colors.green,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 45),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                      const SizedBox(height: 8),
                      lampiran != null
                          ? Text('Status: Dokumen berhasil diunggah.',
                              style: textTheme.labelMedium!.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.8)))
                          : Text('Status: Belum ada dokumen yang diunggah.',
                              style: textTheme.labelMedium!.copyWith(
                                  color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.8))),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
