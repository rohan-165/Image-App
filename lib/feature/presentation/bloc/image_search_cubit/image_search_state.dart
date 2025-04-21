part of 'image_search_cubit.dart';

sealed class ImageSearchState extends Equatable {
  final List<ImageModel> images;
  final APIStatus status;
  final int page;
  final String query;
  const ImageSearchState({
    required this.images,
    required this.status,
    required this.page,
    required this.query,
  });

  ImageSearchState copyWith({
    List<ImageModel>? images,
    APIStatus? status,
    int? page,
    String? query,
  }) {
    return ImageSearchStateImpl(
      images: images ?? this.images,
      status: status ?? this.status,
      page: page ?? this.page,
      query: query ?? this.query,
    );
  }
}

final class ImageSearchStateImpl extends ImageSearchState {
  const ImageSearchStateImpl({
    required super.images,
    required super.status,
    required super.page,
    required super.query,
  });
  @override
  ImageSearchState copyWith({
    List<ImageModel>? images,
    APIStatus? status,
    int? page,
    String? query,
  }) {
    return ImageSearchStateImpl(
      images: images ?? this.images,
      status: status ?? this.status,
      page: page ?? this.page,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [images, status, page];
}

final class ImageSearchInitial extends ImageSearchStateImpl {
  ImageSearchInitial()
    : super(
        images: <ImageModel>[],
        status: APIStatus.initial,
        page: 1,
        query: '',
      );
}
