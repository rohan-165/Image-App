import 'dart:convert';
import 'dart:developer';

import 'package:demoproject/core/services/hive_cache_service.dart';
import 'package:demoproject/feature/domain/model/image_model.dart';

mixin ImageMixin {
  // Implement the required methods for saving and retrieving user data from Hive database
  /// Adds an image to the favorites list.
  /// [image] is the image model to be added.
  /// Returns a [Future] that completes when the image is added.
  /// Throws an error if the image cannot be added.
  Future<void> addFavoriteImage({required ImageModel image}) {
    try {
      // Implement the saving logic here
      // For example, save Image to Hive database
      String key = image.id.toString();
      String value = jsonEncode(image.toJson());
      return HiveCacheService().saveDataToCache(value: value, key: key);
    } catch (e) {
      log('Error saving user detail to Hive: $e');
      rethrow;
    }
  }

  /// Retrieves the list of favorite images.
  /// Returns a [Future] that completes with the list of favorite images.
  /// Throws an error if the images cannot be retrieved.
  /// [imageId] is the ID of the image to be removed.
  Future<void> removeImage({required int imageId}) {
    try {
      // Implement the logic to remove image from Hive database
      String key = imageId.toString();
      return HiveCacheService().removeCacheDataByKey(key: key);
    } catch (e) {
      log('Error removing image from Hive: $e');
      rethrow;
    }
  }

  /// Retrieves the list of favorite images.
  /// Returns a [Future] that completes with the list of favorite images.
  /// Throws an error if the images cannot be retrieved.

  Future<List<ImageModel>>? getFavoriteImage() async {
    try {
      List<ImageModel> imageList = [];
      // Implement the logic to retrieve images from Hive database
      Map<String, dynamic> responseData =
          await HiveCacheService().getCacheData();
      if (responseData.isNotEmpty) {
        responseData.forEach((key, value) {
          var image = ImageModel.fromJson(jsonDecode(value));
          imageList.add(image);
        });
      }
      return imageList;
    } catch (e) {
      log('Error retrieving favorite images from Hive: $e');
      rethrow;
    }
  }

  Future<Set<int>>? getFavoriteImageIds() async {
    try {
      Set<int> imageIds = {};
      // Implement the logic to retrieve images from Hive database
      Map<String, dynamic> responseData =
          await HiveCacheService().getCacheData();
      log("responseData: $responseData"); // Debugging
      if (responseData.isNotEmpty) {
        responseData.forEach((key, value) {
          imageIds.add(int.parse(key));
        });
      }
      return imageIds;
    } catch (e) {
      log('Error retrieving favorite images ID from Hive: $e');
      rethrow;
    }
  }
}
