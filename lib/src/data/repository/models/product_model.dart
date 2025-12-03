class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    this.isFavorite = false,
  });

  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? thumbnail,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory ProductModel.fromMap(dynamic map) {
    return ProductModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      thumbnail: map['thumbnail'] as String,
    );
  }
}
