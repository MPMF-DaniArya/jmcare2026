import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/pengkiniandata/screens/kebijakan_perlindungan_data_pribadi/logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/kebijakan_perlindungan_data_pribadi/state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KebijakanPerlindunganDataScreen extends StatelessWidget {
  const KebijakanPerlindunganDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final KebijakanPerlindunganDataLogic logic =
        Get.put(KebijakanPerlindunganDataLogic());
    final KebijakanPerlindunganDataState state =
        Get.find<KebijakanPerlindunganDataLogic>().state;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => logic.reloadPage(),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: state.controller),
          Obx(() => logic.is_loading.value
              ? Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
