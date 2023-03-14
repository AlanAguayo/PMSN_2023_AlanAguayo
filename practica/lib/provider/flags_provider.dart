import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlagsProvider with ChangeNotifier {
  bool _updatePosts = false;

  getUpdatePosts() => _updatePosts;
  setUpdatePost() {
    this._updatePosts = !this._updatePosts;
    notifyListeners();
  }
}
