import 'dart:convert';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cached_values.dart';
import 'package:e_commerce/core/services/register_service.dart';
import 'package:e_commerce/data/models/register_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<PostUserDataEvent>(_postData);
    on<UpdateUserDataEvent>(_updateData);
  }

  Future<void> _updateData(UpdateUserDataEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final url = Uri.parse('${Constants.baseUrl}/customer/${event.id}');

    try {
      final response = await http.put(url,
          body: jsonEncode({
            "birthday": event.birthday,
            "gender": event.gender,
            "id": event.id,
            "name": event.name,
            "phone_number": event.phoneNumber,
            "surname": event.surname,
          }));
      if (response.statusCode >= 200 &&
          response.statusCode < 300) {
        final customerResult =
        Register.fromJson(jsonDecode(response.body));
        await RegisterService().addToCart(customerResult);
        if (kDebugMode) {
          print(customerResult);
        }
        emit(UpdateProfile());
      } else {
        if (kDebugMode) {
          print('${response.statusCode}, ${response.body}');
        }
        emit(RegisterError('this is coming from update profile data'));
      }

    } catch (e, s) {
      if (kDebugMode) {
        print('$e, $s');
      }
    }
  }

  Future<void> _postData(
      PostUserDataEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    final url = Uri.parse('${Constants.baseUrl}/verifycode');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          "customer": {
            "birthday": event.birthday,
            "gender": event.gender,
            "name": event.name,
            "phone_number": event.phoneNumber,
            "surname": event.surname,
          }
        }),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final result = jsonDecode(response.body);
        if (kDebugMode) {
          print(result);
        }
        await saveCustomerId(result['id']);
        try {
          final customerId = await getCustomerId();
          if (kDebugMode) {
            print(result['id']);
          }
          if (kDebugMode) {
            print(customerId);
          }
          final customerResponse = await http
              .get(Uri.parse('${Constants.baseUrl}/customer/$customerId'));
          if (customerResponse.statusCode >= 200 &&
              customerResponse.statusCode < 300) {
            final customerResult =
                Register.fromJson(jsonDecode(customerResponse.body));
            await RegisterService().addToCart(customerResult);
            if (kDebugMode) {
              print(customerResult);
            }
          } else {
            if (kDebugMode) {
              print('${customerResponse.statusCode}, ${customerResponse.body}');
            }
          }
        } catch (e, s) {
          if (kDebugMode) {
            print('$e,$s');
          }
        }
        emit(RegisterSuccess());
      } else {
        emit(RegisterError('${response.statusCode} here I am'));
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('$e, $s');
      }
    }
  }
}
