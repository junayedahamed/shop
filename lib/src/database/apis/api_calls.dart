import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:ocad/src/model/product_model/product_model.dart';

class ApiCalls {
  ApiCalls._();

  static Future<List<ProductDataModel>> getData() async {
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
    } on SocketException catch (x) {
      throw {'message': "No Internet ", 'err': x.message};
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }

  //add to favorite

  static Future<String> addItemToFavorite(
    String useremail,
    String productId,
  ) async {
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
      if (e is SocketException) {
        if (e.osError?.message.contains("Failed host lookup") ?? false) {
          throw "Could not reach the server. Please try again later.";
        }
        throw "Please check your network Connection.";
      } else if (e is TimeoutException) {
        throw "Request timed out. Please try again.";
      } else if (e is FormatException) {
        throw "Invalid response from server.";
      } else {
        throw "Unexpected error occurred. Please try again.";
      }
    }
  }

  //remove from favorite

  static Future<String> rmoveItemFromFavorite(
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
      if (e is SocketException) {
        if (e.osError?.message.contains("Failed host lookup") ?? false) {
          throw "Could not reach the server. Please try again later.";
        }
        throw "Please check your network Connection.";
      } else if (e is TimeoutException) {
        throw "Request timed out. Please try again.";
      } else if (e is FormatException) {
        throw "Invalid response from server.";
      } else {
        throw "Unexpected error occurred. Please try again.";
      }
    }
  }

  //get item of favorite
  static Future<List<ProductDataModel>> getItemFromFavorite(
    String useremail,
  ) async {
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
      if (e is SocketException) {
        if (e.osError?.message.contains("Failed host lookup") ?? false) {
          throw Exception(
            "Could not reach the server. Please try again later.",
          );
        }
        throw Exception("No internet connection. Please check your network.");
      } else if (e is TimeoutException) {
        throw Exception("Request timed out. Please try again.");
      } else if (e is FormatException) {
        throw Exception("Invalid response from server.");
      } else {
        throw Exception("Unexpected error occurred. Please try again.");
      }
    }
  }
}
