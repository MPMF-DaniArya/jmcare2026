import 'package:flutter/material.dart';

class RegisterpinState{

  TextEditingController? tecPin1;
  TextEditingController? tecPin2;

  FocusNode focusNodePin2 = FocusNode();

  RegisterpinState(){
    tecPin1 = TextEditingController();
    tecPin2 = TextEditingController();
  }
}