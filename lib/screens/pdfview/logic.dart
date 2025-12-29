import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/pdfview/state.dart';

class PdfviewLogic extends BaseLogic {

  final PdfviewState state = PdfviewState();
  var obxPages = 0.obs;
  var obxIsReady = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //get path pdf
    final detail = Get.arguments['detail'];
    state.filePath = detail;
  }

  void onRender(int pages){
    obxPages.value = pages;
    obxIsReady.value = true;
  }
  void logSomething(String s){
    Fungsi.errorToast(s);
    print("Error_open_POF : " + s);
  }
  void onComplete(PDFViewController pdfViewController){
    state.completer?.complete(pdfViewController);
  }
}