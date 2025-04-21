import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenPadding extends StatelessWidget {
  const ScreenPadding({super.key, this.padding, required this.child});
  final EdgeInsets? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
      child: Transform(
        transform: Matrix4.diagonal3Values(1, 1, 1),
        child: child,
      ),
    );
  }
}
