import 'package:ocad/src/product_model/product_model.dart';

class RuntimeData {
  final List<ProductDataModel> _fav = [];

  final List<ProductDataModel> _cart = [];

  final List<ProductDataModel> _products = [];

  List<ProductDataModel> get products => _products;
  List<ProductDataModel> get favorite => _fav;
  List<ProductDataModel> get cart => _cart;

  set setdataTofav(ProductDataModel data) {
    _fav.add(data);
  }

  set setManydataTofav(List<ProductDataModel> data) {
    _fav.addAll(data);
  }

  set setdataToCart(ProductDataModel data) {
    _cart.add(data);
  }

  set setAlldataToCart(List<ProductDataModel> data) {
    _cart.addAll(data);
  }

  set setAllDataToProduct(List<ProductDataModel> data) {
    _products.addAll(data);
  }

  set setDataToProduct(ProductDataModel data) {
    _products.add(data);
  }
}
