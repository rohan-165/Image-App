import 'package:demoproject/core/services/hive_cache_service.dart';
import 'package:demoproject/feature/data/mixin/image_mixin.dart';
import 'package:demoproject/feature/domain/model/image_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_image_state.dart';

class FavoriteImageCubit extends Cubit<FavoriteImageState> with ImageMixin {
  FavoriteImageCubit() : super(FavoriteImageInitial());

  /// Reset the state of the FavoriteImageCubit to its initial state.
  void reset() {
    emit(FavoriteImageInitial());
  }

  void clearData() {
    HiveCacheService().clearCacheData();
    emit(FavoriteImageInitial());
  }

  /// Add an image to the favorite list
  /// and update the state with the new list of favorite images.
  /// If the image is already in the favorite list, it will not be added again.
  /// The image is identified by its ID, which is an integer.
  /// The favorite images are stored in a list and a set for quick access.
  /// The list contains the actual image objects, while the set contains their IDs.
  void addToFavorite({required ImageModel image}) {
    List<ImageModel> favoriteImages = [...state.favoriteImages];
    Set<int> favoriteImageIds = {...state.favoriteImageIds};

    if (!favoriteImageIds.contains(image.id)) {
      favoriteImages.add(image);
      favoriteImageIds.add(image.id ?? 0);
      addFavoriteImage(image: image);
    }

    emit(
      state.copyWith(
        favoriteImages: favoriteImages,
        favoriteImageIds: favoriteImageIds,
      ),
    );
  }

  /// Remove an image from the favorite list
  /// and update the state with the new list of favorite images.
  /// If the image is not in the favorite list, it will not be removed.
  /// The image is identified by its ID, which is an integer.
  /// The favorite images are stored in a list and a set for quick access.
  void removeFromFavorite({required ImageModel image}) {
    List<ImageModel> favoriteImages = [...state.favoriteImages];
    Set<int> favoriteImageIds = {...state.favoriteImageIds};

    if (favoriteImageIds.contains(image.id)) {
      favoriteImages.removeWhere((element) => element.id == image.id);
      favoriteImageIds.remove(image.id);
      removeImage(imageId: image.id ?? 0);
    }

    emit(
      state.copyWith(
        favoriteImages: favoriteImages,
        favoriteImageIds: favoriteImageIds,
      ),
    );
  }

  /// Retrieve the list of favorite images
  /// and update the state with the new list of favorite images.
  /// The favorite images are stored in a list and a set for quick access.
  /// The list contains the actual image objects, while the set contains their IDs.
  /// The list of favorite images is retrieved from the state.
  /// The set of favorite image IDs is also retrieved from the state.
  void setFavoriteImages() async {
    List<ImageModel> favoriteImages = await getFavoriteImage() ?? [];
    Set<int> favoriteImageIds = await getFavoriteImageIds() ?? {};

    emit(
      state.copyWith(
        favoriteImages: favoriteImages,
        favoriteImageIds: favoriteImageIds,
      ),
    );
  }
}
