import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/extension/service_extension.dart';
import '../../../product/model/product_model.dart';

abstract class ISearchService {
  Dio dio;
  final String searchPath = ServicePath.SEARCH.rawValue;

  ISearchService(this.dio) {
    this.dio = dio;
    debugHttpInterceptors(this.dio);
  }

  Future<List<ProductModel>?> getSearchResults(String query);

  static void debugHttpInterceptors(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('onRequest');
        debugPrint("--> ${options.method} ${options.uri}");
        debugPrint("Query Parameter: ${options.queryParameters}");
        debugPrint("Headers: ${options.headers}");
        debugPrint("Data: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('onResponse');
        debugPrint("<-- ${response.statusCode} ${response.requestOptions.uri}");
        debugPrint("Response: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('onError');
        debugPrint("<-- Error ${e.response?.statusCode} ${e.response?.requestOptions.uri}");
        debugPrint("Message: ${e.message}");
        return handler.next(e);
      },
    ));
  }
}
