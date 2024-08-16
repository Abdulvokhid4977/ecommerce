import 'dart:convert';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/data/models/banners_model.dart';
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
    BannerData result;
    try {
      final responses = await Future.wait([
        http.get(Uri.parse('${Constants.baseUrl}/banner')),
        http.get(Uri.parse('${Constants.baseUrl}/product')),
        http.get(Uri.parse('${Constants.baseUrl}/category')),
      ]);
      // final responseBanner =
      //     await http.get(Uri.parse('${Constants.baseUrl}/banner'));
      // final responseProduct =
      //     await http.get(Uri.parse('${Constants.baseUrl}/product'));
      // final responseCategory =
      //     await http.get(Uri.parse('${Constants.baseUrl}/category'));

      if (responses[0].statusCode == 200) {
        result = BannerData.fromJson(jsonDecode(responses[0].body));

        emit(MainLoaded(result));
      } else {
        emit(MainError('Failed to fetch data'));
      }
    } catch (e) {
      emit(MainError('Failed to fetch data'));
    }
  }
}
