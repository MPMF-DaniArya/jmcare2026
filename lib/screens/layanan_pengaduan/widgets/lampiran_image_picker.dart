import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jmcare/screens/layanan_pengaduan/logic.dart';
import 'package:path/path.dart' as p;

class LampiranImagePicker extends StatefulWidget {
  const LampiranImagePicker({super.key});

  @override
  State<LampiranImagePicker> createState() => _LampiranImagePicker();
}

class _LampiranImagePicker extends State<LampiranImagePicker> {
  final logic = Get.put(LayananPengaduanLogic());
  final state = Get.find<LayananPengaduanLogic>().state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GetBuilder<LayananPengaduanLogic>(
      assignId: true,
      builder: (logic) {
        return Stack(
          children: [
            state.lampiran != null
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.insert_drive_file_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text('1 Gambar telah terpilih')
                            ],
                          ),
                        ),
                        IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              state.lampiran = null;
                              logic.update();
                            }),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () => logic.pickImage(ImageSource.gallery),
                    child: DottedBorder(
                      color: Colors.grey,
                      dashPattern: const [10, 10],
                      strokeWidth: 1,
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Tap disini untuk unggah lampiran',
                                style: textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Maksimal ukuran file unggah: 10MB.',
                                style: textTheme.labelSmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
