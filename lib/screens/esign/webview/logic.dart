import 'package:flutter/material.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/esign/webview/state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class EsignLogic extends BaseLogic {
  final Esignstate state = Esignstate();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments['detail'] != null) {
      final detail = Get.arguments['detail'];
      state.param = detail;
    }

    initWebView();
  }

  void initWebView() async {

    late final PlatformWebViewControllerCreationParams params;
    params = WebViewPlatform.instance is WebKitWebViewPlatform
        ? WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true, mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{})
        : const PlatformWebViewControllerCreationParams();
    state.wc = WebViewController.fromPlatformCreationParams(
      params,
      onPermissionRequest: (request) {
        request.grant();
      },
    );


    await state.wc?.setJavaScriptMode(JavaScriptMode.unrestricted);
    await state.wc?.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );

    await state.wc?.loadRequest(Uri.parse(state.param));
  }
}
