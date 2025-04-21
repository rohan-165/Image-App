// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:demoproject/core/utils/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitPopWidget extends StatelessWidget {
  final bool canPop;
  final Widget child;
  ExitPopWidget({super.key, this.canPop = false, required this.child});
  DateTime? _currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        DateTime now = DateTime.now();
        if (_currentBackPressTime == null ||
            now.difference(_currentBackPressTime!) >
                const Duration(seconds: 2)) {
          _currentBackPressTime = now;
          AppToasts().showToast(
            message: "Tap back again  to exit app.",
            backgroundColor: Colors.black,
          );
        } else {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }
      },
      canPop: canPop,
      child: child,
    );
  }
}
