import 'package:demoproject/core/routes/routes_name.dart';
import 'package:demoproject/feature/domain/model/image_model.dart';
import 'package:demoproject/feature/presentation/screen/favorite_screen.dart';
import 'package:demoproject/feature/presentation/screen/home_screen.dart';
import 'package:demoproject/feature/presentation/screen/image_preview.dart';
import 'package:demoproject/feature/presentation/screen/search_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    Object? argument = settings.arguments;

    switch (settings.name) {
      case RoutesName.favoriteScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const FavoriteScreen(),
        );
      case RoutesName.homeScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );
      case RoutesName.imagePreview:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ImagePreview(image: argument as ImageModel),
        );
      case RoutesName.searchScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SearchScreen(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const HomeScreen(),
        );
    }
  }
}
