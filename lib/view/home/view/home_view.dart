import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_furniture/core/constants/app/app_constants.dart';
import 'package:my_furniture/core/extension/context_extension.dart';
import 'package:my_furniture/core/extension/string_extension.dart';
import 'package:my_furniture/core/init/lang/locale_keys.g.dart';
import 'package:my_furniture/core/init/theme/light/text_theme_light.dart';
import 'package:my_furniture/view/home/service/home_service.dart';
import 'package:my_furniture/view/home/cubit/home_cubit.dart';

import '../../../product/model/product_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) =>
          HomeCubit(HomeService(Dio(BaseOptions(baseUrl: ApplicationConstants.BASE_URL))))..getHomeData(),
      child: _buildScaffold(context),
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
            return _buildLoading();
          } else if (state is HomeError) {
            return _buildError(state);
          }
          return Padding(
            padding: context.paddingNormal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _header(),
                _searchBar(context),
                _productListView(context, state),
                _categoryHeader(context),
                _categoryListView(context, state),
                // slider
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  TextField _searchBar(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read<HomeCubit>().searchByItems(value);
      },
      decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: LocaleKeys.home_searchBar.locale),
    );
  }

  Text _header() => Text(LocaleKeys.home_title.locale);

  Widget _categoryHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(LocaleKeys.home_categories.locale, style: TextThemeLight.instance.TitleMedium),
        InkWell(
            onTap: () {
              context.read<HomeCubit>().seeAllItems();
            },
            child: Text(LocaleKeys.home_seeAll.locale,
                style: TextThemeLight.instance.TextSmall.copyWith(color: Colors.orange))),
      ],
    );
  }

  Widget _categoryListView(BuildContext context, HomeState state) {
    return SizedBox(
      height: context.dynamicHeight(0.2),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: state is HomeSeeAll ? state.categoryList.length : 0,
        itemBuilder: (context, index) {
          final item = (state as HomeSeeAll).categoryList[index];
          return Card(
            child:
                SizedBox(width: context.dynamicWidth(0.3), child: Image.asset("assets/images/my_furniture_logo.png")),
          );
        },
      ),
    );
  }

  // Selector state dinler ve değişiklik olduğunda builder çalışır.
  Widget _productListView(BuildContext context, HomeState state) {
    return BlocSelector<HomeCubit, HomeState, List<ProductModel>>(
      // state HomeLoaded ise state.productList, değilse context.read<HomeCubit>().allProducts döndürür.
      selector: (state) {
        return state is HomeLoaded ? state.productList : context.read<HomeCubit>().allProducts;
      },
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: state.length,
          itemBuilder: (context, index) {
            final item = state[index];
            return Card(
              child: Column(
                children: [
                  Text(item.productName),
                  SizedBox(width: context.dynamicWidth(0.3), child: Image.asset("assets/images/my_furniture_logo.png")),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildError(HomeError state) {
    return Center(child: Text(state.message));
  }
}
