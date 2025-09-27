class ProductDataModel {
  final String id;
  final String productname;
  final double price;
  final double prevprice;
  final DateTime createdat;
  final String description;
  final Category category;

  ProductDataModel({
    required this.id,
    required this.productname,
    required this.price,
    required this.prevprice,
    required this.createdat,
    required this.description,
    required this.category,
  });

  ProductDataModel copyWith({
    String? id,
    String? productname,
    double? price,
    double? prevprice,
    DateTime? createdat,
    String? description,
    Category? category,
  }) => ProductDataModel(
    id: id ?? this.id,
    productname: productname ?? this.productname,
    price: price ?? this.price,
    prevprice: prevprice ?? this.prevprice,
    createdat: createdat ?? this.createdat,
    description: description ?? this.description,
    category: category ?? this.category,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductDataModel &&
        other.id == id &&
        other.productname == productname &&
        other.description == description &&
        other.category == category &&
        other.createdat == createdat &&
        other.prevprice == prevprice &&
        other.price == price;
  }

  /// Convert from Map to ProductDataModel
  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
      id: map['id'] as String,
      productname: map['productname'] as String,
      price: (map['price'] as num).toDouble(),
      prevprice: (map['prevprice'] as num).toDouble(),
      createdat: DateTime.parse(map['createdat'] as String),
      description: map['description'] as String,
      category: Category.values.firstWhere(
        (e) =>
            e.name.toUpperCase() == (map['category'] as String).toUpperCase(),
        orElse: () => Category.food, // default if not matched
      ),
    );
  }

  /// Convert ProductDataModel to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productname': productname,
      'price': price,
      'prevprice': prevprice,
      'createdat': createdat.toIso8601String(),
      'description': description,
      'category': category.name, // stores enum as string
    };
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productname.hashCode ^
        description.hashCode ^
        category.hashCode ^
        createdat.hashCode ^
        prevprice.hashCode ^
        price.hashCode;
  }
}

enum Category { cloths, electronics, food, vegetable }
