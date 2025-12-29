import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pdfview/logic.dart';
import 'package:jmcare/screens/pdfview/state.dart';

class PdfviewScreen extends StatelessWidget {
  const PdfviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PdfviewLogic());
    final state = Get.find<PdfviewLogic>().state;
    return GetBuilder<PdfviewLogic>(
      assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "PDF Viewer",
            body: PDFView(
              filePath: state.filePath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              onRender: (_pages) {
                logic.onRender(_pages!);
              },
              onError: (error) {
                logic.logSomething(error.toString());
              },
              onPageError: (page, error) {
                logic.logSomething('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                // _controller.complete(pdfViewController);
              },
            )
          );
        }
    );
  }
}
