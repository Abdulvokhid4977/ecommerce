import 'dart:convert';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/data/models/banners_model.dart';
import 'package:e_commerce/data/models/category_model.dart' as ctg;
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/bloc/search/search_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<FetchDataEvent>(_fetchData);
    on<UpdateFavoriteEvent>(_updateFavorite);
    on<ChangeTabEvent>((event, emit) {
      emit(TabChangedState(event.tabIndex));
    });
  }

  Future<void> _fetchData(FetchDataEvent event, Emitter<MainState> emit) async {
    emit(MainLoading());

     if (event.isWishlist == true) {
      try {
        final response = await http.get(Uri.parse(
            '${Constants.baseUrl}/product?offset=0&favorite=${event.isWishlist}'));
        if (response.statusCode >= 200 && response.statusCode < 300) {
          if (jsonDecode(response.body)[1] == []) {
            final product = Product(count: 0, product: []);
            emit(FetchWishlistState(product, false));
            return;
          }
          final result = Product.fromJson(jsonDecode(response.body));
          emit(FetchWishlistState(result, true));
        } else if (response.statusCode > 299) {
          emit(
            MainError('This is coming from FetchWishlistState'),
          );
        }
      } catch (e, s) {
        if (kDebugMode) {
          print('$e $s');
        }
      }
    } else {
      try {
        final responses = await Future.wait([
          http.get(Uri.parse('${Constants.baseUrl}/banner')),
          http.get(Uri.parse('${Constants.baseUrl}/product')),
          http.get(Uri.parse('${Constants.baseUrl}/category')),
        ]);

        if (responses.every((response) =>
            response.statusCode >= 200 && response.statusCode <= 299)) {
          final result1 = BannerData.fromJson(jsonDecode(responses[0].body));
          final result2 = Product.fromJson(jsonDecode(responses[1].body));
          final result3 = ctg.Category.fromJson(jsonDecode(responses[2].body));
          if (kDebugMode) {
            print('It is emitting MainLoaded');
          }
          emit(MainLoaded(
            result1,
            result2,
            result3,
          ));
        } else {
          // print(responses[1].body);
          emit(MainError('Failed to fetch data. Do you know why?'));
        }
      } catch (e, s) {
        emit(MainError('Failed to fetch data: $e, $s'));
      }
    }
  }

  Future<void> _updateFavorite(
      UpdateFavoriteEvent event, Emitter<MainState> emit) async {

    // 1. Emit Optimistic State
    if (state is MainLoaded) {
      final currentState = state as MainLoaded;
      final updatedProducts = _updateProductsList(
          currentState.products.product, event.productElement.id, event.isFavorite);
      emit(currentState.copyWith(
        products: currentState.products.copyWith(product: updatedProducts),
      ));
    } else if (state is FetchWishlistState) {
      final currentState = state as FetchWishlistState;
      final updatedProducts = _updateProductsList(
          currentState.product.product, event.productElement.id, event.isFavorite);
      emit(currentState.copyWith(
        product: currentState.product.copyWith(product: updatedProducts),
      ));
    }

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
        // 3. Roll Back the UI on Failure
        _rollbackFavoriteState(event, emit);
        emit(MainError('Failed to update favorite status.'));
      }
    } catch (e) {
      // 3. Roll Back the UI on Error
      _rollbackFavoriteState(event, emit);
      emit(MainError('Failed to update favorite status: $e'));
    }
  }

  void _rollbackFavoriteState(UpdateFavoriteEvent event, Emitter<MainState> emit) {
    if (state is MainLoaded) {
      final currentState = state as MainLoaded;
      final updatedProducts = _updateProductsList(
          currentState.products.product, event.productElement.id, !event.isFavorite);
      emit(currentState.copyWith(
        products: currentState.products.copyWith(product: updatedProducts),
      ));
    } else if (state is FetchWishlistState) {
      final currentState = state as FetchWishlistState;
      final updatedProducts = _updateProductsList(
          currentState.product.product, event.productElement.id, !event.isFavorite);
      emit(currentState.copyWith(
        product: currentState.product.copyWith(product: updatedProducts),
      ));
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
