import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_furniture/view/product/service/IProductService.dart';

import '../../../product/model/product_model.dart';

class ProductService extends IProductService {
  ProductService(super.dio);

  @override
  Future<ProductModel?> getProductModelWithSelectedColor(int productId, int colorId) async {
    debugPrint('getCategories called');
    try {
      final result = await dio.get('$productModelPath?productId=$productId&colorId=$colorId&userId=1');
      if (result.statusCode == HttpStatus.ok) {
        final ProductModel value = ProductModel.fromJson(result.data as Map<String, dynamic>);

        return value;
      } else {
        debugPrint("error");
        return null;
      }
    } catch (e) {
      // Handle any potential exceptions
      debugPrint("error");
      debugPrint('Exception: Error fetching getProductModelWithSelectedColor: $e');
      return null;
    }
  }

  @override
  Future<bool> updateFavProduct(int productId, int userId) async {
    debugPrint('updateFavProduct called');
    try {
      final result = await dio.post(
        setFavProductPath,
        data: FormData.fromMap({'productId': productId, 'userId': userId}),
      );
      if (result.statusCode == HttpStatus.ok) {
        return true;
      } else {
        debugPrint("error");
        return false;
      }
    } catch (e) {
      // Handle any potential exceptions
      debugPrint("error");
      debugPrint('Exception: Error fetching updateFavProduct: $e');
      return false;
    }
  }
}
