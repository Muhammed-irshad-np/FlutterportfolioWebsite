import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myportfolio/utils/utils.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    updateTime();
  }
  bool _iscodeblockHovered = false;
  bool get iscodeblockHovered => _iscodeblockHovered;
  bool get toggleOnlineButton => _toggleOnlineButton;
  bool _toggleOnlineButton = true;
  bool _isLocationHovered = false;
  bool get islocationhovered => _isLocationHovered;
  bool _istimeHover = false;
  bool get istimehover => _istimeHover;
  bool get isCountryHover => _isCountryHover;
  bool _isCountryHover = false;
  late AnimationController animationController;

  void updateToggleButton() {
    _toggleOnlineButton = !_toggleOnlineButton;
    notifyListeners();
  }

  String currentTime = "";
  void updateTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime = getCurrentTimeinIst();
      notifyListeners();
    });
  }

  void isLoacationHovered(bool value) {
    _isLocationHovered = value;
    notifyListeners();
  }

  void updateTimeHover(bool isupdate) {
    _istimeHover = isupdate;
    notifyListeners();
  }

  void updateCountryHover(bool value) {
    _isCountryHover = value;
    notifyListeners();
  }

  void toggleIscodeBlockHovered(bool value) {
    _iscodeblockHovered = value;
    notifyListeners();
  }
}