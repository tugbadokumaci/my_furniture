import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_furniture/view/search/service/ISearchService.dart';

import '../../../core/init/cache/locale_manager.dart';
import '../../../product/model/product_model.dart';

class SearchCubit extends Cubit<SearchState> {
  final ISearchService service;

  SearchCubit(this.service) : super(SearchLoaded([]));
  List<String> lastSearches = [];

  Future<void> getSearchHistoryList() async {
    lastSearches = LocaleManager.instance.getSearchHistoryList();
  }

  Future<void> getSearchResults(String query) async {
    debugPrint('getSearchResults called');
    final result = await service.getSearchResults(query);
    if (result == null) {
      Exception('Error fetching search results');
      return emit(SearchError('Error fetching search results'));
    }
    return emit(SearchLoaded(result, query: query));
  }

  Future<void> addLastSearches(String query) async {
    if (!lastSearches.contains(query)) {
      if (lastSearches.length < 5) {
        lastSearches.add(query);
      } else {
        lastSearches.removeAt(0);
        lastSearches.add(query);
      }
      await LocaleManager.instance.setSearchHistoryList(lastSearches);
    }
  }

  Future<void> removeAtLastSearches(int index) async {
    lastSearches.removeAt(index);
    await LocaleManager.instance.setSearchHistoryList(lastSearches);
    emit(SearchLoaded([]));
  }

  Future<void> clearSearchHistory() async {
    lastSearches.clear();
    await LocaleManager.instance.setSearchHistoryList(lastSearches);
    emit(SearchLoaded([]));
  }
}

abstract class SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  String query;
  List<ProductModel>? searchResults;
  SearchLoaded(this.searchResults, {this.query = ''});
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
