import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demoproject/core/extension/widget_extensions.dart';
import 'package:demoproject/core/routes/routes_name.dart';
import 'package:demoproject/core/services/navigation_service.dart';
import 'package:demoproject/core/services/service_locator.dart';
import 'package:demoproject/feature/domain/model/image_model.dart';
import 'package:demoproject/feature/presentation/bloc/favorite_image_cubit/favorite_image_cubit.dart';
import 'package:demoproject/widget/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageWidget extends StatelessWidget {
  final ImageModel image;
  final bool isView;
  const ImageWidget({super.key, required this.image, this.isView = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteImageCubit, FavoriteImageState>(
      builder: (context, fState) {
        return SizedBox(
          height: 250.h,
          width: double.infinity,
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  if (isView) {
                    if (fState.favoriteImageIds.contains(image.id)) {
                      showAlertDialog(
                        onConfirm:
                            () => getIt<FavoriteImageCubit>()
                                .removeFromFavorite(image: image),
                      );
                    }
                  } else {
                    getIt<NavigationService>().navigateTo(
                      RoutesName.imagePreview,
                      arguments: image,
                    );
                  }
                },
                onDoubleTap: () {
                  if (fState.favoriteImageIds.contains(image.id)) {
                    getIt<FavoriteImageCubit>().removeFromFavorite(
                      image: image,
                    );
                  } else {
                    getIt<FavoriteImageCubit>().addToFavorite(image: image);
                  }
                },
                child: CachedNetworkImage(
                  cacheKey: image.id.toString(),
                  imageUrl: image.previewURL ?? '',
                  fit: !isView ? BoxFit.cover : BoxFit.contain,
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
                            fit: !isView ? BoxFit.cover : BoxFit.contain,
                          ),
                        ),
                      ),
                ),
              ),

              Align(
                alignment: Alignment.topRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ), // Blur effect
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38, // Semi-transparent white
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: Colors.white30,
                        ), // Optional border
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
                          () => getIt<FavoriteImageCubit>().removeFromFavorite(
                            image: image,
                          ),
                    );
                  } else {
                    getIt<FavoriteImageCubit>().addToFavorite(image: image);
                  }
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
