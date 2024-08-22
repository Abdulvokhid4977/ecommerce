import 'dart:convert';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/data/models/banners_model.dart';
import 'package:e_commerce/data/models/category_model.dart' as ctg;
import 'package:e_commerce/data/models/product_moodel.dart';
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
  }

  Future<void> _fetchData(FetchDataEvent event, Emitter<MainState> emit) async {
    emit(MainLoading());
    if (event.isWishlist == true) {
      try {
        final response = await http.get(Uri.parse(
            '${Constants.baseUrl}/product?offset=0&limit=1000&favorite=${event.isWishlist}'));
        if (response.statusCode >= 200 && response.statusCode < 300) {
          final result = Product.fromJson(jsonDecode(response.body));
          if (kDebugMode) {
            print('${result.data.product[0].name},${response.statusCode}');
          }
          emit(FetchWishlistState(result));
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

        if (responses.every((response) => response.statusCode >= 200 && response.statusCode <= 299)) {
          final result1 = BannerData.fromJson(jsonDecode(responses[0].body));
          final result2 = Product.fromJson(jsonDecode(responses[1].body));
          final result3 = ctg.Category.fromJson(jsonDecode(responses[2].body));

          emit(MainLoaded(
            result1,
            result2,
            result3,
          ));
        } else {
          emit(MainError('Failed to fetch data.'));
        }
      } catch (e, s) {
        emit(MainError('Failed to fetch data: $e, $s'));
      }
    }
  }

  Future<void> _updateFavorite(
      UpdateFavoriteEvent event, Emitter<MainState> emit) async {
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
          "price_with_discount": event.productElement.priceWithDiscount,
          "product_category": event.productElement.productCategory,
          "rating": event.productElement.rating,
        }),
      );
      if (kDebugMode) {
        print('${response.body}, ${response.headers}');
        print(
            'Adding favorite status code: ${response.statusCode}, ${event.isFavorite}');
      }

      if (response.statusCode > 200 && response.statusCode<=299) {
        if (state is MainLoaded) {
          final currentState = state as MainLoaded;

          // Update the specific product with the new favorite status
          final updatedProducts =
              currentState.products.data.product.map((product) {
            return product.id == event.productElement.id
                ? product.copyWith(isFavourite: event.isFavorite)
                : product;
          }).toList();

          // Emit a new MainLoaded state with the updated products list
          emit(currentState.copyWith(
            products: currentState.products.copyWith(
              data: currentState.products.data.copyWith(
                product: updatedProducts,
              ),
            ),
          ));
        }
      } else {
        emit(MainError('Failed to update favorite status. But why?'));
      }
    } catch (e) {
      emit(MainError('Failed to update favorite status: $e'));
    }
  }
}
