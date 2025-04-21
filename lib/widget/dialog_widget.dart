import 'package:demoproject/core/extension/build_context_extension.dart';
import 'package:demoproject/core/extension/widget_extensions.dart';
import 'package:demoproject/core/services/navigation_service.dart';
import 'package:demoproject/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showAlertDialog({String? message, required VoidCallback onConfirm}) {
  showDialog(
    context: getIt<NavigationService>().getNavigationContext(),
    builder: (context) {
      return ConfirmDialog(
        title: "Alert",
        message: message ?? "Do you want to remove from favorite list?",
        onConfirm: () {
          onConfirm();
          getIt<NavigationService>().pop(); // Close dialog
        },
        onCancel: () {
          getIt<NavigationService>().pop(); // Just close
        },
      );
    },
  );
}

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,

      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ).padBottom(bottom: 20.h),
          Text(message),
        ],
      ),
      actions: [
        TextButton(onPressed: onCancel, child: const Text("Cancel")),
        ElevatedButton(onPressed: onConfirm, child: const Text("OK")),
      ],
    );
  }
}
