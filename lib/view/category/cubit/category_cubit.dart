import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/model/product_model.dart';
import '../service/ICategoryService.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ICategoryService service;

  CategoryCubit(this.service) : super(CategoryLoading());

  Future<void> getProducts(String categoryName) async {
    try {
      emit(CategoryLoading());
      final result = await service.getProducts(categoryName);
      if (result == null) {
        emit(CategoryError('Error fetching categories'));
      } else {
        emit(CategoryLoaded(result));
      }
    } catch (e) {
      emit(CategoryError('Error fetching categories'));
    }
  }
}

abstract class CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  List<ProductModel> products;
  CategoryLoaded(this.products);
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
