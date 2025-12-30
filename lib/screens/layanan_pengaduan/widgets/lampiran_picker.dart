import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/layanan_pengaduan/logic.dart';

class LampiranPicker extends StatefulWidget {
  const LampiranPicker({super.key});

  @override
  State<LampiranPicker> createState() => _LampiranImagePicker();
}

class _LampiranImagePicker extends State<LampiranPicker> {
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
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Icons.insert_drive_file_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: Text(
                                state.lampiran!.files.single.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ))
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
                    onTap: () => logic.pickFile(),
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
