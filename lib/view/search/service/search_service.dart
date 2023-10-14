import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_furniture/product/model/product_model.dart';
import 'package:my_furniture/view/search/service/ISearchService.dart';

class SearchService extends ISearchService {
  SearchService(super.dio);

  @override
  Future<List<ProductModel>?> getSearchResults(String query) async {
    print('getSearchResults called');
    try {
      final response = await dio.get('${searchPath}?query=$query&userId=1');
      if (response.statusCode == HttpStatus.ok) {
        final List<ProductModel> value = (response.data as List<dynamic>)
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
      ('Exception: Error fetching search results: $e');
      return null;
    }
  }
}
