import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ocad/src/database/apis/exceptions.dart';

import 'package:ocad/src/model/product_model/product_model.dart';

class ApiCalls {
  // ApiCalls._();

  final Exceptions exc = Exceptions();
  Future<List<ProductDataModel>> getData() async {
    try {
      final List<ProductDataModel> products = [];
      // log(products.isEmpty.toString());
      final uri = Uri.parse("${dotenv.env['GET_PRODUCTS']}");
      final http.Response response = await http.get(uri);
      // log(response.statusCode.toString());
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
    } catch (e) {
      throw exc.handleGetApiException(e);
    }
  }

  //add to favorite

  Future<String> addItemToFavorite(String useremail, String productId) async {
    try {
      final url = Uri.parse("${dotenv.env['ADDTOFAV']}");
      //   log(dotenv.env['ADDTOFAV'].toString());

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json", // 👈 important
          "Accept": "application/json",
        },
        body: jsonEncode({"userEmail": useremail, "productId": productId}),
      );
      // log(response.statusCode.toString());

      if (response.statusCode == 200) {
        final message = jsonDecode(response.body)['message'].toString();
        return message;
      } else {
        return "Some Problem occoured";
      }
    } catch (e) {
      throw exc.handlePostApiException(e);
    }
  }

  //remove from favorite

  Future<String> rmoveItemFromFavorite(
    String useremail,
    String productId,
  ) async {
    try {
      final url = Uri.parse(
        "${dotenv.env['REMOVE_FROM_FAV']}/$productId/$useremail",
      );
      //   log(dotenv.env['ADDTOFAV'].toString());

      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      // log(response.statusCode.toString());

      if (response.statusCode == 200) {
        final message = jsonDecode(response.body)['message'].toString();
        return message;
      } else {
        return "Some Problem occoured";
      }
    } catch (e) {
      throw exc.handleDeleteApiException(e);
    }
  }

  //get item of favorite
  Future<List<ProductDataModel>> getItemFromFavorite(String useremail) async {
    try {
      final url = Uri.parse("${dotenv.env['GET_ITEM_FAV']}/$useremail");
      //   log(dotenv.env['ADDTOFAV'].toString());

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      // log(response.statusCode.toString());

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        final List<ProductDataModel> datas = [];

        for (int i = 0; i < res.length; i++) {
          final data = ProductDataModel.fromMap(res[i]);
          datas.add(data);
        }
        // log(datas.toString());
        return datas;
      } else {
        return [];
      }
    } catch (e) {
      throw exc.handleGetApiException(e);
    }
  }

  //-------------- Cart Operations ---------------
  //-------------- Cart Operations ---------------
  //-------------- Cart Operations ---------------
  //-------------- Cart Operations ---------------

  //get all cart items
  Future<List<ProductDataModel>> getCartItems(String useremail) async {
    try {
      // useremail = "testPostman";
      final url = Uri.parse("${dotenv.env['GET_ITEM_CART']}/$useremail");
      log(dotenv.env['GET_ITEM_CART'].toString());

      final response = await http.get(
        url,
        // headers: {
        //   "Content-Type": "application/json",
        //   "Accept": "application/json",
        // },
      );
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        final List<ProductDataModel> cartDatas = [];

        for (int i = 0; i < res.length; i++) {
          final data = ProductDataModel.fromMap(res[i]);
          cartDatas.add(data);
        }
        // log(cartDatas.toString());
        return cartDatas;
      } else {
        return [];
      }
    } catch (e) {
      throw exc.handleGetApiException(e);
    }
  }

  //add to cart

  //post api exceptions
}
