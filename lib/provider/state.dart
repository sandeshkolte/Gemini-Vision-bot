import 'package:flutter/material.dart';

class StateProvider with ChangeNotifier {
  String _text = '';
  String get text => _text;

  showOutput(output) {
    _text = output;
    notifyListeners();
  }
}
