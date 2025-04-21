import 'package:demoproject/core/extension/widget_extensions.dart';
import 'package:demoproject/feature/domain/model/image_model.dart';
import 'package:demoproject/feature/presentation/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePreview extends StatelessWidget {
  final ImageModel image;
  const ImagePreview({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: ImageWidget(image: image, isView: true),
      ).padHorizontal(horizontal: 10.h).padVertical(vertical: 10.h),
    );
  }
}
