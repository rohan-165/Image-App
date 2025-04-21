part of 'favorite_image_cubit.dart';

sealed class FavoriteImageState extends Equatable {
  final List<ImageModel> favoriteImages;
  final Set<int> favoriteImageIds;
  const FavoriteImageState({
    required this.favoriteImages,
    required this.favoriteImageIds,
  });
  FavoriteImageState copyWith({
    List<ImageModel>? favoriteImages,
    Set<int>? favoriteImageIds,
  }) {
    return FavoriteImageStateImpl(
      favoriteImages: favoriteImages ?? this.favoriteImages,
      favoriteImageIds: favoriteImageIds ?? this.favoriteImageIds,
    );
  }
}

final class FavoriteImageStateImpl extends FavoriteImageState {
  const FavoriteImageStateImpl({
    required super.favoriteImages,
    required super.favoriteImageIds,
  });
  @override
  FavoriteImageState copyWith({
    List<ImageModel>? favoriteImages,
    Set<int>? favoriteImageIds,
  }) {
    return FavoriteImageStateImpl(
      favoriteImages: favoriteImages ?? this.favoriteImages,
      favoriteImageIds: favoriteImageIds ?? this.favoriteImageIds,
    );
  }

  @override
  List<Object?> get props => [favoriteImages, favoriteImageIds];
}

final class FavoriteImageInitial extends FavoriteImageStateImpl {
  FavoriteImageInitial() : super(favoriteImages: [], favoriteImageIds: {});
}
