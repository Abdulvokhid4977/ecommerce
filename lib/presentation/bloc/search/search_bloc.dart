import 'dart:convert';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/data/models/category_model.dart' as ctg;
import 'package:e_commerce/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<FetchCategoryProductEvent>(_fetchProductFiltered);
  }


  Future<void> _fetchProductFiltered(FetchCategoryProductEvent event, Emitter<SearchState> emit) async{
    emit(SearchLoading());
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
