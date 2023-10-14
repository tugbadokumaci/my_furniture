import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_furniture/core/extension/context_extension.dart';
import 'package:my_furniture/core/init/theme/light/text_theme_light.dart';

import '../../../core/components/product_display_tile.dart';
import '../../../core/constants/app/app_constants.dart';

import '../cubit/category_cubit.dart';
import '../service/category_service.dart';

class CategoryView extends StatelessWidget {
  final String categoryName;
  const CategoryView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCubit>(
      create: ((context) => CategoryCubit(CategoryService(Dio(BaseOptions(baseUrl: ApplicationConstants.BASE_URL))))
        ..getProducts(categoryName)),
      child: _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoryLoading) {
            return _buildLoading(context);
          } else if (state is CategoryError) {
            return _buildError(context, state);
          }
          return ListView(
            children: [
              _header(context, state as CategoryLoaded),
              _productListView(context, state),

              // slider
            ],
          );
        },
      ),
    );
  }

  Widget _header(BuildContext context, CategoryLoaded state) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          Row(
            children: [
              Text(categoryName, style: TextThemeLight.instance.TitleMedium),
              context.emptyWidgetWidth(context.lowValue),
              Text('(${state.products.length} Products)', style: TextThemeLight.instance.TextMedium),
            ],
          )
        ],
      ),
    );
  }

  Widget _productListView(BuildContext context, CategoryLoaded state) {
    return Padding(
        padding: context.paddingNormal,
        child:
            // BlocSelector<CategoryCubit, CategoryState, List<ProductModel>>(
            //   selector: (state) {
            //     return state is CategoryLoaded ? state.productList : context.read<CategoryCubit>().allProducts;
            //   },
            //   builder: (context, state) {
            //     return
            GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            if (state.products == []) {
              return const Center(child: Text("No results found"));
            }
            return ProductDisplayTile(productModel: state.products[index]);
          },
        )
        // ;
        //     },
        //   ),
        );
  }

  Widget _buildLoading(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildError(BuildContext context, CategoryError state) {
    return Padding(
      padding: context.paddingNormal,
      child: Center(child: Text(state.message)),
    );
  }
}
