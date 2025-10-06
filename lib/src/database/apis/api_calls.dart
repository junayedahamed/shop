import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ocad/src/database/apis/exceptions.dart';

import 'package:ocad/src/models/product_model/product_model.dart';

class ApiCalls {
  // ApiCalls._();

  final Exceptions exc = Exceptions();
  // int _maxtry = 10;
  // Future<List<ProductDataModel>> getData() async {
  //   int attempt = 0;
  //   while (attempt < _maxtry) {
  //     attempt++;
  //     try {
  //       final List<ProductDataModel> products = [];
  //       // log(products.isEmpty.toString());
  //       final uri = Uri.parse("${dotenv.env['GET_PRODUCTS']}");
  //       final http.Response response = await http.get(uri);
  //       // log(response.statusCode.toString());
  //       if (response.statusCode == 200) {
  //         final values = jsonDecode(response.body);
  //         // for (int i = 0; i < values.length; i++) {
  //         //   final data = ProductDataModel.fromMap(values[i]);
  //         //   products.add(data);
  //         // }
  //         products.addAll(
  //           values.map<ProductDataModel>((item) {
  //             return ProductDataModel.fromMap(item);
  //           }).toList(),
  //         );
  //         // log(products.toString());
  //         return products;
  //       }
  //       return [];
  //     } catch (e) {
  //       if (e is SocketException) {
  //         if (e.osError?.message.contains("Failed host lookup") ?? false) {
  //           throw "Could not reach the server. Please try again later.";
  //         }
  //         throw "No internet connection.";
  //       } else if (e is TimeoutException) {
  //         throw "Request timed out. Please try again.";
  //       } else if (e is FormatException) {
  //         throw "Invalid response from server.";
  //       } else {
  //         // throw "Unexpected error occurred. Please try again.";
  //         rethrow;
  //       }
  //     }

  //   }
  //   return [];
  // }

  final int _maxTry = 5;

  Future<List<ProductDataModel>> getData() async {
    int attempt = 0;

    while (attempt < _maxTry) {
      attempt++;
      try {
        final uri = Uri.parse("${dotenv.env['GET_PRODUCTS']}");
        final response = await http
            .get(uri)
            .timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          final values = jsonDecode(response.body);
          return values
              .map<ProductDataModel>((v) => ProductDataModel.fromMap(v))
              .toList();
        } else {
          throw Exception("Server error: ${response.statusCode}");
        }
      } on SocketException catch (e) {
        if (attempt >= _maxTry) {
          if (e.osError?.message.contains("Failed host lookup") ?? false) {
            throw "Could not reach the server. Please try again later.";
          }
          throw "No internet connection.";
        }
        await Future.delayed(const Duration(seconds: 3));
      } on TimeoutException {
        if (attempt >= _maxTry) {
          throw "Request timed out. Please try again.";
        }
        await Future.delayed(const Duration(seconds: 3));
      } on FormatException {
        throw "Invalid response from server.";
      } catch (e) {
        rethrow; // unexpected errors → don't retry
      }
    }

    return []; // fallback if somehow all retries fail
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
      // log(dotenv.env['GET_ITEM_CART'].toString());

      final response = await http.get(
        url,
        // headers: {
        //   "Content-Type": "application/json",
        //   "Accept": "application/json",
        // },
      );
      // log(response.statusCode.toString());

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
  //add to cart
  //add to cart

  Future<String> addItemToCart(String useremail, String productId) async {
    try {
      final url = Uri.parse("${dotenv.env['ADDTOCART']}");
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

  //remove from Cart
  //remove from Cart
  //remove from Cart
  Future<String> rmoveItemFromCart(String useremail, String productId) async {
    try {
      final url = Uri.parse(
        "${dotenv.env['REMOVE_FROM_CART']}/$productId/$useremail",
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

  ///Generics[ ApiCalls ]
  ///
  ///

  // Future<List<ProductDataModel>> getItems({
  //   required String url,
  //   String? userEmail,
  // }) async {
  //   try {
  //     final List<ProductDataModel> products = [];
  //     // log(products.isEmpty.toString());
  //     var uri = Uri.parse('');
  //     if (userEmail == null) {
  //       log((userEmail?.isEmpty).toString());
  //       uri = Uri.parse(url);
  //     } else {
  //       uri = Uri.parse("$uri/$userEmail");
  //       log(uri.toString());
  //     }
  //     print(uri);
  //     final http.Response response = await http.get(
  //       uri,
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Accept": "application/json",
  //       },
  //     );
  //     // log(response.statusCode.toString());
  //     if (response.statusCode == 200) {
  //       final values = jsonDecode(response.body);
  //       for (int i = 0; i < values.length; i++) {
  //         final data = ProductDataModel.fromMap(values[i]);
  //         products.add(data);
  //       }
  //       // log(products.toString());
  //       return products;
  //     }
  //     return [];
  //   } catch (e) {
  //     throw exc.handleGetApiException(e);
  //   }
  // }

  // ///Post
  // ///
  // ///
  // Future<String> addItem({
  //   required String uri,
  //   required String useremail,
  //   required String productId,
  // }) async {
  //   try {
  //     final url = Uri.parse(uri);
  //     //   log(dotenv.env['ADDTOFAV'].toString());

  //     final response = await http.post(
  //       url,
  //       headers: {
  //         "Content-Type": "application/json", // 👈 important
  //         "Accept": "application/json",
  //       },
  //       body: jsonEncode({"userEmail": useremail, "productId": productId}),
  //     );
  //     // log(response.statusCode.toString());

  //     if (response.statusCode == 200) {
  //       final message = jsonDecode(response.body)['message'].toString();
  //       return message;
  //     } else {
  //       return "Some Problem occoured";
  //     }
  //   } catch (e) {
  //     throw exc.handlePostApiException(e);
  //   }
  // }

  // ///delete api
  // ///
  // ///

  // Future<String> rmoveItem(
  //   String uri,
  //   String useremail,
  //   String productId,
  // ) async {
  //   try {
  //     final url = Uri.parse("$uri/$productId/$useremail");
  //     //   log(dotenv.env['ADDTOFAV'].toString());

  //     final response = await http.delete(
  //       url,
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Accept": "application/json",
  //       },
  //     );
  //     // log(response.statusCode.toString());

  //     if (response.statusCode == 200) {
  //       final message = jsonDecode(response.body)['message'].toString();
  //       return message;
  //     } else {
  //       return "Some Problem occoured";
  //     }
  //   } catch (e) {
  //     throw exc.handleDeleteApiException(e);
  //   }
  // }
}
