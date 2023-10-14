import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_furniture/core/extension/context_extension.dart';
import 'package:my_furniture/core/extension/string_extension.dart';

import '../../../core/components/history_text_button.dart';
import '../../../core/components/product_display_tile.dart';
import '../../../core/constants/app/app_constants.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/init/theme/light/color_scheme_light.dart';
import '../../../core/init/theme/light/text_theme_light.dart';
import '../cubit/search_cubit.dart';
import '../service/search_service.dart';

class SearchView extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(SearchService(Dio(BaseOptions(baseUrl: ApplicationConstants.BASE_URL))))
        ..getSearchHistoryList()
        ..getSearchResults(""),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: _buildScaffold(context),
      ),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          debugPrint('state: $state');
          if (state is SearchLoading) {
            return _buildLoading(context);
          } else if (state is SearchLoaded) {
            return _buildLoaded(context, state);
          }
          return _buildError(context, state as SearchError);
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

  Widget _buildLoaded(BuildContext context, SearchLoaded state) {
    return ListView(
      children: [
        _header(context),
        _searchBar(context, state),
        if (state.query != '') _searchResults(context, state),
        if (state.query == '' && context.read<SearchCubit>().lastSearches.isNotEmpty) _searchHistory(context),
        if (state.query == '') _banner(context),
      ],
    );
  }

  Widget _buildError(BuildContext context, SearchError state) {
    return Padding(
      padding: context.paddingNormal,
      child: Center(child: Text(state.message)),
    );
  }

  Widget _searchBar(BuildContext context, SearchLoaded state) {
    return Padding(
      padding: context.paddingNormal,
      child: TextField(
        controller: searchController,
        // onTap: () async {
        //   await showSearch(context: context, delegate: CustomSearchDelegate(state));
        // },
        onChanged: (value) {
          print("value: $value");
          context.read<SearchCubit>().getSearchResults(value);
        },
        onSubmitted: (value) {
          context.read<SearchCubit>().addLastSearches(value);
          debugPrint(context.read<SearchCubit>().lastSearches.toString());
        },
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

  Widget _searchResults(BuildContext context, SearchLoaded state) {
    return Padding(
      padding: context.paddingNormal,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.searchResults?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          if (state.searchResults == [] || state.searchResults == null) {
            return const Center(child: Text("No results found"));
          }
          return ProductDisplayTile(productModel: state.searchResults![index]);
        },
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: SizedBox(
          height: context.dynamicHeight(0.15),
          child: Card(
              child: Image.network(
                  "https://as2.ftcdn.net/v2/jpg/05/08/17/01/1000_F_508170187_4Oonk4IG8u9eyfwSUvTASkT8hl71vRX2.jpg",
                  fit: BoxFit.fitWidth))),
    );
  }

  Widget _searchHistory(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text("Search History", style: TextThemeLight.instance.TitleMedium),
              Spacer(),
              TextButton(
                onPressed: () {
                  context.read<SearchCubit>().clearSearchHistory();
                },
                child: Text("Delete All",
                    style: TextThemeLight.instance.TextMedium.copyWith(color: ColorSchemeLight.instance.orange)),
              )
            ],
          ),
          SizedBox(
            height: context.dynamicHeight(0.11),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: context.read<SearchCubit>().lastSearches.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: context.paddingNormalVertical,
                  child: HistoryTextButton(
                    context: context,
                    query: context.read<SearchCubit>().lastSearches[index],
                    onButtonPressed: () {
                      context.read<SearchCubit>().getSearchResults(context.read<SearchCubit>().lastSearches[index]);
                      searchController.text = context.read<SearchCubit>().lastSearches[index];
                    },
                    onDeletePressed: () {
                      context.read<SearchCubit>().removeAtLastSearches(index);
                      context.read<SearchCubit>().getSearchHistoryList();
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {
//   final SearchLoaded state;
//   CustomSearchDelegate(this.state);
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return {
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       )
//     }.toList();
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(onPressed: () => close(context, null), icon: const Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return ListView.builder(
//       itemCount: state.searchResults?.length,
//       itemBuilder: (context, index) {
//         var result = state.searchResults![index];
//         return ProductDisplayTile(productModel: result);
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30.0),
//       child: ListView.builder(
//         itemCount: state.searchResults?.length,
//         itemBuilder: (context, index) {
//           var result = state.searchResults![index];
//           return ProductDisplayTile(productModel: result);
//         },
//       ),
//     );
//   }
// }
