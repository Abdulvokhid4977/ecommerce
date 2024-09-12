// import 'dart:convert';
//
// import '../../core/constants/constants.dart';
// import '../models/product_model.dart';
// import 'package:http/http.dart' as http;
//
// class HttpRequest{
//   Future<List<Product>> fetchProductsFromAPI() async {
//     try{
//       final response = await http.get(Uri.parse(
//           '${Constants.baseUrl}/product?name=S22'));
//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         final result = Product.fromJson(jsonDecode(response.body));
//         return result;
//       } else if (response.statusCode > 299) {
//
//       }
//     }catch(e,s){print('$e,$s');}
//     return ;
//   }
//
//
//
// }