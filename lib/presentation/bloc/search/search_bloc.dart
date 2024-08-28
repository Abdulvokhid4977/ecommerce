import 'dart:convert';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/data/models/category_model.dart' as ctg;
import 'package:e_commerce/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<FetchSearchDataEvent>(_fetchSearchData);
  }

  Future<void> _fetchSearchData(
      FetchSearchDataEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    if (event.fromNavBar) {
      try {
        final response =
            await http.get(Uri.parse('${Constants.baseUrl}/category'));

        if (response.statusCode >= 200 && response.statusCode <= 299) {
          final result = ctg.Category.fromJson(jsonDecode(response.body));
          if (kDebugMode) {
            print(result);
          }
          emit(CategoryLoaded(result));
        } else {
          // print(responses[1].body);
          emit(SearchError('Failed to fetch data. Do you know why?'));
        }
      } catch (e, s) {
        emit(SearchError('Failed to fetch data: $e, $s'));
      }
    } else {
      try {
        final response = await http.get(Uri.parse(
            '${Constants.baseUrl}/product?category_id=${event.categoryId}'));
        if (response.statusCode >= 200 && response.statusCode < 300) {
          if (jsonDecode(response.body)[1] == []) {
            final product = Product(count: 0, product: []);
            emit(FetchCategoryProductState(product, false));
            return;
          }
          final result = Product.fromJson(jsonDecode(response.body));
          print(result.count);
          emit(FetchCategoryProductState(result, true));
          return;
        } else if (response.statusCode > 299) {
          emit(
            SearchError('This is coming from FetchCategoryProductState'),
          );
        }
      } catch (e, s) {
        if (kDebugMode) {
          print('$e $s');
        }
      }
    }
  }
}
