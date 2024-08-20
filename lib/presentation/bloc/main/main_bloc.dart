import 'dart:convert';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/data/models/banners_model.dart';
import 'package:e_commerce/data/models/product_moodel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc()
      : super(
          MainInitial(),
        ) {
    on<FetchDataEvent>(_fetchData);
  }

  Future<void> _fetchData(FetchDataEvent event, Emitter<MainState> emit) async {
    emit(MainLoading());
    BannerData result1;
    Product result2;
    try {
      final responses = await Future.wait([
        http.get(Uri.parse('${Constants.baseUrl}/banner')),
        http.get(Uri.parse('${Constants.baseUrl}/product')),
        // http.get(Uri.parse('${Constants.baseUrl}/category')),
      ]);

      if (responses[0].statusCode == 200 && responses[1].statusCode==200) {
        result1 = BannerData.fromJson(jsonDecode(responses[0].body),);
        result2= Product.fromJson(jsonDecode(responses[1].body),);
        if (kDebugMode) {
          print(result2);
        }

        emit(MainLoaded(result1, result2));
      } else {
        emit(MainError('Failed to fetch data'));
      }
    } catch (e) {
      emit(MainError('Failed to fetch data, $e'));
    }
  }
}
