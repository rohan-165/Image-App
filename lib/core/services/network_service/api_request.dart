// ignore_for_file: unused_field

import 'package:dartz/dartz.dart';
import 'package:demoproject/core/common/failure_state.dart';
import 'package:demoproject/core/constants/typedef.dart';
import 'package:demoproject/core/utils/app_toast.dart';
import 'package:dio/dio.dart';

import 'api_manager.dart';

enum ApiMethods { get, post, delete, put }

abstract class ApiRequest {
  late ApiManager _apiManager;

  void setApiManager(ApiManager apiManager);

  ApiManager get apiManager;

  FutureDynamicResponse decodeHttpRequestResponse(
    Response? response, {
    String message = "",
  });

  FutureDynamicResponse getResponse({
    required String endPoint,
    required ApiMethods apiMethods,
    Map<String, dynamic>? queryParams,
    dynamic body,
    Options? options,
    String? errorMessage,
  });
}

class ApiRequestImpl implements ApiRequest {
  @override
  late ApiManager _apiManager;

  @override
  FutureDynamicResponse decodeHttpRequestResponse(
    Response? response, {
    String message = "",
  }) async {
    AppToasts toastHelper = AppToasts();
    List<int> successStatusCode = [200, 201];
    if (successStatusCode.contains(response?.statusCode)) {
      return Left({'data': response?.data, 'message': message});
    } else if (response?.statusCode == 500) {
      toastHelper.showToast(message: 'Server Error', isSuccess: false);
      return Left(response?.data);
    } else if (response?.statusCode == 401) {
      toastHelper.showToast(message: 'Unauthorized', isSuccess: false);
    } else if (response?.statusCode == 400) {
      return Right(Failure.fromJson(response?.data));
    } else if (response?.statusCode == 422) {
      return Right(Failure.fromJson(response?.data));
    } else if (response?.data == null) {
      return Right(response?.data);
    } else {
      return Right(Failure(message: 'Something went wrong'));
    }
    return response?.data;
  }

  @override
  ApiManager get apiManager => _apiManager;

  @override
  FutureDynamicResponse getResponse({
    required String endPoint,
    required ApiMethods apiMethods,
    Map<String, dynamic>? queryParams,
    body,
    Options? options,
    String? errorMessage,
  }) async {
    Response? response;
    try {
      if (apiMethods == ApiMethods.post) {
        response = await apiManager.dio!.post(
          endPoint,
          data: body,
          queryParameters: queryParams,
          options: options,
        );
      } else if (apiMethods == ApiMethods.delete) {
        response = await apiManager.dio!.delete(
          endPoint,
          data: body,
          queryParameters: queryParams,
          options: options,
        );
      } else if (apiMethods == ApiMethods.put) {
        response = await apiManager.dio!.put(
          endPoint,
          data: body,
          queryParameters: queryParams,
          options: options,
        );
      } else {
        response = await apiManager.dio!.get(
          endPoint,
          queryParameters: queryParams,
          options: options,
        );
      }

      return decodeHttpRequestResponse(response, message: errorMessage ?? "");
    } catch (e) {
      return Right(Failure(message: errorMessage ?? 'Something went wrong'));
    }
  }

  @override
  void setApiManager(ApiManager apiManager) {
    _apiManager = apiManager;
  }
}
