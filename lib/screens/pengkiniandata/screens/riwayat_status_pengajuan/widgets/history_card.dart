import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/GetRiwayatPpdRespon.dart';

class HistoryCard extends StatelessWidget {
  final GetRiwayatPpdRespon data;

  const HistoryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String tanggalPengkinian = Fungsi.formatTanggalOnly(data.createDate);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Get.toNamed(
            Konstan.rute_detail_status_pengkinian_data_pribadi,
            arguments: {
              'noTiket': data.noTiket,
              'tanggalPengkinian': tanggalPengkinian,
              'status': data.status,
            }),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.noTiket ?? '-',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  _buildStatusChip(data.status ?? '-'),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                data.tipePerubahanData!.isNotEmpty ? data.tipePerubahanData! : '-',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                "Pengajuan: $tanggalPengkinian",
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg;
    Color text;

    if (status == 'BARU') {
      bg = Colors.green.shade50;
      text = Colors.green;
    } else if (status == 'DIPROSES') {
      bg = Colors.orangeAccent;
      text = Colors.white;
    } else if (status == 'DITOLAK') {
      bg = Colors.red.shade50;
      text = Colors.red;
    } else {
      bg = Colors.grey.shade100;
      text = Colors.grey.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style:
            TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
