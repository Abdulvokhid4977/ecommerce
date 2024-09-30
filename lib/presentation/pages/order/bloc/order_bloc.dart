import 'dart:convert';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/wrappers/cart_item_wrapper.dart';
import 'package:e_commerce/data/models/order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderCreateEvent>(_createOrder);
    on<FetchOrderEvent>(_fetchOrder);
  }

  Future<void> _fetchOrder(
      FetchOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final url = Uri.parse('${Constants.baseUrl}/order');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (kDebugMode) {
          print(response.body);
        }
        final result= orderFromJson(response.body);
        if (kDebugMode) {
          print(result);
        }

        emit(OrderFetched(result));
      } else {
        emit(OrderError(response.body));
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('$e, $s');
      }
    }
  }


  Future<void> _createOrder(
      OrderCreateEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    List<Map<String, dynamic>> cartItemsToJson(List<CartItemWrapper> products) {

      return products.map((item) {
        print(item.colorId);
        return {
          'product_id': item.product.id,
          'quantity': item.quantity,
          'color_id': item.colorId,
        };
      }).toList();
    }

    final url = Uri.parse('${Constants.baseUrl}/order');

    final body = jsonEncode({
      "items": cartItemsToJson(event.products),
      "order": {
        "address_name": event.address,
        "latitude": event.latitude,
        "longtitude": event.longitude,
        "customer_id": event.customerId,
        "delivery_cost": 20000,
        "delivery_status": event.deliveryStatus,
        "payment_method": event.paymentMethod,
        "payment_status": event.paymentStatus
      }
    });
    try {
      final response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (kDebugMode) {
          print(response.body);
        }
        emit(OrderCreated());
      } else {
        emit(OrderError('${response.body}, ${response.request}'));
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('$e, $s');
      }
    }
  }
}
