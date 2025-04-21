// ignore: depend_on_referenced_packages

import 'package:demoproject/core/bloc/app_open_cubit.dart';
import 'package:demoproject/core/bloc/internet_cubit.dart';
import 'package:demoproject/core/services/hive_cache_service.dart';
// import 'package:demoproject/core/services/hive_data.dart';
import 'package:demoproject/core/services/navigation_service.dart';
import 'package:demoproject/core/services/network_service/api_manager.dart';
import 'package:demoproject/core/services/network_service/api_request.dart';
import 'package:demoproject/core/services/shared_pref_service.dart';
import 'package:demoproject/feature/data/image_repo_impl.dart';
import 'package:demoproject/feature/domain/repo/image_repo.dart';
import 'package:demoproject/feature/presentation/bloc/favorite_image_cubit/favorite_image_cubit.dart';
import 'package:demoproject/feature/presentation/bloc/home_image_cubit/home_image_cubit.dart';
import 'package:demoproject/feature/presentation/bloc/image_search_cubit/image_search_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<SharedPrefsServices>(SharedPrefsServices());
  getIt.registerSingleton<ApiRequest>(ApiRequestImpl());
  getIt<ApiRequest>().setApiManager(ApiManager());
  getIt.registerSingleton<HiveCacheService>(HiveCacheService());
  // getIt.registerSingleton<HiveData>(HiveDataImpl());

  /// Repository Registration
  getIt.registerSingleton<ImageRepo>(ImageRepoImpl());

  /// Bloc Registration
  getIt.registerSingleton<AppOpenCubit>(AppOpenCubit());
  getIt.registerSingleton<InternetCubit>(InternetCubit());
  getIt.registerSingleton<HomeImageCubit>(HomeImageCubit());
  getIt.registerSingleton<FavoriteImageCubit>(FavoriteImageCubit());
  getIt.registerSingleton<ImageSearchCubit>(ImageSearchCubit());
}
