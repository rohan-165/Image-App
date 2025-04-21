import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demoproject/core/extension/build_context_extension.dart';
import 'package:demoproject/core/extension/widget_extensions.dart';
import 'package:demoproject/core/services/service_locator.dart';
import 'package:demoproject/feature/domain/model/image_model.dart';
import 'package:demoproject/feature/presentation/bloc/favorite_image_cubit/favorite_image_cubit.dart';
import 'package:demoproject/widget/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageWidget extends StatelessWidget {
  final ImageModel image;
  const ImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteImageCubit, FavoriteImageState>(
      builder: (context, fState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200.h,
              width: double.infinity,
              child: CachedNetworkImage(
                cacheKey: image.id.toString(),
                imageUrl: image.previewURL ?? '',
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Center(
                      child: Image.network(
                        'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=',
                        fit: BoxFit.cover,
                      ),
                    ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder:
                    (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              ).onTap(() {
                if (fState.favoriteImageIds.contains(image.id)) {
                  showAlertDialog(
                    onConfirm:
                        () => getIt<FavoriteImageCubit>().removeFromFavorite(
                          image: image,
                        ),
                  );
                } else {
                  getIt<FavoriteImageCubit>().addToFavorite(image: image);
                }
              }),
            ),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        image.user ?? '',
                        style: context.textTheme.bodyLarge,
                      ).padBottom(bottom: 5.h),
                      Text("Size : ${formatBytesToMB(image.imageSize ?? 0)}"),
                    ],
                  ),
                ),
                _fav(fState: fState),
              ],
            ).padTop(top: 5.h),
          ],
        );
      },
    );
  }

  Widget _fav({required FavoriteImageState fState}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur effect
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black38, // Semi-transparent white
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: Colors.white30), // Optional border
          ),
          child: Icon(
            (fState.favoriteImageIds.contains(image.id))
                ? Icons.favorite
                : Icons.favorite_border,
            color:
                (fState.favoriteImageIds.contains(image.id))
                    ? Colors.red
                    : Colors.white,
            size: 25.sp,
          ).padAll(value: 2.w),
        ),
      ),
    ).padAll(value: 5.w).onTap(() {
      if (fState.favoriteImageIds.contains(image.id)) {
        showAlertDialog(
          onConfirm:
              () =>
                  getIt<FavoriteImageCubit>().removeFromFavorite(image: image),
        );
      } else {
        getIt<FavoriteImageCubit>().addToFavorite(image: image);
      }
    });
  }

  String formatBytesToMB(int bytes) {
    double mb = bytes / (1024 * 1024);
    return "${mb.toStringAsFixed(2)} MB";
  }
}
