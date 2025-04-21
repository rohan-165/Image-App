import 'dart:developer';

import 'package:demoproject/core/constants/app_enum.dart';
import 'package:demoproject/core/constants/typedef.dart';
import 'package:demoproject/core/services/service_locator.dart';
import 'package:demoproject/feature/domain/model/image_model.dart';
import 'package:demoproject/feature/domain/repo/image_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_search_state.dart';

class ImageSearchCubit extends Cubit<ImageSearchState> {
  ImageSearchCubit() : super(ImageSearchInitial());

  void reset() {
    emit(ImageSearchInitial());
  }

  void searchImage({required String query, bool isToRefresh = false}) async {
    if (isToRefresh) {
      emit(state.copyWith(status: APIStatus.loading, images: [], page: 1));
    }
    DynamicResponse response = await getIt<ImageRepo>().getSearchImage(
      query: query,
      page: state.page,
    );

    response.fold(
      (l) {
        List<ImageModel> imageList = [...state.images];
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
            images: imageList,
            status: APIStatus.success,
            page: imageList.isNotEmpty ? state.page + 1 : state.page,
            query: query,
          ),
        );
      },
      (r) => emit(
        state.copyWith(
          images: [...state.images],
          status: APIStatus.error,
          page: state.page,
          query: query,
        ),
      ),
    );
  }
}
