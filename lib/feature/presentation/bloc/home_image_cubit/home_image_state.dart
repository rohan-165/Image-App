part of 'home_image_cubit.dart';

sealed class HomeImageState extends Equatable {
  final List<ImageModel> imageList;
  final APIStatus apiStatus;
  final int page;
  const HomeImageState({
    required this.imageList,
    required this.apiStatus,
    required this.page,
  });

  HomeImageState copyWith({
    List<ImageModel>? imageList,
    APIStatus? apiStatus,
    int? page,
  }) {
    return HomeImageStateImpl(
      imageList: imageList ?? this.imageList,
      apiStatus: apiStatus ?? this.apiStatus,
      page: page ?? this.page,
    );
  }
}

final class HomeImageStateImpl extends HomeImageState {
  const HomeImageStateImpl({
    required super.imageList,
    required super.apiStatus,
    required super.page,
  });

  @override
  HomeImageState copyWith({
    List<ImageModel>? imageList,
    APIStatus? apiStatus,
    int? page,
  }) {
    return HomeImageStateImpl(
      imageList: imageList ?? this.imageList,
      apiStatus: apiStatus ?? this.apiStatus,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [imageList, apiStatus, page];
}

final class HomeImageInitial extends HomeImageStateImpl {
  HomeImageInitial()
    : super(imageList: <ImageModel>[], apiStatus: APIStatus.initial, page: 1);
}
