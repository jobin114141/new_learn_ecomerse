import 'package:my_ecomerse/core/constants/api_endpoints.dart';

class BannerModel {
  final int id;
  final String title;
  final String image;
  final int? productId;
  final int? categoryId;
  final int status;
  final String? createdAt;
  final String? updatedAt;

  BannerModel({
    required this.id,
    required this.title,
    required this.image,
    this.productId,
    this.categoryId,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  String get fullImageUrl =>
      image.startsWith('http') ? image : '${ApiEndpoints.bannerStorageUrl}$image';

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as int,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      productId: json['product_id'] as int?,
      categoryId: json['category_id'] as int?,
      status: json['status'] ?? 1,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'product_id': productId,
      'category_id': categoryId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
