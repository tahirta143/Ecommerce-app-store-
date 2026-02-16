class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final List<ProductImage> images;
  final String category;
  final int stock;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.category,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
  });

  // Get primary image URL (first image or empty string)
  String get primaryImageUrl => images.isNotEmpty ? images.first.url : '';

  // Get primary image alt text
  String get primaryImageAlt => images.isNotEmpty ? images.first.alt : title;

  // Check if product is in stock
  bool get inStock => stock > 0;

  // Factory method to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      images: (json['images'] as List? ?? [])
          .map((imageJson) => ProductImage.fromJson(imageJson))
          .toList(),
      category: json['category'] ?? '',
      stock: json['stock'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'price': price,
      'images': images.map((image) => image.toJson()).toList(),
      'category': category,
      'stock': stock,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create a copy of Product with updated fields
  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    List<ProductImage>? images,
    String? category,
    int? stock,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProductImage {
  final String publicId;
  final String url;
  final String alt;
  final String id;

  ProductImage({
    required this.publicId,
    required this.url,
    required this.alt,
    required this.id,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      publicId: json['public_id'] ?? '',
      url: json['url'] ?? '',
      alt: json['alt'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'public_id': publicId,
      'url': url,
      'alt': alt,
      '_id': id,
    };
  }
}

// API Response Models
class ProductsResponse {
  final bool success;
  final int count;
  final List<Product> data;

  ProductsResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }
}

class ProductResponse {
  final bool success;
  final Product? data;

  ProductResponse({
    required this.success,
    this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? Product.fromJson(json['data']) : null,
    );
  }
}