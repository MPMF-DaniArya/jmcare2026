import 'package:flutter/material.dart';

class RowDetailPermintaan extends StatelessWidget {
  const RowDetailPermintaan(
      {super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Expanded(
        flex: 1,
        child: Text(
          label,
          textAlign: TextAlign.start,
          style: textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(
        width: 32,
      ),
      Expanded(
        flex: 2,
        child: Text(
          value.isNotEmpty ? ': $value' : ': -',
          style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }
}
