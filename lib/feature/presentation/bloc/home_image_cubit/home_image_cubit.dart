import 'dart:developer';

import 'package:demoproject/core/constants/app_enum.dart';
import 'package:demoproject/core/constants/typedef.dart';
import 'package:demoproject/core/services/service_locator.dart';
import 'package:demoproject/feature/domain/model/image_model.dart';
import 'package:demoproject/feature/domain/repo/image_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_image_state.dart';

class HomeImageCubit extends Cubit<HomeImageState> {
  HomeImageCubit() : super(HomeImageInitial());

  void reset() {
    emit(HomeImageInitial());
  }

  void getImage({required bool isToRefresh}) async {
    if (isToRefresh) {
      emit(
        state.copyWith(apiStatus: APIStatus.loading, imageList: [], page: 1),
      );
    }
    DynamicResponse response = await getIt<ImageRepo>().getHomeImage(
      page: state.page,
    );

    response.fold(
      (l) {
        List<ImageModel> imageList = [...state.imageList];
        // Check if the response is a list or map
        // and handle it accordingly
        // If it's a list, you can iterate through it
        // If it's a map, you can access its keys and values

        try {
          if (l is Map && l['data'] is Map && l['data']['hits'] is List) {
            List<dynamic> data = l['data']['hits'];
            if (data.isNotEmpty) {
              for (var element in data) {
                imageList.add(ImageModel.fromJson(element));
              }
            }
          } else {
            // Handle the case where the response is not a list or map
            // You can throw an error or handle it in a way that makes sense for your app
            // For example:
            throw Exception('Unexpected response format ::: $l');
          }
        } catch (e) {
          log('Error parsing response: $e');
          rethrow;
        }
        emit(
          state.copyWith(
            imageList: imageList,
            apiStatus: APIStatus.success,
            page: imageList.isNotEmpty ? state.page + 1 : state.page,
          ),
        );
      },
      (r) => emit(
        state.copyWith(
          imageList: [...state.imageList],
          apiStatus: APIStatus.error,
          page: state.page,
        ),
      ),
    );
  }
}
