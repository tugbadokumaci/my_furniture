import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../product/model/product_model.dart';
import '../service/IProductService.dart';

class ProductCubit extends Cubit<ProductState> {
  final IProductService service;
  final ProductModel productModel;

  ProductCubit(this.service, this.productModel) : super(ProductLoaded(productModel: productModel));

  int selectedColorIndex = 0;
  int isProductFav = 0;

  void setSelectedColorIndex(int index) {
    selectedColorIndex = index;
    getProductModelWithSelectedColor();
  }

  Future<void> getProductModelWithSelectedColor() async {
    try {
      final result = await service.getProductModelWithSelectedColor(
          productModel.productId, productModel.productColors[selectedColorIndex].colorId);
      if (result == null) {
        emit(ProductError('Error fetching categories'));
      } else {
        emit(ProductLoaded(productModel: result));
      }
    } catch (e) {
      emit(ProductError('Error fetching categories'));
    }
  }

  void updateIsProductfav() {
    isProductFav = isProductFav == 1 ? 0 : 1;
  }

  Future<void> updateFavProduct() async {
    // emit(ProductLoading());
    final result = await service.updateFavProduct(productModel.productId, 1); // TODO: userId düzenle
    if (result) {
      // eğer db yazma başarılı ise o zmaan productde sadece gerekli yerleri düzenle!
      productModel.productIsFav = productModel.productIsFav == 1 ? 0 : 1;
    } else {
      Fluttertoast.showToast(
          msg: "Favori ürünlerinize eklenirken bir hata oluştu. Lütfen tekrar deneyiniz.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.black,
          fontSize: 16.0);
    }
    return emit(ProductLoaded(productModel: productModel));
  }
}

abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductModel productModel;

  ProductLoaded({required this.productModel});
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
