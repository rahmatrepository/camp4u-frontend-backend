class CartItem {
  final int? id;
  final int userId;
  final int productId;
  final String name;
  final double price;
  final String image;
  int quantity;
  bool isSelected;
  DateTime startDate;
  DateTime endDate;
  double subtotal;

  CartItem({
    this.id,
    required this.userId,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    this.isSelected = false,
    required this.startDate,
    required this.endDate,
    required this.subtotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as int?,
      userId: json['user_id'] as int,
      productId: json['product_id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      quantity: json['quantity'] as int,
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      subtotal: (json['subtotal'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'subtotal': subtotal,
    };
  }
}
