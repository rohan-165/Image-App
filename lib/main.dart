import 'dart:io';

import 'package:demoproject/core/bloc/app_open_cubit.dart';
import 'package:demoproject/core/bloc/internet_cubit.dart';
import 'package:demoproject/core/routes/route_generator.dart';
import 'package:demoproject/core/services/hive_cache_service.dart';
import 'package:demoproject/core/services/navigation_service.dart';
import 'package:demoproject/core/services/service_locator.dart';
import 'package:demoproject/core/services/shared_pref_service.dart';
import 'package:demoproject/core/utils/app_toast.dart';
import 'package:demoproject/feature/presentation/bloc/favorite_image_cubit/favorite_image_cubit.dart';
import 'package:demoproject/feature/presentation/bloc/home_image_cubit/home_image_cubit.dart';
import 'package:demoproject/feature/presentation/bloc/image_search_cubit/image_search_cubit.dart';
import 'package:demoproject/feature/presentation/screen/home_screen.dart';
import 'package:demoproject/widget/internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the service manager and Local Storage
  await setupLocator().then((value) {
    getIt<SharedPrefsServices>().init();
    getIt<HiveCacheService>().initCacheService();
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime? _currentBackPressTime;
  final ValueNotifier<bool> _isToHide = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>.value(value: getIt<InternetCubit>()),
        BlocProvider<AppOpenCubit>.value(value: getIt<AppOpenCubit>()),
        BlocProvider<HomeImageCubit>.value(value: getIt<HomeImageCubit>()),
        BlocProvider<FavoriteImageCubit>.value(
          value: getIt<FavoriteImageCubit>(),
        ),
        BlocProvider<ImageSearchCubit>.value(value: getIt<ImageSearchCubit>()),
      ],
      child: PopScope(
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
        canPop: false,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              Expanded(
                child: ScreenUtilInit(
                  designSize: Size(
                    MediaQuery.sizeOf(context).width,
                    MediaQuery.sizeOf(context).height,
                  ),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (context, child) {
                    return Material(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: MaterialApp(
                          debugShowCheckedModeBanner: false,
                          navigatorKey: NavigationService.navigatorKey,
                          onGenerateRoute: RouteGenerator.generateRoute,
                          home: HomeScreen(),
                          title: 'Demo App',
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// InternetConnectionMsgWidget
              ValueListenableBuilder(
                valueListenable: _isToHide,
                builder: (_, isToHide, __) {
                  return BlocBuilder<AppOpenCubit, bool>(
                    builder: (context, appOpenState) {
                      return InternetConnectionWidget(
                        callBack: (isConnected) {
                          if (isConnected) {
                            if (appOpenState) {
                              _isToHide.value = true;
                            } else {
                              // Call your method after 3 seconds
                              Future.delayed(Duration(seconds: 3), () {
                                // Set showWidget to true after 3 seconds
                                _isToHide.value = true;
                              });
                            }
                          } else {
                            _isToHide.value = false;
                          }
                        },
                        offlineWidget: Align(
                          alignment: Alignment.bottomCenter,
                          child: InternetConnectionMsgWidget(
                            isConnected: false,
                          ),
                        ),
                        onlineWidget: Align(
                          alignment: Alignment.bottomCenter,
                          child:
                              isToHide
                                  ? SizedBox.fromSize()
                                  : InternetConnectionMsgWidget(
                                    isConnected: true,
                                  ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
