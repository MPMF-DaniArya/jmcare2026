import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

class FaqState {
  TextEditingController? tecSearch;
  Map<String, HighlightedWord> words = <String, HighlightedWord>{};

  FaqState(){
    tecSearch = TextEditingController();
  }
}