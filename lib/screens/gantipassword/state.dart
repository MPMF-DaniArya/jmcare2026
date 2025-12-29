import 'package:jmcare/screens/base/base_state.dart';
import 'package:flutter/material.dart';

class GantipasswordState extends BaseState {

  TextEditingController tecOldpassword = TextEditingController();
  TextEditingController tecNewpassword = TextEditingController();
  TextEditingController tecUlangpassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  GantipasswordState(){

  }

}