import 'package:my_ecomerse/features/home/data/models/feature_model.dart'; // Contains Product

class WishListModel {
  final int? totalSize;
  final String? limit;
  final String? offset;
  final List<Product> products;

  WishListModel({
    this.totalSize,
    this.limit,
    this.offset,
    required this.products,
  });

  factory WishListModel.fromJson(dynamic json) {
    // 1. If backend returns an Object wrapper: { "total_size": 5, "products": [...] }
    if (json is Map<String, dynamic>) {
      return WishListModel(
        totalSize: int.tryParse('${json['total_size']}'),
        limit: json['limit']?.toString(),
        offset: json['offset']?.toString(),
        products: json['products'] != null
            ? (json['products'] as List).map((v) => Product.fromJson(v)).toList()
            : [],
      );
    }
    
    // 2. If backend returns a Direct JSON List: [ { "id": 1, ... }, { "id": 2, ... } ]
    if (json is List) {
      return WishListModel(
        products: json.map((v) => Product.fromJson(v)).toList(),
      );
    }

    return WishListModel(products: []);
  }

  Map<String, dynamic> toJson() {
    return {
      'total_size': totalSize,
      'limit': limit,
      'offset': offset,
      'products': products.map((v) => v.toJson()).toList(),
    };
  }
}
