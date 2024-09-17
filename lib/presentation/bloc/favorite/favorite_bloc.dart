import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/constants.dart';
import '../../../data/models/product_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteLoading()) {
    on<UpdateFavoriteStatusEvent>(_updateFavorite);
  }

  Future<void> _updateFavorite(
      UpdateFavoriteStatusEvent event, Emitter<FavoriteState> emit) async {
    try {
      final response = await http.put(
        Uri.parse('${Constants.baseUrl}/product/${event.productElement.id}'),
        body: jsonEncode({
          "description": event.productElement.description,
          "favorite": event.isFavorite,
          "brand_id": '',
          "id": event.productElement.id,
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
        emit(FavoriteError('Failed to update favorite status.'));
      } else {
        if (kDebugMode) {
          print('It is successfully emitted FavoriteToggledState');
        }
        emit(FavoriteToggledState(event.isFavorite, event.productElement));
      }
    } catch (e) {
      emit(FavoriteError('Failed to update favorite status: $e'));
    }
  }
}
