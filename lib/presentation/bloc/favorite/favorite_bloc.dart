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
          "brand_id": '3bb31443-89ab-4240-b5b8-9ec5fccd9c1a',
          "category_id": event.productElement.categoryId,
          "description": event.productElement.description,
          "discount_end_time": event.productElement.discountEndTime,
          "discount_percent": event.productElement.discountPercent,
          "favorite": event.isFavorite,
          "id": event.productElement.id,
          "image":
              "https://firebasestorage.googleapis.com/v0/b/ecommece-e1b2e.appspot.com/o/headset.jpg?alt=media&token=8a19857f-864b-437b-b661-ed3ecf031025",
          "item_count": event.productElement.itemCount,
          "name": event.productElement.name,
          "price": event.productElement.price,
          "rating": event.productElement.rating,
          "status": event.productElement.status,
          "with_discount": event.productElement.withDiscount,
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
