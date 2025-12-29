import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/esign_blue_screen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/esign/webview/logic.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EsignScreen extends StatelessWidget {
  const EsignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(EsignLogic());
    final state = Get.find<EsignLogic>().state;

    return GetBuilder<EsignLogic>(
        assignId: true,
        builder: (logic) {
          return EsignBlueScreen(
            title: "eSignHub",
            body: WebViewWidget(
              controller: state.wc!,
            ),
          );
        });
  }
}
