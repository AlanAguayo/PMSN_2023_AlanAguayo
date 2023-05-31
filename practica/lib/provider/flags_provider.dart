import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class FlagsProvider with ChangeNotifier {
  bool _update = false;

  getUpdate() => _update;
  setUpdate() {
    this._update = !this._update;
    notifyListeners();
  }
}
