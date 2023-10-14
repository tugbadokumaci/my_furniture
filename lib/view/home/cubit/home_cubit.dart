import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_furniture/product/model/category_model.dart';
import 'package:my_furniture/view/home/service/IHomeService.dart';

import '../../../product/model/product_model.dart';

class HomeCubit extends Cubit<HomeState> {
  final IHomeService service;
  HomeCubit(this.service) : super(HomeLoading());
  List<ProductModel> allProducts = [];

  Future<void> getHomeData() async {
    debugPrint('getHomeData called');
    final popularResult = await service.getPopular();
    if (popularResult == null) {
      Exception('Error fetching popular');
    }
    // allProducts = popularResult!;
    final categoriesResult = await service.getCategories();
    if (categoriesResult == null) {
      Exception('Error fetching popular');
    }
    emit(HomeLoaded(popularResult!, categoriesResult!));
    // emit(HomeLoaded(await service.getCategories(), await service.getPopular()));
  }

  // void searchByItems(String data) {
  //   debugPrint('searchByItems called');
  //   emit(HomeLoaded(allProducts.where((element) => element.productName.contains(data)).toList()));
  // }

  // Future<void> seeAllItems() async {
  //   debugPrint('getHomeData called');
  //   final result = await service.getCategories();
  //   if (result == null) {
  //     Exception('Error fetching popular');
  //   }
  //   emit(HomeSeeAll(result!, allProducts));
  //   // emit(HomeLoaded(await service.getCategories(), await service.getPopular()));
  // }
}

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  // final Resource<List<CategoryModel>> categoryList;
  final List<ProductModel> productList;
  final List<CategoryModel> categoryList;

  HomeLoaded(this.productList, this.categoryList);
}

class HomeSeeAll extends HomeState {
  final List<CategoryModel> categoryList;
  final List<ProductModel> productList;

  HomeSeeAll(this.categoryList, this.productList);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
