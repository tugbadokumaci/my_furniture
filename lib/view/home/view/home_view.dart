import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_furniture/core/components/category_display_tile.dart';
import 'package:my_furniture/core/constants/app/app_constants.dart';
import 'package:my_furniture/core/extension/context_extension.dart';
import 'package:my_furniture/core/extension/string_extension.dart';
import 'package:my_furniture/core/init/lang/locale_keys.g.dart';
import 'package:my_furniture/core/init/theme/light/color_scheme_light.dart';
import 'package:my_furniture/core/init/theme/light/text_theme_light.dart';
import 'package:my_furniture/product/widget/furniture_slider.dart';
import 'package:my_furniture/view/home/service/home_service.dart';
import 'package:my_furniture/view/home/cubit/home_cubit.dart';

import '../../../core/components/product_display_tile.dart';
import '../../../product/model/product_model.dart';
import '../../search/view/search_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) =>
          HomeCubit(HomeService(Dio(BaseOptions(baseUrl: ApplicationConstants.BASE_URL))))..getHomeData(),
      child: SafeArea(
          child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: _buildScaffold(context),
      )),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          debugPrint('state: $state');
          // if (state is HomeInitial) {
          // context.read<HomeCubit>().getHomeData();
          // } else
          if (state is HomeLoading) {
            return _buildLoading(context);
          } else if (state is HomeError) {
            return _buildError(context, state);
          }
          return ListView(
            children: [
              _header(context),
              _searchBar(context),
              _subHeader(context, LocaleKeys.home_categories.locale),
              _categoryListView(context, state),
              _sliderListView(context),
              _subHeader(context, LocaleKeys.home_newSeason.locale),
              _productListView(context, state),

              // slider
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: TextField(
        readOnly: true,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SearchView(),
          ));
        },
        // onChanged: (value) {
        //   context.read<HomeCubit>().searchByItems(value);
        // },
        decoration: InputDecoration(
          contentPadding: context.paddingLow,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: const Icon(Icons.search),
          hintText: LocaleKeys.home_searchBar.locale,
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(LocaleKeys.home_title.locale, style: TextThemeLight.instance.TitleBig)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notification_important),
          ),
        ],
      ),
    );
  }

  Widget _subHeader(BuildContext context, String title) {
    return Padding(
      padding: context.paddingNormal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextThemeLight.instance.TitleMedium),
          InkWell(
              onTap: () {
                // context.read<HomeCubit>().seeAllItems();
              },
              child: TextButton(
                child: Row(
                  children: [
                    Text(LocaleKeys.home_seeAll.locale,
                        style: TextThemeLight.instance.TextMedium.copyWith(color: ColorSchemeLight.instance.orange)),
                    Icon(Icons.arrow_forward_outlined, color: ColorSchemeLight.instance.orange, size: 24)
                  ],
                ),
                onPressed: () {},
              )),
        ],
      ),
    );
  }

  Widget _categoryListView(BuildContext context, HomeState state) {
    return Padding(
      padding: context.paddingNormal,
      child: SizedBox(
        height: context.dynamicHeight(0.1),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: state is HomeLoaded ? state.categoryList.length : 0,
          itemBuilder: (context, index) {
            final item = (state as HomeLoaded).categoryList[index];
            return CategoryDisplayTile(
              categoryModel: item,
            );
          },
        ),
      ),
    );
  }

  // Selector state dinler ve değişiklik olduğunda builder çalışır.
  Widget _productListView(BuildContext context, HomeState state) {
    return Padding(
      padding: context.paddingNormal,
      child: BlocSelector<HomeCubit, HomeState, List<ProductModel>>(
        selector: (state) {
          return state is HomeLoaded ? state.productList : context.read<HomeCubit>().allProducts;
        },
        builder: (context, state) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              if (state == [] || state == null) {
                return const Center(child: Text("No results found"));
              }
              return ProductDisplayTile(productModel: state[index]);
            },
          );
        },
      ),
    );
  }

  Widget _sliderListView(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: SizedBox(
        height: context.dynamicHeight(0.2),
        child: FurnitureSlider(images: const ["https://codeocean.net/my_furniture/sliders/slider_1.png"]),
      ),
    );
  }

  Widget _buildError(BuildContext context, HomeError state) {
    return Padding(
      padding: context.paddingNormal,
      child: Center(child: Text(state.message)),
    );
  }
}
