import 'package:demoproject/core/constants/app_enum.dart';
import 'package:demoproject/core/extension/widget_extensions.dart';
import 'package:demoproject/core/routes/routes_name.dart';
import 'package:demoproject/core/services/navigation_service.dart';
import 'package:demoproject/core/services/service_locator.dart';
import 'package:demoproject/core/utils/decore_utils.dart';
import 'package:demoproject/feature/presentation/bloc/favorite_image_cubit/favorite_image_cubit.dart';
import 'package:demoproject/feature/presentation/bloc/home_image_cubit/home_image_cubit.dart';
import 'package:demoproject/feature/presentation/widget/grid_view_widget.dart';
import 'package:demoproject/widget/custom_pull_to_refresh_widget.dart';
import 'package:demoproject/widget/exit_pop_widget.dart';
import 'package:demoproject/widget/screen_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getIt<HomeImageCubit>().getImage(isToRefresh: true);

    Future.delayed(const Duration(seconds: 3), () {
      getIt<FavoriteImageCubit>().setFavoriteImages();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExitPopWidget(
      child: Scaffold(
        appBar: AppBar(
          title: TextFormField(
            onTap: () {
              getIt<NavigationService>().navigateTo(RoutesName.searchScreen);
            },
            readOnly: true,
            decoration: inputDecoration(
              context: context,
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite, size: 30.w),
              onPressed: () {
                getIt<NavigationService>().navigateTo(
                  RoutesName.favoriteScreen,
                );
              },
            ),
          ],
        ),
        body: ScreenPadding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: BlocBuilder<HomeImageCubit, HomeImageState>(
            builder: (context, state) {
              if (state.apiStatus == APIStatus.loading ||
                  state.apiStatus == APIStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.apiStatus == APIStatus.error) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Error loading images').padBottom(bottom: 10.h),
                      ElevatedButton(
                        onPressed:
                            () => getIt<HomeImageCubit>().getImage(
                              isToRefresh: true,
                            ),
                        child: const Text("Try Again"),
                      ),
                    ],
                  ),
                );
              } else if (state.apiStatus == APIStatus.success &&
                  state.imageList.isNotEmpty) {
                return CustomPullToRefreshWidget(
                  onRefresh: () {
                    getIt<HomeImageCubit>().getImage(isToRefresh: true);
                  },
                  onLoading: () {
                    getIt<HomeImageCubit>().getImage(isToRefresh: false);
                  },

                  child: GridViewWidget(imageList: state.imageList),
                );
              } else {
                return Center(child: Text('No images available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
