import 'package:demoproject/feature/domain/model/image_model.dart';
import 'package:demoproject/feature/presentation/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridViewWidget extends StatelessWidget {
  final List<ImageModel> imageList;
  const GridViewWidget({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: imageList.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemBuilder: (context, index) => ImageWidget(image: imageList[index]),
    );
  }
}
