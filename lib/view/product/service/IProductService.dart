import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/extension/service_extension.dart';
import '../../../product/model/product_model.dart';

abstract class IProductService {
  Dio dio;
  final String productModelPath = ServicePath.PRODUCTMODEL.rawValue;
  final String setFavProductPath = ServicePath.SETFAVPRODUCT.rawValue;

  Future<ProductModel?> getProductModelWithSelectedColor(int productId, int colorId);
  Future<bool> updateFavProduct(int productId, int userId);

  IProductService(this.dio) {
    this.dio = dio;
    debugHttpInterceptors(this.dio);
  }

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
