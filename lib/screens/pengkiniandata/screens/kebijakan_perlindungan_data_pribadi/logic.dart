import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pengkiniandata/screens/kebijakan_perlindungan_data_pribadi/state.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../helper/Konstan.dart';

class KebijakanPerlindunganDataLogic extends BaseLogic {
  final KebijakanPerlindunganDataState state = KebijakanPerlindunganDataState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // is_loading.value = true;
    initWebView();
  }

  // fungsi untuk membuka halaman web ketika membuka menu ini
  void initWebView() {
    state.controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            is_loading.value = true;
          },
          onPageFinished: (String url) {
            is_loading.value = false;
          },
          onWebResourceError: (WebResourceError error) {
            Get.snackbar(Konstan.tag_error, error.description);
            is_loading.value = false;
          },
        ),
      )
      // ini link untuk ke web jmfi privacy policy
      ..loadRequest(Uri.parse('https://jaccs-mpmfinance.com/id/privacypolicy'));
  }

  void reloadPage() {
    state.controller.reload();
  }
}
