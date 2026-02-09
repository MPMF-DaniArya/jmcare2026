import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Konstan.dart';

import '../state.dart';

class HistoryCard extends StatelessWidget {
  final HistoryModel data;

  const HistoryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                data.id,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              _buildStatusChip(data.status),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data.title,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            "Pengajuan: ${data.date}",
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              Get.toNamed(Konstan.rute_detail_status_pengkinian_data_pribadi,
                  arguments: data);
            },
            icon: const Icon(Icons.remove_red_eye_outlined,
                size: 16, color: Colors.green),
            label: const Text("Lihat Detail",
                style: TextStyle(color: Colors.green)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.green),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              minimumSize: const Size(0, 32),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg;
    Color text;

    if (status == 'Selesai') {
      bg = Colors.green.shade50;
      text = Colors.green;
    } else if (status == 'Ditolak') {
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
