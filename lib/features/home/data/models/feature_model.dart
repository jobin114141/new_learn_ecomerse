import 'package:my_ecomerse/core/constants/api_endpoints.dart';

class ProductModel {
  int? totalSize;
  int? limit;
  int? offset;
  double? minPrice;
  double? maxPrice;
  List<Product>? products;

  ProductModel({
    this.totalSize,
    this.limit,
    this.offset,
    this.minPrice,
    this.maxPrice,
    this.products,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      totalSize: int.tryParse('${json['total_size']}'),
      limit: int.tryParse('${json['limit']}'),
      offset: int.tryParse('${json['offset']}'),
      minPrice: double.tryParse('${json['lowest_price']}'),
      maxPrice: double.tryParse('${json['highest_price']}'),
      products: json['products'] != null
          ? (json['products'] as List).map((v) => Product.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_size': totalSize,
      'limit': limit,
      'offset': offset,
      'lowest_price': minPrice,
      'highest_price': maxPrice,
      'products': products?.map((v) => v.toJson()).toList(),
    };
  }
}

class Product {
  final int id;
  final String name;
  final String? description;
  final List<String> image;
  final double price;
  final double discount;
  final String? discountType;
  final double tax;
  final String? taxType;
  final String? unit;
  final double? capacity;
  final int? totalStock;
  final int status;
  final List<CategoryIds>? categoryIds;
  final List<Variations>? variations;
  final String? createdAt;
  final String? updatedAt;

  Product({
    required this.id,
    required this.name,
    this.description,
    required this.image,
    required this.price,
    this.discount = 0.0,
    this.discountType,
    this.tax = 0.0,
    this.taxType,
    this.unit,
    this.capacity,
    this.totalStock,
    required this.status,
    this.categoryIds,
    this.variations,
    this.createdAt,
    this.updatedAt,
  });

  String get fullImageUrl {
    if (image.isEmpty) return '';
    final img = image.first;
    if (img.startsWith('http://') || img.startsWith('https://')) {
      return img;
    }
    return '${ApiEndpoints.productStorageUrl}$img';
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] ?? '',
      description: json['description'],
      image: (json['image'] is List)
          ? List<String>.from(json['image'])
          : [],
      price: (json['price'] as num).toDouble(),
      discount: json['discount'] != null ? (json['discount'] as num).toDouble() : 0.0,
      discountType: json['discount_type'],
      tax: json['tax'] != null ? (json['tax'] as num).toDouble() : 0.0,
      taxType: json['tax_type'],
      unit: json['unit'],
      capacity: json['capacity'] != null ? (json['capacity'] as num).toDouble() : null,
      totalStock: json['total_stock'] as int?,
      status: json['status'] ?? 1,
      categoryIds: json['category_ids'] != null
          ? (json['category_ids'] as List).map((v) => CategoryIds.fromJson(v)).toList()
          : null,
      variations: json['variations'] != null
          ? (json['variations'] as List).map((v) => Variations.fromJson(v)).toList()
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'discount': discount,
      'discount_type': discountType,
      'tax': tax,
      'tax_type': taxType,
      'unit': unit,
      'capacity': capacity,
      'total_stock': totalStock,
      'status': status,
      'category_ids': categoryIds?.map((v) => v.toJson()).toList(),
      'variations': variations?.map((v) => v.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class CategoryIds {
  final String? id;
  final int? position;

  CategoryIds({this.id, this.position});

  factory CategoryIds.fromJson(Map<String, dynamic> json) {
    return CategoryIds(
      id: json['id']?.toString(),
      position: json['position'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'position': position};
}

class Variations {
  final String? type;
  final double? price;
  final int? stock;

  Variations({this.type, this.price, this.stock});

  factory Variations.fromJson(Map<String, dynamic> json) {
    return Variations(
      type: json['type'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      stock: json['stock'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {'type': type, 'price': price, 'stock': stock};
}
