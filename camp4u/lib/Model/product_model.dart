class Product {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  final String? brand;
  final double? conditionRating;
  final double pricePerDay;
  final double? depositAmount;
  final int? stockQuantity;
  final String? specifications;
  final double? weight;
  final String? dimensions;
  final String? rentalTerms;
  final String imageUrl;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    this.brand,
    this.conditionRating = 5.0,
    required this.pricePerDay,
    this.depositAmount = 0.0,
    this.stockQuantity = 1,
    this.specifications,
    this.weight,
    this.dimensions,
    this.rentalTerms,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      categoryId: json['category_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      brand: json['brand'] as String?,
      conditionRating:
          json['condition_rating'] != null
              ? (json['condition_rating'] as num).toDouble()
              : 5.0,
      pricePerDay: (json['price_per_day'] as num).toDouble(),
      depositAmount:
          json['deposit_amount'] != null
              ? (json['deposit_amount'] as num).toDouble()
              : 0.0,
      stockQuantity: json['stock_quantity'] as int? ?? 1,
      specifications: json['specifications'] as String?,
      weight:
          json['weight'] != null ? (json['weight'] as num).toDouble() : null,
      dimensions: json['dimensions'] as String?,
      rentalTerms: json['rental_terms'] as String?,
      imageUrl:
          "assets/images/products/" + (json['image_url'] as String? ?? 'default.png'),
    );
  }
}
