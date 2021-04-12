import 'package:flutter/material.dart';

class ModalController extends ChangeNotifier {
  TextEditingController fromController = TextEditingController();
  TextEditingController whereController = TextEditingController();
  String oldFromValue = '';
  String oldWhereValue = '';
  

  void setWhere() {
    if (whereController.text != oldWhereValue) {

    }
  }
}
