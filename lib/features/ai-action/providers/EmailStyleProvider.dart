import 'package:flutter/material.dart';

class EmailStyleProvider with ChangeNotifier {
  String _length = "Long";
  String _formality = "Neutral";
  String _tone = "Friendly";

  String get length => _length;
  String get formality => _formality;
  String get tone => _tone;

  void setLength(String length) {
    _length = length;
    notifyListeners();
  }
  void setFormality(String formality) {
    _formality = formality;
    notifyListeners();
  }
  void setTone(String tone) {
    _tone = tone;
    notifyListeners();
  }
}
