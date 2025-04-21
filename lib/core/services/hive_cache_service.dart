import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveCacheService {
  final String _cacheKey = "reel-cache";

  final List<Box> _boxList = [];

  // Private constructor
  HiveCacheService._privateConstructor();

  // Singleton instance
  static final HiveCacheService _instance =
      HiveCacheService._privateConstructor();

  // Factory constructor to return the singleton instance
  factory HiveCacheService() {
    return _instance;
  }

  /// ==================== LOGIC TO INITIALIZE HIVE ===================================
  /// Initializes the Hive database.
  /// [dirPath] is the directory path where the Hive database will be stored.
  /// Returns a [Future] that completes when the database is initialized.
  /// Throws an error if the initialization fails.
  /// This method is called to set up the Hive database for caching data.
  /// It checks the platform (iOS or Android) and sets the directory path accordingly.
  /// It then initializes Hive and opens a box for caching data.
  /// The box is stored in the [_boxList] for later access.
  /// If an error occurs during initialization, it logs the error message.
  Future<void> initCacheService() async {
    try {
      String dirPath =
          Platform.isIOS
              ? (await getApplicationSupportDirectory()).path
              : (await getApplicationDocumentsDirectory()).path;

      Hive.init(dirPath);
      _boxList.add(await Hive.openBox(_cacheKey));
    } catch (e) {
      log("::: Hive Initialization Error ::: [Local Stogare] :::");
    }
  }

  /// ==================== LOGIC TO GENERATE, DELETE & UPDATE UNIQUE KEYS ===================================
  /// Save data to cache
  /// [value] is the data to be saved.
  /// [key] is the key under which the data will be stored.
  /// Returns a [Future] that completes when the data is saved.
  /// Throws an error if the data cannot be saved.
  /// This method saves data to the Hive database using a unique key.
  /// It first retrieves the existing cache data from the box.
  /// If the cache data is not empty, it decodes the JSON data into a map.
  /// It then adds the new data to the map and encodes it back to JSON format.
  /// Finally, it saves the updated data back to the box.
  /// If an error occurs during the saving process, it logs the error message.

  Future<void> saveDataToCache({
    required dynamic value,
    required String key,
  }) async {
    try {
      Map<String, dynamic> cacheData = {};

      String? cacheKeyData = _boxList.first.get(_cacheKey);
      if (cacheKeyData != null && cacheKeyData.isNotEmpty) {
        final decoded = jsonDecode(cacheKeyData);
        if (decoded is Map<String, dynamic>) {
          cacheData = decoded;
        } else {
          log("Decoded cache is not a Map. Found: ${decoded.runtimeType}");
        }
      }

      cacheData[key] = value;
      await Future.delayed(Duration(milliseconds: 100));
      await _boxList.first.put(_cacheKey, jsonEncode(cacheData));
    } catch (e, stacktrace) {
      log(
        "::: Can't Save Data To Hive ::: [NetworkCacheService] ::: $e\n$stacktrace",
      );
      rethrow;
    }
  }

  /// ==================== LOGIC TO GET ALL DATA ===================================
  /// Get all data from cache
  /// Returns a [Future] that completes with the cached data.
  /// Throws an error if the data cannot be retrieved.
  /// If the cache is empty, an empty map is returned.
  /// If the cache contains data, it is decoded from JSON format.
  Future<Map<String, dynamic>> getCacheData() async {
    try {
      final cacheKeyData = await _boxList.first.get(_cacheKey) as String?;
      // log("cacheKeyData: $cacheKeyData");

      if (cacheKeyData?.isNotEmpty ?? false) {
        try {
          final responseData =
              jsonDecode(cacheKeyData!) as Map<String, dynamic>;
          // log("responseData: $responseData");
          return responseData;
        } catch (e) {
          log("Error decoding JSON: $e");
        }
      }
    } catch (e) {
      log("::: Can't Return Data From Hive ::: [Local Storage] ::: Error: $e");
    }
    return {};
  }

  /// ==================== LOGIC TO GET UNIQUE KEYS ===================================
  /// Get data from cache by key
  /// [key] is the key of the data to be retrieved.
  /// Returns the data associated with the key, or an empty map if not found.
  /// Throws an error if the data cannot be retrieved.
  Future<dynamic> getCacheDataByKey({required String key}) async {
    try {
      Map<String, dynamic> cachedData = {};

      String? cacheKeyData = _boxList.first.get(_cacheKey);
      // log("cacheKeyData: $cacheKeyData"); // Debugging

      if (cacheKeyData != null && cacheKeyData.isNotEmpty) {
        try {
          Map<String, dynamic> responseData = jsonDecode(cacheKeyData);
          // log("responseData: $responseData"); // Debugging

          if (responseData.containsKey(key)) {
            var data = responseData[key];

            return data;
          }
        } catch (e) {
          log("Error decoding JSON: $e");
        }
      }
      return cachedData;
    } catch (e) {
      log("::: Can't Return Data From Hive ::: [Local Storage] ::: Error: $e");
      return {};
    }
  }

  /// ==================== LOGIC TO DELETE UNIQUE KEYS ===================================
  /// Remove data from cache by key
  /// [key] is the key of the data to be removed.
  /// Returns a [Future] that completes when the data is removed.
  /// Throws an error if the data cannot be removed.
  Future<void> removeCacheDataByKey({required String key}) async {
    try {
      String? cacheKeyData = _boxList.first.get(_cacheKey);
      // log("cacheKeyData: $cacheKeyData"); // Debugging

      if (cacheKeyData != null && cacheKeyData.isNotEmpty) {
        try {
          Map<String, dynamic> responseData = jsonDecode(cacheKeyData);
          // log("responseData: $responseData"); // Debugging

          if (responseData.containsKey(key)) {
            responseData.remove(key);
            await _boxList.first.put(_cacheKey, jsonEncode(responseData));
          }
        } catch (e) {
          log("Error decoding JSON: $e");
        }
      }
    } catch (e) {
      log("::: Can't Remove Data From Hive ::: [Local Storage] ::: Error: $e");
      rethrow;
    }
  }

  /// ==================== LOGIC TO CLEAR ALL DATA ===================================
  /// Clear all data from cache
  /// Returns a [Future] that completes when the data is cleared.
  /// Throws an error if the data cannot be cleared.
  /// This method clears all data from the Hive database.
  /// It removes all entries from the box and clears the cache.
  /// If an error occurs during the clearing process, it logs the error message.
  Future<void> clearCacheData() async {
    try {
      await _boxList.first.clear();
    } catch (e) {
      log("::: Error Raised During Cache Data Clear ::: [Local Stogare] :::");
    }
  }
}
