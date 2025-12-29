import 'package:flutter/material.dart';
import '../../helper/Komponen.dart';
import '../../helper/Tema.dart';

class EsignBlueScreen extends StatelessWidget {
  final String? title;
  final Widget? body;
  const EsignBlueScreen({super.key, this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Komponen.getAppBarEsign(context, this.title!),
      resizeToAvoidBottomInset: true,
      body: Container(padding: const EdgeInsets.all(10), child: body),
    );
  }
}
