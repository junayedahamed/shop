import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:ocad/src/product_model/product_model.dart';

class ApiCalls {
  ApiCalls._();

  static Future<List<ProductDataModel>> getData() async {
    try {
      final List<ProductDataModel> products = [];
      // log(products.isEmpty.toString());
      final uri = Uri.parse("${dotenv.env['GET_PRODUCTS']}");
      final http.Response response = await http.get(uri);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final values = jsonDecode(response.body);
        for (int i = 0; i < values.length; i++) {
          final data = ProductDataModel.fromMap(values[i]);
          products.add(data);
        }
        // log(products.toString());
        return products;
      }
      return [];
    } on SocketException catch (x) {
      throw {'message': "No Internet ", 'err': x.message};
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}
