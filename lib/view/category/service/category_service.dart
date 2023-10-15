import 'dart:io';

import 'package:flutter/material.dart';

import '../../../product/model/product_model.dart';
import 'ICategoryService.dart';

class CategoryService extends ICategoryService {
  CategoryService(super.dio);

  @override
  Future<List<ProductModel>?> getProducts(String categoryName) async {
    print('getCategories called');
    try {
      final result = await dio.get('$productsPath/$categoryName?userId=1');
      if (result.statusCode == HttpStatus.ok) {
        final List<ProductModel> value = (result.data as List<dynamic>)
            .map((dynamic i) => ProductModel.fromJson(i as Map<String, dynamic>))
            .toList();

        return value;
      } else {
        debugPrint("error");
        return null;
      }
    } catch (e) {
      // Handle any potential exceptions
      debugPrint("error");
      ('Exception: Error fetching categories: $e');
      return null;
    }
  }
}
