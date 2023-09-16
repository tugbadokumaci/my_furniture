import 'package:dio/dio.dart';
import 'package:my_furniture/product/model/category_model.dart';
import 'package:my_furniture/product/model/resource.dart';

import '../../../core/extension/service_extension.dart';
import '../../../product/model/product_model.dart';

abstract class IHomeService {
  final Dio dio;

  IHomeService(this.dio);

  final String productsPath = ServicePath.PRODUCTS.rawValue;
  final String categoriesPath = ServicePath.CATEGORIES.rawValue;
  final String popularPath = ServicePath.POPULAR.rawValue;

  Future<List<CategoryModel>?> getCategories();
  Future<List<ProductModel>?> getPopular();
}
