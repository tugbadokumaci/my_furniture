import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_furniture/product/model/category_model.dart';
import 'package:my_furniture/product/model/product_model.dart';
import 'package:my_furniture/view/home/service/IHomeService.dart';

class HomeService extends IHomeService {
  // HomeService, IHomeService yapıcı methodunu çağırır.
  HomeService(super.dio);

  @override
  Future<List<CategoryModel>?> getCategories() async {
    print('getCategories called');
    try {
      final result = await dio.get(categoriesPath);
      if (result.statusCode == HttpStatus.ok) {
        final List<CategoryModel> value = (result.data as List<dynamic>)
            .map((dynamic i) => CategoryModel.fromJson(i as Map<String, dynamic>))
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

  @override
  Future<List<ProductModel>?> getPopular() async {
    print('getPopular called');

    try {
      final result = await dio.get('${productsPath}?userId=1');

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
      debugPrint('Exception: Error fetching popular: $e');
      return null;
    }
  }
}
