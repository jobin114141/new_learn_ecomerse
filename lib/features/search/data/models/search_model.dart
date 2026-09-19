class ProductResponse {
  final int totalSize;
  final int limit;
  final int offset;
  final double lowestPrice;
  final double highestPrice;
  final dynamic flashDeal;
  final List<Product> products;

  ProductResponse({
    required this.totalSize,
    required this.limit,
    required this.offset,
    required this.lowestPrice,
    required this.highestPrice,
    this.flashDeal,
    required this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      totalSize: int.tryParse(json['total_size']?.toString() ?? '0') ?? 0,
      limit: int.tryParse(json['limit']?.toString() ?? '0') ?? 0,
      offset: int.tryParse(json['offset']?.toString() ?? '0') ?? 0,
      lowestPrice: double.tryParse(json['lowest_price']?.toString() ?? '0') ?? 0.0,
      highestPrice: double.tryParse(json['highest_price']?.toString() ?? '0') ?? 0.0,
      flashDeal: json['flash_deal'],
      products: (json['products'] as List? ?? [])
          .map((e) => Product.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_size': totalSize,
      'limit': limit,
      'offset': offset,
      'lowest_price': lowestPrice,
      'highest_price': highestPrice,
      'flash_deal': flashDeal,
      'products': products.map((e) => e.toJson()).toList(),
    };
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final List<String> image;
  final double price;
  final double tax;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> attributes;
  final List<CategoryId> categoryIds;
  final double discount;
  final double weight;
  final String discountType;
  final String taxType;
  final String unit;
  final double capacity;
  final int totalStock;
  final int maximumOrderQuantity;
  final List<Variation> variations;
  final List<ChoiceOption> choiceOptions;
  final List<Rating> rating;
  final List<Review> activeReviews;
  final CategoryDiscount? categoryDiscount;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.tax,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.attributes,
    required this.categoryIds,
    required this.discount,
    required this.weight,
    required this.discountType,
    required this.taxType,
    required this.unit,
    required this.capacity,
    required this.totalStock,
    required this.maximumOrderQuantity,
    required this.variations,
    required this.choiceOptions,
    required this.rating,
    required this.activeReviews,
    this.categoryDiscount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',

      image: (json['image'] as List? ?? []).map((e) => e.toString()).toList(),

      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      tax: double.tryParse(json['tax']?.toString() ?? '0') ?? 0.0,

      status: int.tryParse(json['status']?.toString() ?? '0') ?? 0,

      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,

      attributes: (json['attributes'] as List? ?? []).map((e) => e.toString()).toList(),

      categoryIds: (json['category_ids'] as List? ?? [])
          .map((e) => CategoryId.fromJson(e))
          .toList(),

      discount: double.tryParse(json['discount']?.toString() ?? '0') ?? 0.0,
      weight: double.tryParse(json['weight']?.toString() ?? '0') ?? 0.0,

      discountType: json['discount_type'] ?? '',
      taxType: json['tax_type'] ?? '',
      unit: json['unit'] ?? '',

      capacity: double.tryParse(json['capacity']?.toString() ?? '0') ?? 0.0,

      totalStock: int.tryParse(json['total_stock']?.toString() ?? '0') ?? 0,
      maximumOrderQuantity: int.tryParse(json['maximum_order_quantity']?.toString() ?? '0') ?? 0,

      variations: (json['variations'] as List? ?? [])
          .map((e) => Variation.fromJson(e))
          .toList(),

      choiceOptions: (json['choice_options'] as List? ?? [])
          .map((e) => ChoiceOption.fromJson(e))
          .toList(),

      rating: (json['rating'] as List? ?? [])
          .map((e) => Rating.fromJson(e))
          .toList(),

      activeReviews: (json['active_reviews'] as List? ?? [])
          .map((e) => Review.fromJson(e))
          .toList(),

      categoryDiscount: json['category_discount'] != null
          ? CategoryDiscount.fromJson(json['category_discount'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'tax': tax,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'attributes': attributes,
      'category_ids': categoryIds.map((e) => e.toJson()).toList(),
      'discount': discount,
      'weight': weight,
      'discount_type': discountType,
      'tax_type': taxType,
      'unit': unit,
      'capacity': capacity,
      'total_stock': totalStock,
      'maximum_order_quantity': maximumOrderQuantity,
      'variations': variations.map((e) => e.toJson()).toList(),
      'choice_options': choiceOptions.map((e) => e.toJson()).toList(),
      'rating': rating.map((e) => e.toJson()).toList(),
      'active_reviews': activeReviews.map((e) => e.toJson()).toList(),
      'category_discount': categoryDiscount?.toJson(),
    };
  }
}

class CategoryId {
  final String id;

  CategoryId({
    required this.id,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) {
    return CategoryId(
      id: json['id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}

class Variation {
  final String type;
  final double price;
  final int stock;

  Variation({
    required this.type,
    required this.price,
    required this.stock,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      type: json['type'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      stock: json['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'price': price,
      'stock': stock,
    };
  }
}

class ChoiceOption {
  final String name;
  final String title;
  final List<String> options;

  ChoiceOption({
    required this.name,
    required this.title,
    required this.options,
  });

  factory ChoiceOption.fromJson(Map<String, dynamic> json) {
    return ChoiceOption(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      options: List<String>.from(json['options'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'options': options,
    };
  }
}

class Rating {
  final double average;

  Rating({
    required this.average,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: double.tryParse(json['average']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'average': average,
    };
  }
}

class Review {
  final int id;
  final int productId;
  final int userId;
  final String comment;
  final int rating;
  final int isActive;
  final Customer customer;

  Review({
    required this.id,
    required this.productId,
    required this.userId,
    required this.comment,
    required this.rating,
    required this.isActive,
    required this.customer,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      comment: json['comment'] ?? '',
      rating: json['rating'] ?? 0,
      isActive: json['is_active'] ?? 0,
      customer: Customer.fromJson(json['customer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'user_id': userId,
      'comment': comment,
      'rating': rating,
      'is_active': isActive,
      'customer': customer.toJson(),
    };
  }
}

class Customer {
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  Customer({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      firstName: json['f_name'] ?? '',
      lastName: json['l_name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'f_name': firstName,
      'l_name': lastName,
      'email': email,
      'image': image,
    };
  }
}

class CategoryDiscount {
  final String id;
  final String categoryId;
  final String discountType;
  final double discountAmount;
  final double maximumAmount;

  CategoryDiscount({
    required this.id,
    required this.categoryId,
    required this.discountType,
    required this.discountAmount,
    required this.maximumAmount,
  });

  factory CategoryDiscount.fromJson(Map<String, dynamic> json) {
    return CategoryDiscount(
      id: json['id']?.toString() ?? '',
      categoryId: json['category_id']?.toString() ?? '',
      discountType: json['discount_type'] ?? '',
      discountAmount: double.tryParse(json['discount_amount']?.toString() ?? '0') ?? 0.0,
      maximumAmount: double.tryParse(json['maximum_amount']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'discount_type': discountType,
      'discount_amount': discountAmount,
      'maximum_amount': maximumAmount,
    };
  }
}