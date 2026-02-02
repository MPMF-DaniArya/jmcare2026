import 'package:flutter/material.dart';

class RowKetentuanPengkinian extends StatelessWidget {
  const RowKetentuanPengkinian(
      {super.key, required this.ketentuan, required this.textTheme});

  final String ketentuan;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 24,
            color: Colors.green,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              ketentuan,
              style: textTheme.bodyMedium,
            ),
          )
        ]);
  }
}
