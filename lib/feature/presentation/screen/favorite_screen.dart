import 'package:demoproject/core/extension/widget_extensions.dart';
import 'package:demoproject/core/services/service_locator.dart';
import 'package:demoproject/feature/presentation/bloc/favorite_image_cubit/favorite_image_cubit.dart';
import 'package:demoproject/feature/presentation/widget/grid_view_widget.dart';
import 'package:demoproject/widget/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteImageCubit, FavoriteImageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorite Images'),
            automaticallyImplyLeading: true,
            actions: [
              if (state.favoriteImages.isNotEmpty) ...{
                Icon(Icons.cancel, size: 30.sp)
                    .padRight(right: 10.w)
                    .onTap(
                      () => showAlertDialog(
                        message:
                            'Are you sure you want to clear all favorite images?',
                        onConfirm:
                            () => getIt<FavoriteImageCubit>().clearData(),
                      ),
                    ),
              },
            ],
          ),
          body:
              (state.favoriteImages.isEmpty)
                  ? const Center(
                    child: Text('No favorite images yet!'),
                  ).padHorizontal(horizontal: 10.w)
                  : GridViewWidget(
                    imageList: state.favoriteImages,
                  ).padHorizontal(horizontal: 10.w),
        );
      },
    );
  }
}
