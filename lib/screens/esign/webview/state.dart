import 'package:flutter/material.dart';
import 'package:jmcare/helper/Endpoint.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Esignstate {
  String param = Endpoint.TAG_ESIGN_PORTAL;
  WebViewController? wc;

  EsignState() {
    wc = WebViewController(
      onPermissionRequest: (WebViewPermissionRequest request) => request.grant()
    );
  }
}
