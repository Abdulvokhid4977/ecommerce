import 'dart:convert';

import 'package:e_commerce/core/constants/constants.dart';
import 'package:e_commerce/core/services/cached_values.dart';
import 'package:e_commerce/core/services/register_service.dart';
import 'package:e_commerce/data/models/register_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpCodeEvent>(_sendCode);
    on<VerifyCodeEvent>(_verify);
  }

  Future<void> _verify(VerifyCodeEvent event, Emitter<OtpState> emit)async {
    emit(VerifyLoading());
    final url= Uri.parse('${Constants.baseUrl}/byphoneconfirm');
    try{
      final response= await http.post(url, body: jsonEncode(
          {
            "otp_code": event.code,
            "phone_number": event.phoneNumber

          }
      ));

      if(response.statusCode>=200 && response.statusCode<300){
        final result= jsonDecode(response.body);
        await saveCustomerId(result['id']);
        try{
          final customerId= await getCustomerId();
          if (kDebugMode) {
            print(result['id']);
          }
          if (kDebugMode) {
            print(customerId);
          }
          final customerResponse= await http.get(Uri.parse('${Constants.baseUrl}/customer/${result['id']}'));
          if(customerResponse.statusCode>=200 && customerResponse.statusCode<300){
            final customerResult= Register.fromJson(jsonDecode(customerResponse.body));
            await RegisterService().addToCart(customerResult);
            if (kDebugMode) {
              print(customerResult.id);
            }
          }
          else{
            if (kDebugMode) {
              print('${customerResponse.statusCode}, ${customerResponse.body}');
            }
          }
        }catch(e,s){
          if (kDebugMode) {
            print('$e,$s');
          }
        }
        emit(VerifySuccess());
      }else if(response.statusCode==401){
        emit(VerifyUnsuccessful());
      }else{
        emit(OtpError(response.body));
      }
    }catch(e,s){
      if(kDebugMode){
        print('$e, $s');
      }
    }
  }
  
  
  Future<void> _sendCode(OtpCodeEvent event, Emitter<OtpState> emit) async{
    emit(OtpLoading());
    final url= Uri.parse('${Constants.baseUrl}/sendcode');
    try{
     final response= await http.post(url, body: jsonEncode(
       {
         "mobile_phone": event.phoneNumber
       }
     ));

     if(response.statusCode>=200 && response.statusCode<300){
       if (kDebugMode) {
         print(response.body);
       }
       emit(OtpSuccess());
     }else{
       emit(OtpError(response.body));
     }
    }catch(e,s){
      if(kDebugMode){
        print('$e, $s');
      }
    }
    
    
    
    
  }
}
