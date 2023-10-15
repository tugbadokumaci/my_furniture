import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_furniture/core/extension/context_extension.dart';
import 'package:my_furniture/core/init/theme/light/color_scheme_light.dart';
import 'package:my_furniture/product/model/product_model.dart';
import 'package:my_furniture/product/utility/bottomsheet_utiliy.dart';

import '../../../core/constants/app/app_constants.dart';
import '../../../core/init/theme/light/text_theme_light.dart';
import '../../../product/utility/shopping_card_overlay.dart';
import '../../../product/widget/color_listview.dart';
import '../../../product/widget/furniture_slider.dart';

import '../cubit/product_cubit.dart';
import '../service/product_service.dart';

class ProductView extends StatelessWidget {
  final ProductModel productModel;
  const ProductView({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: ((context) =>
                ProductCubit(ProductService(Dio(BaseOptions(baseUrl: ApplicationConstants.BASE_URL))), productModel)
            // ..getProduct(productId)
            ),
        child: _buildScaffold(context));
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProductLoading) {
            return _buildLoading(context);
          } else if (state is ProductError) {
            return _buildError(context, state);
          }
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _sliderListView(context, state as ProductLoaded),
                    _title(context, state),
                    _colorListView(context, state),
                    // slider
                  ],
                ),
              ),
              Padding(
                padding: context.paddingNormal,
                child: GestureDetector(
                  onTap: () {
                    // SnackBarUtility.addProductToCardShowSnackBar(context: context, productModel: productModel);
                    _onAddToCardPressed(context);
                  },
                  child: Card(
                    color: ColorSchemeLight.instance.orange,
                    child: Padding(
                      padding: context.paddingNormal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, color: ColorSchemeLight.instance.white, size: 24),
                          Text('Add to cart',
                              style:
                                  TextThemeLight.instance.TitleMedium.copyWith(color: ColorSchemeLight.instance.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void _onAddToCardPressed(BuildContext context) {
    // SnackBarUtility.addProductToCardShowSnackBar(context: context, productModel: productModel);
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        // context karışıyor. context1 ile çözüldü. çünkü showDialog içinde context kullanılıyor.
        return ShoppingCartOverlay(
          context,
          productModel: productModel,
          colorModel: productModel.productColors[context.watch<ProductCubit>().selectedColorIndex],
        );
      },
    );
  }

  Widget _title(BuildContext context, ProductLoaded state) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(state.productModel.productName, style: TextThemeLight.instance.TitleMedium),
              Spacer(),
              Text('\$${state.productModel.productPrice}',
                  maxLines: 2, overflow: TextOverflow.ellipsis, style: TextThemeLight.instance.TitleMedium)
            ],
          ),
          context.emptyWidgetHeight(0.1),
          Row(
            children: [
              _ratingBar(context, 4.5),
              context.emptyWidgetWidth(context.lowValue),
              TextButton(
                child: Text('${productModel.comments.length} reviews',
                    style: TextThemeLight.instance.TextBig
                        .copyWith(decoration: TextDecoration.underline, color: ColorSchemeLight.instance.blue)),
                onPressed: () {
                  BottomSheetUtility.showBottomSheet(context, productModel.comments);
                },
              ),
            ],
          ),
          _isInStock(true, context),
          context.emptyWidgetHeight(context.normalValue),
          Text(state.productModel.productDescription,
              style: TextThemeLight.instance.TextMedium.copyWith(color: ColorSchemeLight.instance.extraDarkGray)),
        ],
      ),
    );
  }

  Widget _isInStock(bool isInStock, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.normalValue, vertical: context.lowValue),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.normalValue),
        color: isInStock ? ColorSchemeLight.instance.green : ColorSchemeLight.instance.lightRed,
      ),
      child: Text(isInStock ? 'In Stock' : 'Out of stock'),
    );
  }

  Widget _ratingBar(BuildContext context, double rating) {
    return Row(
      children: [
        RatingBar.builder(
          unratedColor: ColorSchemeLight.instance.gray,
          initialRating: rating,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: ColorSchemeLight.instance.orange,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        Text(rating.toString(),
            style: TextThemeLight.instance.TextBig.copyWith(
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }

  Widget _colorListView(BuildContext context, ProductLoaded state) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Colors · ${productModel.productColors.length} Options', style: TextThemeLight.instance.TitleSmall),
          context.emptyWidgetHeight(context.normalValue),
          SizedBox(
            height: context.dynamicHeight(context.lowValue),
            child: ColorListView(
              colors: state.productModel.productColors,
              onColorSelected: (index) {
                context.read<ProductCubit>().setSelectedColorIndex(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sliderListView(BuildContext context, ProductLoaded state) {
    return SizedBox(
      height: context.dynamicHeight(0.5),
      child: Stack(
        children: [
          FurnitureSlider(
            images: state.productModel.productImage,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: context.paddingNormal,
              child: _imageSliderGoBackButton(context),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: context.paddingNormal,
              child: _imageSliderFavButton(context),
            ),
          ),
        ],
      ),
    );
  }

  Container _imageSliderFavButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorSchemeLight.instance.white,
        borderRadius: BorderRadius.circular(context.normalValue),
      ),
      child: IconButton(
        onPressed: () {
          context.read<ProductCubit>().updateFavProduct();
        },
        icon: Icon(productModel.productIsFav == 1 ? Icons.favorite : Icons.favorite_border_outlined,
            color: ColorSchemeLight.instance.orange),
      ),
    );
  }

  Container _imageSliderGoBackButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorSchemeLight.instance.white,
        borderRadius: BorderRadius.circular(context.normalValue),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: ColorSchemeLight.instance.orange),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError(BuildContext context, ProductError state) {
    return Padding(
      padding: context.paddingNormal,
      child: Center(child: Text(state.message)),
    );
  }
}
