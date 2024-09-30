import 'dart:convert';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/data/models/location_model.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationLoading()) {
    on<FetchLocationsEvent>(_fetchData);
  }

  Future<void> _fetchData(FetchLocationsEvent event, Emitter<LocationState> emit) async{
    final locationService = GetIt.I<LocationService>();
    try{
      final response = await http.get(Uri.parse(
          '${Constants.baseUrl}/location'));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final result = Location.fromJson(jsonDecode(response.body));
        for(var item in result.locations){
         await locationService.addToCart(item);
        }
        emit(LocationFetched(result));
      } else if (response.statusCode > 299) {
        emit(
          LocationError('This is coming from FetchWishlistState'),
        );
      }
    }catch(e,s){
      if (kDebugMode) {
        print('$e, $s');
      }
    }
  }
}
