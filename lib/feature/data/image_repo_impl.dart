import 'package:demoproject/core/constants/typedef.dart';
import 'package:demoproject/core/services/network_service/api_request.dart';
import 'package:demoproject/core/services/service_locator.dart';
import 'package:demoproject/feature/domain/repo/image_repo.dart';

class ImageRepoImpl extends ImageRepo {
  static const String _endPoint = 'api/?key=49793662-5b2b2cf8a2819ce4a8016973e';

  @override
  FutureDynamicResponse getHomeImage({required int page}) {
    return getIt<ApiRequest>().getResponse(
      endPoint: _endPoint,
      apiMethods: ApiMethods.get,
      queryParams: {"page": page},
    );
  }

  @override
  FutureDynamicResponse getSearchImage({
    required String query,
    required int page,
  }) {
    return getIt<ApiRequest>().getResponse(
      endPoint: _endPoint,
      apiMethods: ApiMethods.get,
      queryParams: {"q": query, "page": page},
    );
  }
}
