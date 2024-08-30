import 'dart:convert';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/data/models/category_model.dart' as ctg;
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/bloc/main/main_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<FetchSearchDataEvent>(_fetchSearchData);
    on<UpdateFavoriteEvent>(_updateFavorite);
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
  Future<void> _updateFavorite(
      UpdateFavoriteEvent event, Emitter<SearchState> emit) async {
    if (state is FetchCategoryProductState) {
      final currentState = state as FetchCategoryProductState;
      final updatedProducts = _updateProductsList(
          currentState.product.product, event.productElement.id,
          event.isFavorite);

      emit(currentState.copyWith(
        product: currentState.product.copyWith(product: updatedProducts),
      ));

      // 2. Make the HTTP Request
      try {
        final response = await http.put(
          Uri.parse('${Constants.baseUrl}/product/${event.productElement.id}'),
          body: jsonEncode({
            "description": event.productElement.description,
            "favorite": event.isFavorite,
            "id": event.productElement.id,
            "image": event.productElement.image,
            "name": event.productElement.name,
            "order_count": event.productElement.orderCount,
            "price": event.productElement.price,
            "with_discount": event.productElement.withDiscount,
            "category_id": event.productElement.categoryId,
            "rating": event.productElement.rating,
          }),
        );

        if (response.statusCode < 200 || response.statusCode >= 300) {
          if (kDebugMode) {
            print("${response.body}, ${response.statusCode}");
          }
          emit(currentState.copyWith(
            product: currentState.product.copyWith(product: _updateProductsList(
                currentState.product.product, event.productElement.id, !event.isFavorite)),
          ));
          emit(SearchError('Failed to update favorite status.'));
        }
      } catch (e) {
        // 3. Roll Back the UI on Error
        emit(currentState.copyWith(
          product: currentState.product.copyWith(product: _updateProductsList(
              currentState.product.product, event.productElement.id, !event.isFavorite)),
        ));
        emit(SearchError('Failed to update favorite status: $e'));
      }
    }
  }

  List<ProductElement> _updateProductsList(
      List<ProductElement> products, String productId, bool isFavorite) {
    return products.map((product) {
      return product.id == productId
          ? product.copyWith(favorite: isFavorite)
          : product;
    }).toList();
  }

}
