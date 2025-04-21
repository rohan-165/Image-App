import 'package:demoproject/core/constants/typedef.dart';

abstract class ImageRepo {
  FutureDynamicResponse getHomeImage({required int page});
  FutureDynamicResponse getSearchImage({
    required String query,
    required int page,
  });
}
