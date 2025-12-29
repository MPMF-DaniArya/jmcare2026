import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfviewState {

  Completer<PDFViewController>? completer;
  int? currentPage = 0;
  String errorMessage = "";
  String filePath = "";

  PdfviewState(){
    completer = Completer<PDFViewController>();
    currentPage = 0;
    errorMessage = "";
  }

}