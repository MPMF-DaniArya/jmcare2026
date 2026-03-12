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
    String? currentValue = item['jenisDataTerpilih'];

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
              hint: const Text('---Pilih Jenis Data---'),
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
            Obx(() {
              String displayData =
                  logic.state.formList[index]['dataLama'] ?? "-";

              return TextFormField(
                key: ValueKey("data_saat_ini_$index" + displayData),
                initialValue: displayData,
                readOnly: true,
                maxLines: 4,
                minLines: 1,
                style: textTheme.bodyMedium!.copyWith(color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              );
            }),
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
                RxList<Map<String, dynamic>> dokumenList =
                    formItem['dokumenList'];

                if (dokumenList.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                      color: Colors.green,
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: dokumenList.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, docIndex) {
                            var doc = dokumenList[docIndex];
                            bool isFileExist = doc['lampiran'] != null;
                            bool isWajib = doc['isWajib'];
                            String labelDokumen = doc['label'];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: labelDokumen,
                                      style: textTheme.labelLarge),
                                  if (isWajib)
                                    const TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 14))
                                ])),
                                const SizedBox(height: 6),
                                isFileExist
                                    ? _buildFileUploadedTile(doc['namaFile'],
                                        () => logic.hapusFile(index, docIndex))
                                    : _buildUploadButton(
                                        onTap: () =>
                                            logic.pilihFile(index, docIndex),
                                        isWajib: isWajib)
                              ],
                            );
                          },
                        ),
                      ),
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

  Widget _buildFileUploadedTile(String name, VoidCallback onDelete) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green),
          color: Colors.green.withOpacity(0.05)),
      child: Row(
        children: [
          const Icon(Icons.description, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(child: Text(name, overflow: TextOverflow.ellipsis)),
          IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: onDelete),
        ],
      ),
    );
  }

  Widget _buildUploadButton(
      {required VoidCallback onTap, required bool isWajib}) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.upload_file),
      label: const Text('Pilih Dokumen'),
      style: ElevatedButton.styleFrom(
        backgroundColor: isWajib ? Colors.redAccent : Colors.green,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 40),
      ),
    );
  }
}
